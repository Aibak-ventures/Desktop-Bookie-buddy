import 'dart:developer';

import 'package:bookie_buddy_web/core/services/auth_service.dart';
import 'package:bookie_buddy_web/core/storage/token_storage.dart';
import 'package:bookie_buddy_web/core/utils/safe_api_call.dart';

class AuthRepository {
  final AuthService _authService;

  AuthRepository({required AuthService authService})
    : _authService = authService;

  Future<void> loginUser({
    required String phone,
    required String password,
    String? fcmToken,
  }) async {
    try {
      final response = await safeApiCall(
        () => _authService.userLogin(
          phone: phone,
          password: password,
          fcmToken: fcmToken,
        ),
      );
      // log('Login response: ${response.toJson()}');
      if (response.status.isSuccess) {
        final responseData = response.data as Map<String, dynamic>;
        final String accessToken = responseData['access'];
        final String refreshToken = responseData['refresh'];
        await TokenStorage.saveTokens(
          accessToken: accessToken,
          refreshToken: refreshToken,
        );
        log('Login successful, ${response.devMessage}');
      } else {
        log('Login failed: ${response.devMessage}');
        throw response.message;
      }
    } catch (e, stack) {
      log(e.toString(), stackTrace: stack);
      rethrow;
    }
  }

  Future<void> secretLogin(String password) async {
    try {
      final response = await safeApiCall(
        () => AuthService.secretLogin(password),
      );
      log('Secret login response: ${response.toJson()}');
      if (!response.status.isSuccess) {
        log('Secret login failed: ${response.devMessage}');
        throw response.message;
      }
      log('Secret login successful');
    } catch (e, stack) {
      log(e.toString(), stackTrace: stack);
      rethrow;
    }
  }

  Future<void> clearUserSession() async {
    try {
      await AuthService.clearUserSession();
    } catch (e, stack) {
      log(e.toString(), stackTrace: stack);
      rethrow;
    }
  }

  Future<bool> refreshToken() async {
    try {
      final refreshToken = TokenStorage.refreshToken;
      final newAccessToken = await safeApiCall(
        () => _authService.refreshToken(refreshToken: refreshToken),
      );

      // Persist new tokens
      await TokenStorage.saveTokens(accessToken: newAccessToken);
      return true;
    } catch (e, stack) {
      log(e.toString(), stackTrace: stack);
      return false;
    }
  }
}
