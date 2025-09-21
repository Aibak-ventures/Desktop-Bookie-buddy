import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/foundation.dart';
import '../../env/env_config.dart';
import '../interceptors/auth_interceptor.dart';

class DioClient {
  /// A dio client with a base url and an auth interceptor
  /// The auth interceptor is responsible for adding the token to the request
  /// and for logging out the user when the token is invalid
  static final Dio dio = Dio(
    BaseOptions(
      baseUrl: EnvConfig.apiBaseUrl,
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
      followRedirects: false, // Prevent POST to GET conversion on redirects
      headers: {
        'Accept': 'application/json',
      },
      validateStatus: (status) {
        if (status == null) return false;
        if (status == 401 || status >= 500) return false;
        return true;
      },
    ),
  )..interceptors.addAll([
      AuthInterceptor(),
      if (kDebugMode)
        LogInterceptor(
          requestBody: true,
          responseBody: true,
          error: true,
          logPrint: (obj) => print(obj.toString()),
        ),
    ]);

  static Dio newDio() => Dio(
        BaseOptions(
          baseUrl: EnvConfig.apiBaseUrl,
          connectTimeout: const Duration(seconds: 15),
          receiveTimeout: const Duration(seconds: 15),
          headers: {
            'Accept': 'application/json',
          },
        ),
      );

  /// Initializes the Dio client configuration.
  static void init() {
    if (kDebugMode && !kIsWeb) {
      // Only configure SSL for non-web platforms in debug mode
      (DioClient.dio.httpClientAdapter as IOHttpClientAdapter)
          .createHttpClient = () {
        final client = HttpClient();
        client.badCertificateCallback = (cert, host, port) => true;
        return client;
      };
    }
    
    // Configure for web platform
    if (kIsWeb) {
      // Configure appropriate timeouts for web requests
      dio.options.connectTimeout = kDebugMode 
          ? const Duration(seconds: 60)  // Longer timeout for development
          : const Duration(seconds: 30); // Standard timeout for production
      dio.options.receiveTimeout = kDebugMode 
          ? const Duration(seconds: 60) 
          : const Duration(seconds: 30);
      dio.options.sendTimeout = kDebugMode 
          ? const Duration(seconds: 60) 
          : const Duration(seconds: 30);
      
      // Essential headers for web requests - only client-side headers
      dio.options.headers.addAll({
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      });
      
      // Add debug logging only in development
      if (kDebugMode) {
        dio.interceptors.add(
          LogInterceptor(
            requestBody: true,
            responseBody: true,
            error: true,
            logPrint: (obj) => print('[WEB API] $obj'),
          ),
        );
        
        // Add request interceptor to ensure POST methods are preserved
        dio.interceptors.add(
          InterceptorsWrapper(
            onRequest: (options, handler) {
              // Ensure POST requests are not converted to GET due to CORS
              if (options.method == 'POST') {
                print('[WEB REQUEST] Ensuring POST method is maintained for: ${options.uri}');
                options.followRedirects = false; // Prevent automatic redirects that convert POST to GET
              }
              handler.next(options);
            },
            onError: (error, handler) {
              print('[WEB ERROR] ${error.message}');
              print('[WEB ERROR] Type: ${error.type}');
              print('[WEB ERROR] Response: ${error.response}');
              
              // Provide helpful error messages for development
              if (error.type == DioExceptionType.connectionError) {
                print('[WEB ERROR] This is likely a CORS issue. For development:');
                print('[WEB ERROR] 1. Run with: flutter run -d chrome --web-browser-flag "--disable-web-security"');
                print('[WEB ERROR] 2. Or use the run_web_dev.bat script');
                print('[WEB ERROR] For production: Configure CORS headers on your backend server');
              }
              handler.next(error);
            },
          ),
        );
      } else {
        // Production error handling - more user-friendly
        dio.interceptors.add(
          InterceptorsWrapper(
            onError: (error, handler) {
              // Log errors for monitoring in production
              print('[PROD ERROR] API Error: ${error.type}');
              
              // Don't expose internal error details in production
              if (error.type == DioExceptionType.connectionError) {
                // You might want to show a user-friendly message here
                print('[PROD ERROR] Network connection failed');
              }
              handler.next(error);
            },
          ),
        );
      }
    }
  }
}
