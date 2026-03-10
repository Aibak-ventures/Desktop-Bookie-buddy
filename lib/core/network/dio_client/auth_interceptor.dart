import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:bookie_buddy_web/core/app_dependencies.dart';
import 'package:bookie_buddy_web/utils/extensions/context_extensions.dart';
import 'package:bookie_buddy_web/core/navigation/navigations.dart';
import 'package:bookie_buddy_web/core/network/dio_client/dio_config.dart';
import 'package:bookie_buddy_web/core/repositories/auth_repository.dart';
import 'package:bookie_buddy_web/core/services/auth_service.dart';
import 'package:bookie_buddy_web/core/storage/shared_preference_helper.dart';
import 'package:bookie_buddy_web/core/storage/token_storage.dart';
import 'package:bookie_buddy_web/core/ui/widgets/custom_snack_bar.dart';
import 'package:bookie_buddy_web/utils/safe_api_call.dart';
import 'package:bookie_buddy_web/features/auth/view/login_screen.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class _QueuedRequest {
  final Completer<RequestOptions> completer;
  final RequestOptions requestOptions;
  _QueuedRequest(this.completer, this.requestOptions);
}

class AuthInterceptor extends Interceptor {
  static bool _isRefreshing = false;
  static final List<_QueuedRequest> _requestQueue = [];
  static bool _isSessionExpiredDialogShowing = false;
  static Timer? _refreshTimer;
  // Ensures we handle session expiry UX only once until reset
  static bool _hasHandledSessionExpiry = false;

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // handler.reject(DioException.badResponse(
    //   statusCode: 503,
    //   requestOptions: options.copyWith(
    //     validateStatus: (status) {
    //       if (status == null) return false;

    //       if (status == 401) return false;
    //       return true;
    //     },
    //   ),
    //   response: Response(
    //     requestOptions: RequestOptions(
    //       validateStatus: (status) {
    //         if (status == null) return false;

    //         if (status == 401) return false;
    //         return true;
    //       },
    //     ),
    //   ),
    // ));

    // Skip auth for specific endpoints
    if (_isAuthEndpoint(options.path)) {
      log('Skipping auth for ${options.path}');
      handler.next(options);
      return;
    }
    final token = TokenStorage.accessToken;

    final shopId = getIt.get<SharedPreferenceHelper>().getShopId;
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
      if (shopId != null) {
        options.headers['X-Active-Shop-ID'] = shopId;
      }
    }

    // Sanitize sensitive headers in logs
    final sanitizedHeaders = Map.of(options.headers);
    if (sanitizedHeaders['Authorization'] != null) {
      sanitizedHeaders['Authorization'] = 'Bearer ***';
    }
    // log('Request: ${options.method} ${options.path}, Headers: $sanitizedHeaders');
    // handler.next(options);
    // log('validation status: ${options.validateStatus(401)}');
    handler.next(
      options.copyWith(
        validateStatus: (status) {
          if (status == null) return false;

          if (status == 401 || status > 502) return false;
          return true;
        },
      ),
    );
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (response.statusCode == 401 &&
        !_isAuthEndpoint(response.requestOptions.path)) {
      handler.reject(
        DioException(
          requestOptions: response.requestOptions,
          response: response,
          type: DioExceptionType.badResponse,
          message: 'Unauthorized',
        ),
      );
      return;
    }
    // handler.next(response);
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    log(
      'HTTP Error - Status: ${err.response?.statusCode}, Type: ${err.type}, Message: ${err.message}',
    );

    // Handle network connectivity issues
    await _handleNetworkErrors(err);

    // Handle 401 unauthorized errors
    if (err.response?.statusCode == 401 &&
        !_isAuthEndpoint(err.requestOptions.path)) {
      // If there is no refresh token, the user isn't logged in yet (fresh install/logged out).
      // Don't show session-expired UX or attempt refresh; let the caller route to login/onboarding.
      final hasRefreshToken = TokenStorage.refreshToken?.isNotEmpty ?? false;
      if (!hasRefreshToken) {
        log(
          '401 received without refresh token — likely first launch or logged-out state. Skipping session-expired handling.',
        );
        handler.next(err);
        return;
      }
      // Short-circuit known unrecoverable cases
      final data = err.response?.data;
      final serverCode = data is Map ? data['code'] : null;
      final detail = data is Map ? (data['detail'] ?? data['message']) : null;
      if (serverCode == 'user_inactive' || detail == 'User is inactive') {
        // If we've already handled expiry, don't show again
        if (!_hasHandledSessionExpiry) {
          await _handleSessionExpired();
        }
        handler.next(err);
        return;
      }
      // If we've already handled expiry elsewhere, skip further handling
      if (_hasHandledSessionExpiry) {
        handler.next(err);
        return;
      }
      await _handle401Error(err, handler);
      return; // Important: return early to prevent calling handler.next()
    }

    // Handle other HTTP errors
    _handleOtherErrors(err);

    handler.next(err);
  }

  bool _isAuthEndpoint(String path) {
    final authPaths = [
      '/login',
      // '/register',
      '/refresh',
      '/forgot-password',
    ];
    return authPaths.any((authPath) => path.contains(authPath));
  }

  Future<void> _handleNetworkErrors(DioException err) async {
    if (err.type == DioExceptionType.connectionTimeout ||
        err.type == DioExceptionType.sendTimeout ||
        err.type == DioExceptionType.receiveTimeout) {
      _showNetworkError(
        'Request timeout. Please check your connection and try again.',
      );
      return;
    }

    if (err.type == DioExceptionType.connectionError) {
      try {
        final connectivityResults = await Connectivity().checkConnectivity();

        if (connectivityResults.contains(ConnectivityResult.none)) {
          _showNetworkError(
            'No internet connection. Please check your network settings.',
          );
        } else {
          _showNetworkError(
            'Server connection failed. Please try again later.',
          );
        }
      } catch (e) {
        log('Connectivity check failed: $e');
        _showNetworkError('Network error occurred. Please try again.');
      }
    }
  }

  void _showNetworkError(String message) {
    CustomSnackBar(title: 'Network Error', message: message);
  }

  Future<void> _handle401Error(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    log('401 Unauthorized - Attempting token refresh');

    // If already refreshing, queue the request
    if (_isRefreshing) {
      log('Token refresh already in progress, queuing request');
      final completer = Completer<RequestOptions>();
      // Preserve original request options for retry after refresh
      _requestQueue.add(_QueuedRequest(completer, err.requestOptions));

      try {
        // Wait for refresh to complete with timeout
        final retriedOptions = await completer.future.timeout(
          const Duration(seconds: 10),
          onTimeout: () => throw TimeoutException('Refresh queue timeout'),
        );

        // Retry with updated token
        await _retryWithNewToken(retriedOptions, handler);
        return;
      } catch (e) {
        log('Queued refresh timeout or failed: $e');
        await _handleSessionExpired();
        handler.next(err);
        return;
      }
    }

    _isRefreshing = true;
    _refreshTimer?.cancel();
    _refreshTimer = Timer(const Duration(seconds: 10), () {
      if (_isRefreshing) {
        log('Token refresh timeout - forcing completion');
        _completeRefreshProcess(false);
      }
    });
    bool refreshSuccess = false;
    try {
      refreshSuccess = await _attemptTokenRefresh();

      if (refreshSuccess) {
        log('Token refresh successful, retrying original request');
        await _retryOriginalRequest(err, handler);
      } else {
        log('Token refresh failed, handling session expiry');
        await _handleSessionExpired();
        handler.next(err);
      }
    } catch (e) {
      log('Token refresh process failed: $e');
      await _handleSessionExpired();
      handler.next(err);
    } finally {
      _completeRefreshProcess(refreshSuccess);
    }
  }

  void _completeRefreshProcess(bool success) {
    _refreshTimer?.cancel();
    _isRefreshing = false;

    // Process queued requests
    for (final queued in _requestQueue) {
      if (!queued.completer.isCompleted) {
        if (success) {
          // Update the request with new token
          final token = TokenStorage.accessToken;
          if (token != null && token.isNotEmpty) {
            // Complete with updated options
            queued.completer.complete(queued.requestOptions);
          } else {
            queued.completer.completeError('No valid token after refresh');
          }
        } else {
          queued.completer.completeError('Token refresh failed');
        }
      }
    }
    _requestQueue.clear();
  }

  Future<bool> _attemptTokenRefresh() async {
    try {
      final refreshToken = TokenStorage.refreshToken;
      if (refreshToken == null || refreshToken.isEmpty) {
        log('No refresh token available');
        return false;
      }

      final isRefreshed = await getIt<AuthRepository>().refreshToken();
      final newAccessToken = TokenStorage.accessToken;

      if (isRefreshed && newAccessToken != null && newAccessToken.isNotEmpty) {
        log('Token refresh completed successfully');
        return true;
      } else {
        log('Token refresh returned false or invalid token');
        return false;
      }
    } catch (e) {
      log('Token refresh exception: $e');
      return false;
    }
  }

  Future<void> _retryOriginalRequest(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    try {
      final newAccessToken = TokenStorage.accessToken;
      if (newAccessToken == null || newAccessToken.isEmpty) {
        throw 'No valid access token after refresh';
      }

      // Create a new Dio instance for retry to avoid interceptor loops
      final retryDio = _createRetryDio();

      // Retry the original request
      final response = await retryDio.request(
        err.requestOptions.path,
        options: Options(
          method: err.requestOptions.method,
          headers: {
            ...err.requestOptions.headers,
            'Authorization': 'Bearer $newAccessToken',
          },
          responseType: err.requestOptions.responseType,
          contentType: err.requestOptions.contentType,
          receiveTimeout: err.requestOptions.receiveTimeout,
          sendTimeout: err.requestOptions.sendTimeout,
          validateStatus: err.requestOptions.validateStatus,
        ),
        data: err.requestOptions.data,
        queryParameters: err.requestOptions.queryParameters,
      );

      log('Original request retry successful');
      handler.resolve(response);
    } on DioException catch (e) {
      log('Retry failed with DioException: ${e.response?.statusCode}');

      if (e.response?.statusCode == 401) {
        log('Retry failed with 401 again — session is truly expired');
        await _handleSessionExpired();
      }
      handler.next(e);
    } catch (e, stack) {
      log('Retry exception: $e\n$stack');
      handler.next(err);
    }
  }

  Future<void> _retryWithNewToken(
    RequestOptions options,
    ErrorInterceptorHandler handler,
  ) async {
    try {
      final newAccessToken = TokenStorage.accessToken;
      if (newAccessToken == null || newAccessToken.isEmpty) {
        throw 'No valid access token after refresh';
      }

      final retryDio = _createRetryDio();

      final response = await safeApiCall(
        () => retryDio.request(
          options.path,
          options: Options(
            method: options.method,
            headers: {
              ...options.headers,
              'Authorization': 'Bearer $newAccessToken',
            },
            responseType: options.responseType,
            contentType: options.contentType,
            receiveTimeout: options.receiveTimeout,
            sendTimeout: options.sendTimeout,
            validateStatus: options.validateStatus,
          ),
          data: options.data,
          queryParameters: options.queryParameters,
        ),
      );

      handler.resolve(response);
    } catch (e) {
      log('Queued request retry failed: $e');
      handler.next(DioException(requestOptions: options, error: e));
    }
  }

  Dio _createRetryDio() {
    final retryDio = Dio(
      BaseOptions(
        baseUrl: DioClient.dio.options.baseUrl,
        connectTimeout: DioClient.dio.options.connectTimeout,
        receiveTimeout: DioClient.dio.options.receiveTimeout,
        headers: DioClient.dio.options.headers,
        validateStatus: DioClient.dio.options.validateStatus,
      ),
    );

    if (kDebugMode) {
      final adapter = retryDio.httpClientAdapter;
      if (adapter is IOHttpClientAdapter) {
        adapter.createHttpClient = () {
          final client = HttpClient()
            ..badCertificateCallback = (cert, host, port) => true;

          return client;
        };
      }
    }

    return retryDio;
  }

  Future<void> _handleSessionExpired() async {
    // Prevent multiple triggers across concurrent 401s
    if (_hasHandledSessionExpiry) return;
    _hasHandledSessionExpiry = true;
    // Prevent multiple simultaneous dialogs
    if (_isSessionExpiredDialogShowing) return;
    _isSessionExpiredDialogShowing = true;

    final context = navigatorKey.currentContext;

    if (context?.mounted == true) {
      log('Showing session expired dialog');

      try {
        await showDialog(
          context: context!,
          barrierDismissible: false,
          builder: (dialogContext) => PopScope(
            canPop: false, // Prevent back button dismissal
            child: AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              title: Row(
                children: [
                  Icon(
                    Icons.warning_amber_rounded,
                    color: Theme.of(dialogContext).colorScheme.error,
                    size: 24,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'Session Expired',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              content: Text(
                'Your session has expired. Please log in again to continue.',
                style: TextStyle(fontSize: 16.sp),
              ),
              actions: [
                FilledButton(
                  onPressed: () => Navigator.of(dialogContext).pop(),
                  style: FilledButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text('OK'),
                ),
              ],
            ),
          ),
        );
      } catch (e) {
        log('Session expired dialog error: $e');
      } finally {
        _isSessionExpiredDialogShowing = false;
      }

      // Clear session and navigate to login
      if (context != null && context.mounted)
        await _clearSessionAndNavigate(context);
    } else {
      // Fallback to snackbar if context is not available
      _showSessionExpiredSnackbar();
      await _clearSession();
    }
  }

  void _showSessionExpiredSnackbar() {
    CustomSnackBar(
      title: 'Session Expired',
      message: 'Your session has expired. Please log in again.',
    );
  }

  Future<void> _clearSessionAndNavigate(BuildContext context) async {
    try {
      await AuthService.clearUserSession();
      if (context.mounted) {
        await context.pushAndRemoveUntil(LoginScreen());
      }
    } catch (e) {
      log('Error clearing session or navigating: $e');
    }
  }

  Future<void> _clearSession() async {
    try {
      await AuthService.clearUserSession();
    } catch (e) {
      log('Error clearing session: $e');
    }
  }

  void _handleOtherErrors(DioException err) {
    // Handle other HTTP status codes
    switch (err.response?.statusCode) {
      case 401:
        CustomSnackBar(
          title: 'Unauthorized',
          message: 'Unauthorized access. Please log in again.',
        );
        break;
      case 403:
        CustomSnackBar(
          title: 'Access Denied',
          message: "You don't have permission to access this resource.",
        );
        break;
      case 422:
        CustomSnackBar(
          title: 'Validation Error',
          message: 'Please check your input and try again.',
        );
        break;
      case 500:
      case 502:
      case 503:
        CustomSnackBar(
          title: 'Server Error',
          message:
              'Server is temporarily unavailable. Please try again later. Status code: ${err.response?.statusCode}',
        );
        break;
      default:
        if (err.response?.statusCode != null) {
          CustomSnackBar(
            title: 'Error ${err.response!.statusCode}',
            message: err.message ?? 'An unexpected error occurred.',
          );
        }
    }
  }

  // Cleanup method to cancel timers and clear queues
  static void dispose() {
    _refreshTimer?.cancel();
    _refreshTimer = null;
    _isRefreshing = false;

    // Complete any pending requests with error
    for (final queued in _requestQueue) {
      if (!queued.completer.isCompleted) {
        queued.completer.completeError('Interceptor disposed');
      }
    }
    _requestQueue.clear();
    _isSessionExpiredDialogShowing = false;
    _hasHandledSessionExpiry = false;
  }
}
