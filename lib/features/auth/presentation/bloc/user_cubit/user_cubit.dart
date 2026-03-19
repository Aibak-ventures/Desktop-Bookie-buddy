import 'dart:developer';

import 'package:bookie_buddy_web/core/constants/enums/app_premium_features_enum.dart';
import 'package:bookie_buddy_web/core/models/user_model/user_model.dart';
import 'package:bookie_buddy_web/features/auth/domain/usecases/get_user_usecase.dart';
import 'package:bookie_buddy_web/features/auth/domain/usecases/logout_usecase.dart';
import 'package:bookie_buddy_web/features/auth/domain/usecases/register_fcm_token_usecase.dart';
import 'package:bookie_buddy_web/features/auth/domain/usecases/switch_shop_usecase.dart';
import 'package:bookie_buddy_web/features/auth/domain/repositories/i_user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserCubit extends Cubit<UserModel?> {
  final GetUserUseCase _getUser;
  final LogoutUseCase _logout;
  final SwitchShopUseCase _switchShop;
  final RegisterFCMTokenUseCase _registerFCMToken;
  final IUserRepository _userRepository;

  UserCubit({
    required GetUserUseCase getUser,
    required LogoutUseCase logout,
    required SwitchShopUseCase switchShop,
    required RegisterFCMTokenUseCase registerFCMToken,
    required IUserRepository userRepository,
  })  : _getUser = getUser,
        _logout = logout,
        _switchShop = switchShop,
        _registerFCMToken = registerFCMToken,
        _userRepository = userRepository,
        super(null);

  Future<void> loadUserData() async {
    try {
      final user = await _getUser();
      await _userRepository.setShopId(user.shopDetails.id);
      emit(user);
    } catch (e, stack) {
      log(e.toString(), stackTrace: stack);
    }
  }

  Future<void> loadUserIfNot() async {
    if (state == null) await loadUserData();
  }

  Future<void> logOut({String? fcmToken}) async {
    try {
      await _logout(fcmToken: fcmToken);
      emit(null);
    } catch (e, stack) {
      log(e.toString(), stackTrace: stack);
    }
  }

  Future<void> registerFCMToken(String token) async {
    try {
      await _registerFCMToken(token);
    } catch (e, stack) {
      log(e.toString(), stackTrace: stack);
    }
  }

  Future<void> switchShop(int shopId, String? fcmToken) async {
    try {
      final userData = await _switchShop(shopId: shopId, fcmToken: fcmToken);
      emit(userData);
    } catch (e, stack) {
      log(e.toString(), stackTrace: stack);
      rethrow;
    }
  }

  Set<AppPremiumFeatures> get shopPremiumFeatures =>
      state?.subscription?.features ?? {};

  Set<AppPremiumFeatures> get userSpecificPremiumFeatures =>
      state?.subscription?.userSpecificFeatures ?? {};

  bool hasFeature(AppPremiumFeatures feature, {bool isUserSpecific = false}) =>
      isUserSpecific
          ? userSpecificPremiumFeatures.contains(feature)
          : shopPremiumFeatures.contains(feature);
}
