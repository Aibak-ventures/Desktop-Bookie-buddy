import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/foundation.dart';

import '../client/dio_client.dart';

class AuthInterceptor extends Interceptor {
  static bool _isRefreshing = false;
  static final List<Completer<RequestOptions>> _requestQueue = [];
  static bool _isSessionExpiredDialogShowing = false;
  static Timer? _refreshTimer;

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    // Skip auth for specific endpoints
    if (_isAuthEndpoint(options.path)) {
      return handler.next(options);
    }

    // Get access token from shared preferences
    // We'll implement this with service locator later
    final token = await _getAccessToken();

    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    log('HTTP Error - Status: ${err.response?.statusCode}, Type: ${err.type}, Message: ${err.message}');

    // Handle network connectivity issues
    await _handleNetworkErrors(err);

    // Handle 401 unauthorized errors
    if (err.response?.statusCode == 401 &&
        !_isAuthEndpoint(err.requestOptions.path)) {
      await _handle401Error(err, handler);
      return; // Important: return early to prevent calling handler.next()
    }

    // Handle other HTTP errors
    _handleOtherErrors(err);

    handler.next(err);
  }

  bool _isAuthEndpoint(String path) {
    final authPaths = ['/login', '/register', '/refresh', '/forgot-password'];
    return authPaths.any((authPath) => path.contains(authPath));
  }

  Future<String?> _getAccessToken() async {
    // TODO: Implement with service locator when available
    // For now return null
    return null;
  }

  Future<void> _handleNetworkErrors(DioException err) async {
    if (err.type == DioExceptionType.connectionTimeout ||
        err.type == DioExceptionType.sendTimeout ||
        err.type == DioExceptionType.receiveTimeout) {
      _showNetworkError(
          "Request timeout. Please check your connection and try again.");
      return;
    }

    if (err.type == DioExceptionType.connectionError) {
      try {
        final connectivityResults = await Connectivity().checkConnectivity();

        if (connectivityResults.contains(ConnectivityResult.none)) {
          _showNetworkError(
              "No internet connection. Please check your network settings.");
        } else {
          _showNetworkError(
              "Server connection failed. Please try again later.");
        }
      } catch (e) {
        log('Connectivity check failed: $e');
        _showNetworkError("Network error occurred. Please try again.");
      }
    }
  }

  void _showNetworkError(String message) {
    // TODO: Implement custom snackbar when available
    log('Network Error: $message');
  }

  Future<void> _handle401Error(
      DioException err, ErrorInterceptorHandler handler) async {
    log('401 Unauthorized - Attempting token refresh');

    // If already refreshing, queue the request
    if (_isRefreshing) {
      log('Token refresh already in progress, queuing request');
      final completer = Completer<RequestOptions>();
      _requestQueue.add(completer);

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
    for (final completer in _requestQueue) {
      if (!completer.isCompleted) {
        if (success) {
          // Complete with updated options
          completer.complete(RequestOptions(
            path: '', // This will be handled in retry logic
          ));
        } else {
          completer.completeError('Token refresh failed');
        }
      }
    }
    _requestQueue.clear();
  }

  Future<bool> _attemptTokenRefresh() async {
    try {
      // TODO: Implement with AuthService when available
      log('Token refresh not yet implemented');
      return false;
    } catch (e) {
      log('Token refresh exception: $e');
      return false;
    }
  }

  Future<void> _retryOriginalRequest(
      DioException err, ErrorInterceptorHandler handler) async {
    try {
      final newAccessToken = await _getAccessToken();
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
      RequestOptions options, ErrorInterceptorHandler handler) async {
    try {
      final newAccessToken = await _getAccessToken();
      if (newAccessToken == null || newAccessToken.isEmpty) {
        throw 'No valid access token after refresh';
      }

      final retryDio = _createRetryDio();

      final response = await retryDio.request(
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
        ),
        data: options.data,
        queryParameters: options.queryParameters,
      );

      handler.resolve(response);
    } catch (e) {
      log('Queued request retry failed: $e');
      handler.next(DioException(
        requestOptions: options,
        error: e,
      ));
    }
  }

  Dio _createRetryDio() {
    final retryDio = Dio(BaseOptions(
      baseUrl: DioClient.dio.options.baseUrl,
      connectTimeout: DioClient.dio.options.connectTimeout,
      receiveTimeout: DioClient.dio.options.receiveTimeout,
      headers: DioClient.dio.options.headers,
    ));

    if (kDebugMode && !kIsWeb) {
      (retryDio.httpClientAdapter as IOHttpClientAdapter).createHttpClient =
          () {
        final client = HttpClient();
        client.badCertificateCallback = (cert, host, port) => true;
        return client;
      };
    }

    return retryDio;
  }

  Future<void> _handleSessionExpired() async {
    // Prevent multiple simultaneous session expired dialogs
    if (_isSessionExpiredDialogShowing) {
      return;
    }

    log('Session expired - handling logout');
    // TODO: Implement navigation to login screen when available
  }

  void _handleOtherErrors(DioException err) {
    // Handle other HTTP status codes
    switch (err.response?.statusCode) {
      case 403:
        _showNetworkError("Access Denied: You don't have permission to access this resource.");
        break;
      case 422:
        _showNetworkError("Validation Error: Please check your input and try again.");
        break;
      case 500:
      case 502:
      case 503:
        _showNetworkError(
            "Server Error: Server is temporarily unavailable. Please try again later. Status code: ${err.response?.statusCode}");
        break;
      default:
        if (err.response?.statusCode != null) {
          _showNetworkError(
              "Error ${err.response!.statusCode}: ${err.message ?? "An unexpected error occurred."}");
        }
    }
  }

  // Cleanup method to cancel timers and clear queues
  static void dispose() {
    _refreshTimer?.cancel();
    _refreshTimer = null;
    _isRefreshing = false;

    // Complete any pending requests with error
    for (final completer in _requestQueue) {
      if (!completer.isCompleted) {
        completer.completeError('Interceptor disposed');
      }
    }
    _requestQueue.clear();
    _isSessionExpiredDialogShowing = false;
  }
}
