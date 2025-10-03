import 'dart:developer';

import 'package:bookie_buddy_web/core/models/user_model/user_model.dart';
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
}
