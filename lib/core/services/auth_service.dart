import 'dart:developer';
import 'package:bookie_buddy_web/config/dio_client/dio_config.dart';
import 'package:bookie_buddy_web/core/api/baseurl.dart';
import 'package:bookie_buddy_web/core/storage/shared_preference_helper.dart';
import 'package:bookie_buddy_web/core/storage/token_manager.dart';
import 'package:bookie_buddy_web/core/storage/token_storage.dart';
import 'package:dio/dio.dart';

class AuthService {
  static Future<void> userLogin(
    String phone,
    String password,
  ) async {
    log('🔐 AuthService.userLogin called with phone: $phone');
    try {
      await clearUserSession();
      
      // Try using a completely fresh Dio instance to avoid any interference
      final dio = Dio(BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        validateStatus: (status) => true,
      ));
      
      // Add interceptor to see exactly what requests are being made
      dio.interceptors.add(InterceptorsWrapper(
        onRequest: (options, handler) {
          log('🚀 ACTUAL REQUEST: ${options.method} ${options.uri}');
          log('🚀 REQUEST HEADERS: ${options.headers}');
          log('🚀 REQUEST DATA: ${options.data}');
          handler.next(options);
        },
        onResponse: (response, handler) {
          log('📥 RESPONSE: ${response.statusCode} ${response.statusMessage}');
          handler.next(response);
        },
        onError: (error, handler) {
          log('❌ ERROR: ${error.message}');
          handler.next(error);
        },
      ));
      
      log('=== LOGIN REQUEST DEBUG ===');
      log('Base URL: ${dio.options.baseUrl}');
      log('Full URL: ${dio.options.baseUrl}/api/v3/auth/login');
      log('Method: POST (explicitly set)');
      log('Making POST request to: /api/v3/auth/login');
      log('Request data: ${{'phone': phone, 'password': '[HIDDEN]'}}');
      log('Headers: ${dio.options.headers}');
      log('===========================');
      
      final response = await dio.post(
        '/api/v3/auth/login/',
        data: {
          'phone': phone,
          'password': password,
        },
      );
      
      log('Response status: ${response.statusCode}');
      log('Response data: ${response.data.toString()}');

      if (response.statusCode == 200) {
        final responseData = response.data;
        final String accessToken = responseData['data']['access'];
        final String refreshToken = responseData['data']['refresh'];
        await TokenStorage.saveTokens(
          accessToken: accessToken,
          refreshToken: refreshToken,
        );
      } else if (response.statusCode == 405) {
        throw 'Method not allowed. Please check if the login endpoint is configured correctly.';
      } else if (response.statusCode == 400) {
        throw response.data['message'] ??
            'Failed to login: Phone number or password is incorrect';
      } else if (response.statusCode == 401) {
        throw response.data['error'] ??
            response.data['message'] ??
            'Failed to login: Phone number or password is incorrect';
      } else {
        throw 'Failed to login: ${response.statusMessage}';
      }
    } on DioException catch (e, stack) {
      log(e.toString(), stackTrace: stack);
      if (e.type == DioExceptionType.connectionTimeout) {
        throw "Request timeout. Please check your connection and try again.";
      }
      rethrow;
    } catch (e, stack) {
      log(e.toString(), stackTrace: stack);
      rethrow;
    }
  }

  /// This function clears the user session by performing logout operations.
  /// It clears shared preferences, resets application dependencies,
  /// disposes the profile controller, and empties the image cache.
  /// Any exceptions during these operations are logged.
  static Future<void> clearUserSession() async {
    // Perform logout operation
    try {
      await TokenStorage.clearTokens();
      await SharedPreferenceHelper.clearShopId();
      TokenManager.stopProactiveRefresh();
    } catch (e, stack) {
      log(e.toString(), stackTrace: stack);
    }
  }

  static Future<Map<String, dynamic>> secretLogin(String password) async {
    try {
      final dio = DioClient.dio.clone()
        ..interceptors.clear()
        ..options.validateStatus = (status) => true;
      final response = await dio.post(
        '/api/v1/auth/wallet-login',
        data: {'password': password},
      );

      log('Dio response for re auth api: ${response.data.toString()}');

      if (response.statusCode == 200) {
        final responseData = response.data;
        if (responseData['message'] == 'success') {
          return {'success': true, 'message': 'Authentication successful'};
        } else {
          return {
            'success': false,
            'message': responseData['error'] ??
                responseData['message'] ??
                'Incorrect Password'
          };
        }
      } else {
        return {
          'success': false,
          'message': response.data['message'] ?? 'Unexpected error occurred'
        };
      }
    } on DioException catch (e) {
      log("Dio error: $e");
      String msg = 'Unexpected error occurred';
      if (e.response?.data != null) {
        msg = e.response!.data['message'] ?? msg;
      }
      return {'success': false, 'message': msg};
    } catch (e, stack) {
      log(e.toString(), stackTrace: stack);
      return {'success': false, 'message': 'Error: $e'};
    }
  }

  static Future<void> changeAccountPassword({
    required String oldPassword,
    required String newPassword,
    required bool logoutFromAllDevices,
  }) async {
    try {
      final dio = DioClient.dio.clone()
        ..interceptors.clear()
        ..options.validateStatus = (status) => true;
      final response = await dio.post(
        "/api/v1/auth/change-password",
        data: {
          'old_password': oldPassword,
          'new_password': newPassword,
          'logout_from_all_devices': logoutFromAllDevices,
        },
      );

      log('Dio response for reset password api: ${response.data.toString()}');
      
      if (response.statusCode != 200) {
        if (response.statusCode == 400) {
          throw response.data['error'] ?? 'Failed to reset password, try again';
        } else {
          throw response.data['message'] ?? 'Failed to reset password, try again';
        }
      }
    } on DioException catch (e, stack) {
      log(e.toString(), stackTrace: stack);
      if (e.type == DioExceptionType.connectionTimeout) {
        throw "Request timeout. Please check your connection and try again.";
      }
      throw 'Failed to reset password, try again';
    } catch (e, stack) {
      log(e.toString(), stackTrace: stack);
      throw e.toString();
    }
  }

  static Future<void> changeSecretPassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    try {
      final dio = DioClient.dio.clone()
        ..interceptors.clear()
        ..options.validateStatus = (status) => true;
      final response = await dio.post(
        "/api/v1/auth/update-secondary-password",
        data: {
          'old_secondary_password': oldPassword,
          'new_secondary_password': newPassword,
        },
      );

      log('Dio response for change secret password api: ${response.data.toString()}');
      
      if (response.statusCode != 200) {
        if (response.statusCode == 400) {
          throw response.data['error'] ?? 'Failed to change secret password, try again';
        } else {
          throw response.data['message'] ?? 'Failed to change secret password, try again';
        }
      }
    } on DioException catch (e, stack) {
      log(e.toString(), stackTrace: stack);
      if (e.type == DioExceptionType.connectionTimeout) {
        throw "Request timeout. Please check your connection and try again.";
      }
      rethrow;
    } catch (e, stack) {
      log(e.toString(), stackTrace: stack);
      rethrow;
    }
  }

  /// Refresh the access token using the stored refresh token.
  ///
  /// This method sends a request to the token refresh endpoint to obtain a new
  /// access token. If successful, the new access token is saved. Errors during
  /// the process are logged.
  static Future<bool> refreshToken() async {
    try {
      final refreshToken = TokenStorage.refreshToken;
      final dio = DioClient.dio.clone()
        ..interceptors.clear()
        ..options.validateStatus = (status) => true;
      final response = await dio.post(
        "/api/token/refresh",
        data: {
          'refresh': refreshToken,
        },
      );
      
      log('Dio response for refresh token api: ${response.data.toString()}');
      
      if (response.statusCode == 200) {
        final String accessToken = response.data['access'];
        await TokenStorage.saveTokens(accessToken: accessToken);
        return true;
      } else {
        return false;
      }
    } on DioException catch (e, stack) {
      log(e.toString(), stackTrace: stack);
      if (e.type == DioExceptionType.connectionTimeout) {
        throw "Request timeout. Please check your connection and try again.";
      }
      return false;
    } catch (e, stack) {
      log(e.toString(), stackTrace: stack);
      return false;
    }
  }
}
