import 'dart:developer';

import 'package:bookie_buddy_web/core/constants/enums/app_premium_features_enum.dart';
import 'package:bookie_buddy_web/core/models/user_model/user_model.dart';
import 'package:bookie_buddy_web/core/notifications/firebase_notification_manager.dart';
import 'package:bookie_buddy_web/core/repositories/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserCubit extends Cubit<UserModel?> {
  final UserRepository _repository;

  // The dependency is now a required constructor argument.
  UserCubit({required UserRepository repository})
      : _repository = repository,
        super(null);

  Future<void> loadUserData() async {
    try {
      final user = await _repository.fetchUserData();

      await _repository.setShopId(user.shopDetails.id);
      emit(user);

      if (!user.isNotificationActive) {
        final token = await FirebaseNotificationManager.getFcmToken;
        // ignore: unawaited_futures
        if (token != null) _repository.registerFCMToken(token);
      }
    } catch (e, stack) {
      log(e.toString(), stackTrace: stack);
    }
  }

  Future<void> loadUserIfNot() async {
    if (state == null) {
      await loadUserData();
    }
  }

  Future<void> logOut({String? fcmToken}) async {
    try {
      await _repository.logOut(fcmToken: fcmToken);
      emit(null);
    } catch (e, stack) {
      log(e.toString(), stackTrace: stack);
    }
  }

  Future<void> updateFCMTokenWhenShopSwitching({
    required String fcmToken,
    required int newShopId,
  }) async {
    try {
      await _repository.updateFCMTokenWhenShopSwitching(
        token: fcmToken,
        newShopId: newShopId,
      );
    } catch (e, stack) {
      log(e.toString(), stackTrace: stack);
    }
  }

  Future<List<dynamic>> fetchAvailableShops() async {
    try {
      return await _repository.fetchAvailableShops();
    } catch (e, stack) {
      log(e.toString(), stackTrace: stack);
      return [];
    }
  }

  Future<void> switchShop(int shopId, String? fcmToken) async {
    try {
      // Update FCM token if available
      if (fcmToken != null) {
        await updateFCMTokenWhenShopSwitching(
          fcmToken: fcmToken,
          newShopId: shopId,
        );
      }

      // Switch shop and reload user data
      final userData = await _repository.switchShop(shopId);
      emit(userData);
    } catch (e, stack) {
      log(e.toString(), stackTrace: stack);
      rethrow;
    }
  }

    // UserShopModel? get shopDetails => state?.shopDetails;

  /// Returns the list of premium features available to the shop.
  Set<AppPremiumFeatures> get shopPremiumFeatures =>
      state?.subscription?.features ?? {};

  /// Returns the list of user-specific premium features available to the user.
  Set<AppPremiumFeatures> get userSpecificPremiumFeatures =>
      state?.subscription?.userSpecificFeatures ?? {};


   bool hasFeature(AppPremiumFeatures feature, {bool isUserSpecific = false}) =>
      isUserSpecific
      ? userSpecificPremiumFeatures.contains(feature)
      : shopPremiumFeatures.contains(feature);
}
