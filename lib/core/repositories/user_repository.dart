import 'dart:developer';

import 'package:bookie_buddy_web/core/extensions/string_extensions.dart';
import 'package:bookie_buddy_web/core/models/user_model/user_model.dart';
import 'package:bookie_buddy_web/core/services/auth_service.dart';
import 'package:bookie_buddy_web/core/services/secure_action_auth_session_manager.dart';
import 'package:bookie_buddy_web/core/services/user_service.dart';
import 'package:bookie_buddy_web/core/storage/shared_preference_helper.dart';
import 'package:bookie_buddy_web/core/storage/token_storage.dart';
import 'package:bookie_buddy_web/utils/safe_api_call.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/rendering.dart';

class UserRepository {
  final UserService _userService;
  final SharedPreferenceHelper _prefs;
  UserRepository({
    required UserService userService,
    required SharedPreferenceHelper prefs,
  })  : _userService = userService,
        _prefs = prefs;

  Future<UserModel> fetchUserData() async {
    try {
      final res = await safeApiCall(_userService.fetchUserData);
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

  Future<void> logOut({String? fcmToken}) async {
    try {
      if (fcmToken != null) await removeFCMToken(fcmToken);
      await AuthService.clearUserSession();
      SecureActionAuthSessionManager.reset();
      await CachedNetworkImageProvider.defaultCacheManager.emptyCache();
      // Clear all stored data from SharedPreferences
      await TokenStorage.clearTokens();
      await SharedPreferenceHelper.clearAll();
    } catch (e, stack) {
      log(e.toString(), stackTrace: stack);
    }
  }

  Future<void> setShopId(int shopId) async {
    try {
      await _prefs.setShopId(shopId);
    } catch (e, stack) {
      log('Error setting shop ID: $e', stackTrace: stack);
    }
  }

  int? get getShopId => _prefs.getShopId;

  // FCM Token

  Future<void> registerFCMToken(String token) async {
    try {
      if (TokenStorage.refreshToken.isNullOrEmpty) {
        log('No refresh token available, skipping FCM token registration');
        return;
      }
      final shopId = getShopId;
      final response = await safeApiCall(
        () => _userService.registerFCMToken(token: token, shopId: shopId),
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

  Future<void> removeFCMToken(String token) async {
    try {
      final response = await safeApiCall(
        () => _userService.removeFCMToken(token),
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

  Future<void> updateFCMTokenWhenShopSwitching({
    required String token,
    required int newShopId,
  }) async {
    try {
      final response = await safeApiCall(
        () => _userService.updateFCMTokenWhenShopSwitching(
          token: token,
          shopId: newShopId,
        ),
      );

      if (response.status.isSuccess) {
        // log(response.message);
        return;
      }
      log(
        'Failed to update FCM token: ${response.devMessage ?? response.message}',
      );
      throw response.message ?? 'Failed to update FCM token';
    } catch (e, stack) {
      log('Error updating FCM token: $e', stackTrace: stack);
    }
  }

  Future<List<dynamic>> fetchAvailableShops() async {
    try {
      final response = await safeApiCall(_userService.fetchAvailableShops);

      if (response.status.isSuccess) {
        return response.data as List<dynamic>;
      }
      log('Failed to fetch available shops: ${response.devMessage}');
      throw response.message ?? 'Failed to fetch available shops';
    } catch (e, stack) {
      log('Error fetching available shops: $e', stackTrace: stack);
      rethrow;
    }
  }

  Future<UserModel> switchShop(int shopId) async {
    try {
      // Set the new shop ID in local storage
      await setShopId(shopId);

      // Reload user data which will fetch data for the new shop
      final userData = await fetchUserData();
      return userData;
    } catch (e, stack) {
      log('Error switching shop: $e', stackTrace: stack);
      rethrow;
    }
  }
}
