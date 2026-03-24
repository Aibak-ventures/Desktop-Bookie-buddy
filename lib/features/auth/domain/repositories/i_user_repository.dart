import 'package:bookie_buddy_web/core/common/entities/user_entity/user_entity.dart';

abstract interface class IUserRepository {
  Future<UserEntity> fetchUserData();

  Future<void> logout({String? fcmToken});

  Future<void> setShopId(int shopId);

  int? get getShopId;

  Future<void> registerFCMToken(String token);

  Future<void> removeFCMToken(String token);

  Future<void> updateFCMTokenWhenShopSwitching({
    required String token,
    required int newShopId,
  });

  Future<UserEntity> switchShop(int shopId);
}
