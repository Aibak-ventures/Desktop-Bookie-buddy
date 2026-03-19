import 'package:bookie_buddy_web/core/models/user_model/user_model.dart';
import 'package:bookie_buddy_web/features/auth/domain/repositories/i_user_repository.dart';

class SwitchShopUseCase {
  final IUserRepository _repository;

  SwitchShopUseCase(this._repository);

  Future<UserModel> call({
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
