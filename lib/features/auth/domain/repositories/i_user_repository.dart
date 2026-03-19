import 'package:bookie_buddy_web/core/common/models/user_model/user_model.dart';

abstract interface class IUserRepository {
  Future<UserModel> fetchUserData();

  Future<void> logout({String? fcmToken});

  Future<void> setShopId(int shopId);

  int? get getShopId;

  Future<void> registerFCMToken(String token);

  Future<void> removeFCMToken(String token);

  Future<void> updateFCMTokenWhenShopSwitching({
    required String token,
    required int newShopId,
  });

  Future<UserModel> switchShop(int shopId);
}
