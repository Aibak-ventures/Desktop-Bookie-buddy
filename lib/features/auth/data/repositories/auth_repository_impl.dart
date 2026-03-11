import 'dart:developer';

import 'package:bookie_buddy_web/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:bookie_buddy_web/core/storage/token_storage.dart';
import 'package:bookie_buddy_web/features/auth/domain/repositories/i_auth_repository.dart';
import 'package:bookie_buddy_web/utils/safe_api_call.dart';

class AuthRepositoryImpl implements IAuthRepository {
  final AuthRemoteDatasource _datasource;

  AuthRepositoryImpl(this._datasource);

  @override
  Future<void> login({
    required String phone,
    required String password,
    String? fcmToken,
  }) async {
    try {
      final response = await safeApiCall(
        () => _datasource.userLogin(
          phone: phone,
          password: password,
          fcmToken: fcmToken,
        ),
      );
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
        throw response.message ?? 'Failed to complete operation';
      }
    } catch (e, stack) {
      log(e.toString(), stackTrace: stack);
      rethrow;
    }
  }

  @override
  Future<void> secretLogin(String password) async {
    try {
      final response = await safeApiCall(
        () => _datasource.secretLogin(password),
      );
      log('Secret login response: ${response.toJson()}');
      if (!response.status.isSuccess) {
        log('Secret login failed: ${response.devMessage}');
        throw response.message ?? 'Failed to complete operation';
      }
      log('Secret login successful');
    } catch (e, stack) {
      log(e.toString(), stackTrace: stack);
      rethrow;
    }
  }

  @override
  Future<void> clearSession() async {
    try {
      await _datasource.clearUserSession();
    } catch (e, stack) {
      log(e.toString(), stackTrace: stack);
      rethrow;
    }
  }

  @override
  Future<bool> refreshToken() async {
    try {
      final refreshToken = TokenStorage.refreshToken;
      final newAccessToken = await safeApiCall(
        () => _datasource.refreshToken(refreshToken: refreshToken),
      );

      // Persist new tokens
      await TokenStorage.saveTokens(accessToken: newAccessToken);
      return true;
    } catch (e, stack) {
      log(e.toString(), stackTrace: stack);
      return false;
    }
  }

  @override
  Future<void> changeAccountPassword(
      {required String oldPassword,
      required String newPassword,
      bool logoutFromAllDevices = false}) async {
    try {
      await _datasource.changeAccountPassword(
        oldPassword: oldPassword,
        newPassword: newPassword,
        logoutFromAllDevices: logoutFromAllDevices,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> changeSecretPassword(
      {required String oldPassword, required String newPassword}) async {
    try {
      await _datasource.changeSecretPassword(
        oldPassword: oldPassword,
        newPassword: newPassword,
      );
    } catch (e) {
      rethrow;
    }
  }
}
