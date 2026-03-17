import 'dart:developer';
import 'dart:io';

import 'package:bookie_buddy_web/core/network/endpoints/api_endpoints.dart';
import 'package:bookie_buddy_web/core/models/custom_response_model/custom_response_model.dart';
import 'package:bookie_buddy_web/core/storage/shared_preference_helper.dart';
import 'package:bookie_buddy_web/core/storage/token_manager.dart';
import 'package:bookie_buddy_web/core/storage/token_storage.dart';
import 'package:dio/dio.dart';

class AuthRemoteDatasource {
  final Dio _dio;

  AuthRemoteDatasource({required Dio dio}) : _dio = dio;

  Future<CustomResponseModel> userLogin({
    required String phone,
    required String password,
    String? fcmToken,
  }) async {
    try {
      await clearUserSession();
      log('Attempting login for phone: $phone and fcmToken: $fcmToken');
      // Clone the Dio instance and clear its interceptors
      final dio = _dio.clone()
        ..interceptors.clear()
        ..options.validateStatus = (status) => true;
      final response = await dio.post(
        ApiEndpoints.auth.login,
        data: {
          'phone': phone,
          'password': password,
          if (fcmToken != null) 'device_token': fcmToken, //optional
          if (fcmToken != null) 'platform': Platform.operatingSystem,
        },
      );
      return CustomResponseModel.fromJson(response.data);
    } catch (e, stack) {
      log(e.toString(), stackTrace: stack);
      rethrow;
    }
  }

  /// This function clears the user session by performing logout operations.
  /// It clears shared preferences, resets application dependencies,
  /// disposes the profile controller, and empties the image cache.
  /// Any exceptions during these operations are logged.
  Future<void> clearUserSession() async {
    // Perform logout operation
    try {
      await TokenStorage.clearTokens();
      await SharedPreferenceHelper.clearShopId();
      TokenManager.stopProactiveRefresh();
    } catch (e, stack) {
      log(e.toString(), stackTrace: stack);
    }
  }

  Future<CustomResponseModel> secretLogin(String password) async {
    try {
      final response = await _dio.post(
        ApiEndpoints.auth.walletLogin,
        data: {'password': password},
      );

      return CustomResponseModel.fromJson(response.data);
    } catch (e, stack) {
      log(e.toString(), stackTrace: stack);
      rethrow;
    }
  }

  Future<CustomResponseModel> changeAccountPassword({
    required String oldPassword,
    required String newPassword,
    required bool logoutFromAllDevices,
  }) async {
    try {
      final response = await _dio.post(
        ApiEndpoints.auth.changePassword,
        data: {
          'old_password': oldPassword,
          'new_password': newPassword,
          'logout_from_all_devices': logoutFromAllDevices,
        },
      );
      return CustomResponseModel.fromJson(response.data);
    } catch (e, stack) {
      log(e.toString(), stackTrace: stack);
      throw e.toString();
    }
  }

  Future<CustomResponseModel> changeSecretPassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    try {
      final response = await _dio.post(
        ApiEndpoints.auth.changeSecondaryPassword,
        data: {
          'old_secondary_password': oldPassword,
          'new_secondary_password': newPassword,
        },
      );

      return CustomResponseModel.fromJson(response.data);
      // if (response.statusCode == 400) {
      //   throw response.data['error'] ??
      //       'Failed to change secret password, try again';
      // }
      // if (response.statusCode != 200) {
      //   final errorData = response.data;
      //   throw errorData['message'] ??
      //       'Failed to change secret password, try again';
      // }
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
  Future<String?> refreshToken({required String? refreshToken}) async {
    try {
      final response = await _dio.post(
        ApiEndpoints.auth.refresh,
        data: {'refresh': refreshToken},
      );
      // IMPORTANT: Do NOT mutate response.data when masking; it caused the real
      // access token to be replaced with the mask previously, storing '*****'.
      final data = response.data is Map
          ? Map<String, dynamic>.from(response.data)
          : <String, dynamic>{};
      final rawAccessToken = data['access'];
      if (rawAccessToken is! String || rawAccessToken.isEmpty) {
        log('Refresh response missing access token');
        return null;
      }

      // Mask token for logs without altering stored value
      final maskedTail = rawAccessToken.length > 10
          ? '***${rawAccessToken.substring(rawAccessToken.length - 6)}'
          : '***';
      log(
        'status code for refresh token api: ${response.statusCode}, access: $maskedTail',
      );

      return rawAccessToken;
    } on DioException catch (e, stack) {
      log(e.toString(), stackTrace: stack);
      if (e.type == DioExceptionType.connectionTimeout) {
        throw 'Request timeout. Please check your connection and try again.';
      }
      return null;
    } catch (e, stack) {
      log(e.toString(), stackTrace: stack);
      return null;
    }
  }
}
