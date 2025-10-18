import 'dart:io';

import 'package:bookie_buddy_web/config/dio_client/auth_interceptor.dart';
import 'package:bookie_buddy_web/core/api/baseurl.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/foundation.dart';

class DioClient {
  /// A dio client with a base url and a auth interceptor
  /// The auth interceptor is responsible for adding the token to the request
  /// and for logging out the user when the token is invalid
  static final Dio dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
      headers: {
        // 'Content-Type': 'application/json',
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
          baseUrl: baseUrl,
          connectTimeout: const Duration(seconds: 15),
          receiveTimeout: const Duration(seconds: 15),
          headers: {
            // 'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );

  /// Initializes the Dio client configuration.
  ///
  /// In debug mode, this method configures the Dio HTTP client adapter to accept
  /// all SSL certificates, which is useful for development and testing purposes
  /// when using self-signed certificates. This should not be used in production
  /// as it bypasses SSL certificate validation.
  static void init() {
    if (kDebugMode && !kIsWeb) {
      // Only configure SSL for non-web platforms in debug mode
      // In debug mode, configure the Dio HTTP client adapter to accept all SSL certificates.
      // This is useful for development and testing purposes when using self-signed certificates.
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
      
      // Essential headers for web requests - add proper headers
      dio.options.headers.addAll({
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      });
      
      // Configure proper response validation for web
      dio.options.validateStatus = (status) {
        if (status == null) return false;
        // Accept all 2xx and 3xx status codes
        if (status >= 200 && status < 400) return true;
        // Accept 401 for proper authentication handling
        if (status == 401) return true;
        return false;
      };
      
      // Add debug logging only in development
      if (kDebugMode) {
        dio.interceptors.add(
          LogInterceptor(
            requestBody: true,
            responseBody: true,
            error: true,
            requestHeader: true,
            responseHeader: false,
            logPrint: (obj) => print('[WEB API] $obj'),
          ),
        );
        
        // Add development-specific error interceptor with better CORS guidance
        dio.interceptors.add(
          InterceptorsWrapper(
            onRequest: (options, handler) {
              print('[WEB API] Making request to: ${options.uri}');
              print('[WEB API] Headers: ${options.headers}');
              handler.next(options);
            },
            onResponse: (response, handler) {
              print('[WEB API] Response from: ${response.requestOptions.uri}');
              print('[WEB API] Status: ${response.statusCode}');
              handler.next(response);
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
                print('[WEB ERROR] 3. Install CORS browser extension');
                print('[WEB ERROR] For production: Configure CORS headers on your backend server');
              } else if (error.type == DioExceptionType.badResponse) {
                print('[WEB ERROR] Server returned error: ${error.response?.statusCode}');
                print('[WEB ERROR] Response data: ${error.response?.data}');
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
