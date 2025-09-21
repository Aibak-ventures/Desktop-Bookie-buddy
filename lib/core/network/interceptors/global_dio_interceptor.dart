import 'package:booking_application/core/network/token/user_token.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

class GlobalDioInterceptor extends Interceptor {
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    debugPrint("🟡 Request: ${options.method} ${options.uri}");

    // ✅ Only add global headers if "Authorization" is missing
    if (!options.headers.containsKey('Authorization')) {
      final headers = await UserToken().getHeaders();
      options.headers.addAll(headers);
      debugPrint("🟡 Global Headers Applied: ${options.headers}");
    } else {
      debugPrint(
          "⚠️ Skipping Global Headers for ${options.uri}, using custom headers.");
    }

    debugPrint("🟡 Final Headers Sent: ${options.headers}");
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    debugPrint(
        "🟢 Response (${response.statusCode}): ${response.requestOptions.uri}");
        
    if (response.extra.containsKey("cacheHit")) {
      debugPrint("✅ Cache HIT: ${response.requestOptions.uri}");
    } else {
      debugPrint("❌ Cache MISS: ${response.requestOptions.uri}");
    }

    super.onResponse(response, handler);
  }

  @override
  Future<void> onError(
      DioException err, ErrorInterceptorHandler handler) async {
    debugPrint('DioInterceptor - Error intercepted');

    if (err.response != null) {
      final statusCode = err.response!.statusCode;
      debugPrint('DioInterceptor - Status Code: $statusCode');

      if (statusCode != null && statusCode >= 400) {
        // You can add Sentry capture here if needed
        // Sentry.captureException(...)

        if (statusCode >= 500) {
          // GoRouterProvider.navigatorKey.currentState
          //     ?.pushNamed('/network-error');
        } else if (statusCode == 401) {
          // debugPrint("⚠️ Global 401 detected. Attempting refresh...");

          // final refreshService = sl<TokenRefreshService>();
          // final success = await refreshService.refreshAccessToken();

          // if (success) {
          //   debugPrint("✅ Refresh succeeded. Retrying request...");
          //   final clonedRequest = await _retryRequest(err.requestOptions);
          //   handler.resolve(clonedRequest);
          //   return;
          // } else {
          //   debugPrint("❌ Refresh failed. Redirecting to auth.");
          //   GoRouterProvider.navigatorKey.currentState
          //       ?.pushNamed('/authentication');
          // }
        } else if (statusCode == 404) {
          // GoRouterProvider.navigatorKey.currentState?.pushNamed('/not-found');
        } else {
          // GoRouterProvider.navigatorKey.currentState?.pushNamed('/error');
        }
      }
    } else {
      debugPrint('DioInterceptor - No response received: ${err.message}');
      // You can add Sentry capture here if needed
      // GoRouterProvider.navigatorKey.currentState?.pushNamed('/network-error');
    }

    super.onError(err, handler);
  }

  Future<Response> _retryRequest(RequestOptions requestOptions) async {
    final dio = sl<Dio>(); // or reuse your configured Dio
    final headers = await UserToken().getHeaders();
    final newOptions = requestOptions.copyWith(headers: {
      ...requestOptions.headers,
      ...headers,
    });

    return await dio.fetch(newOptions);
  }
}
