import 'dart:developer';

import 'package:bookie_buddy_web/core/models/user_model/user_model.dart';
import 'package:bookie_buddy_web/core/common/services/secure_action_auth_session_manager.dart';
import 'package:bookie_buddy_web/core/storage/shared_preference_helper.dart';
import 'package:bookie_buddy_web/core/storage/token_storage.dart';
import 'package:bookie_buddy_web/features/auth/data/datasources/user_remote_datasource.dart';
import 'package:bookie_buddy_web/features/auth/domain/repositories/i_auth_repository.dart';
import 'package:bookie_buddy_web/features/auth/domain/repositories/i_user_repository.dart';
import 'package:bookie_buddy_web/utils/extensions/string_extensions.dart';
import 'package:bookie_buddy_web/utils/safe_api_call.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/rendering.dart';

class UserRepositoryImpl implements IUserRepository {
  final UserRemoteDatasource _datasource;
  final SharedPreferenceHelper _prefs;
  final IAuthRepository _authRepository;

  UserRepositoryImpl({
    required UserRemoteDatasource datasource,
    required SharedPreferenceHelper prefs,
    required IAuthRepository authRepository,
  })  : _datasource = datasource,
        _prefs = prefs,
        _authRepository = authRepository;

  @override
  Future<UserModel> fetchUserData() async {
    try {
      final res = await safeApiCall(_datasource.fetchUserData);
      debugPrint('Fetched user data: ${res.toJson()}');
      if (res.status.isSuccess) {
        return UserModel.fromJson(res.data);
      }
      log('Failed to fetch user: ${res.devMessage}');
      throw res.message ?? 'Failed to fetch user data';
    } catch (e, stack) {
      log('Error fetching user data: $e', stackTrace: stack);
      rethrow;
    }
  }

  @override
  Future<void> logout({String? fcmToken}) async {
    try {
      if (fcmToken != null) await removeFCMToken(fcmToken);
      await _authRepository.clearSession();
      SecureActionAuthSessionManager.reset();
      await CachedNetworkImageProvider.defaultCacheManager.emptyCache();
      await TokenStorage.clearTokens();
      await SharedPreferenceHelper.clearAll();
    } catch (e, stack) {
      log(e.toString(), stackTrace: stack);
    }
  }

  @override
  Future<void> setShopId(int shopId) async {
    try {
      await _prefs.setShopId(shopId);
    } catch (e, stack) {
      log('Error setting shop ID: $e', stackTrace: stack);
    }
  }

  @override
  int? get getShopId => _prefs.getShopId;

  @override
  Future<void> registerFCMToken(String token) async {
    try {
      if (TokenStorage.refreshToken.isNullOrEmpty) {
        log('No refresh token available, skipping FCM token registration');
        return;
      }
      final shopId = getShopId;
      final response = await safeApiCall(
        () => _datasource.registerFCMToken(token: token, shopId: shopId),
      );
      if (response.status.isSuccess) {
        log('FCM token registered successfully');
        return;
      }
      log('Failed to register FCM token: ${response.devMessage}');
      throw response.message ?? 'Failed to register FCM token';
    } catch (e, stack) {
      log('Error registering FCM token: $e', stackTrace: stack);
    }
  }

  @override
  Future<void> removeFCMToken(String token) async {
    try {
      final response = await safeApiCall(
        () => _datasource.removeFCMToken(token),
      );
      if (response.status.isSuccess) {
        log('FCM token removed successfully');
        return;
      }
      log('Failed to remove FCM token: ${response.devMessage}');
      throw response.message ?? 'Failed to remove FCM token';
    } catch (e, stack) {
      log('Error removing FCM token: $e', stackTrace: stack);
    }
  }

  @override
  Future<void> updateFCMTokenWhenShopSwitching({
    required String token,
    required int newShopId,
  }) async {
    try {
      final response = await safeApiCall(
        () => _datasource.updateFCMTokenWhenShopSwitching(
          token: token,
          shopId: newShopId,
        ),
      );
      if (response.status.isSuccess) return;
      log('Failed to update FCM token: ${response.devMessage ?? response.message}');
      throw response.message ?? 'Failed to update FCM token';
    } catch (e, stack) {
      log('Error updating FCM token: $e', stackTrace: stack);
    }
  }

  @override
  Future<UserModel> switchShop(int shopId) async {
    try {
      await setShopId(shopId);
      return await fetchUserData();
    } catch (e, stack) {
      log('Error switching shop: $e', stackTrace: stack);
      rethrow;
    }
  }
}
