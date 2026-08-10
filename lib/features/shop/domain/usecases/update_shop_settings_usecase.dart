import 'package:bookie_buddy_web/features/shop/domain/entities/update_shop_settings_request_entity/update_shop_settings_request_entity.dart';
import 'package:bookie_buddy_web/features/shop/domain/repositories/i_shop_repository.dart';

class UpdateShopSettingsUseCase {
  UpdateShopSettingsUseCase(this._repository);

  final IShopRepository _repository;

  Future<void> call(UpdateShopSettingsRequestEntity request) =>
      _repository.updateShopSettings(request);
}
