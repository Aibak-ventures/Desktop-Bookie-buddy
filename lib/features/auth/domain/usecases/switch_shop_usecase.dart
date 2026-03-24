import 'package:bookie_buddy_web/core/common/entities/user_entity/user_entity.dart';
import 'package:bookie_buddy_web/features/auth/domain/repositories/i_user_repository.dart';

class SwitchShopUseCase {
  final IUserRepository _repository;

  SwitchShopUseCase(this._repository);

  Future<UserEntity> call({
    required int shopId,
    String? fcmToken,
  }) async {
    if (fcmToken != null) {
      await _repository.updateFCMTokenWhenShopSwitching(
        token: fcmToken,
        newShopId: shopId,
      );
    }
    return _repository.switchShop(shopId);
  }
}
