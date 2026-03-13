import 'package:bookie_buddy_web/core/constants/enums/shop_based_enums.dart';
import 'package:bookie_buddy_web/features/settings/domain/repositories/i_settings_repository.dart';

class UpdateShopSettingsUseCase {
  final ISettingsRepository _repository;

  UpdateShopSettingsUseCase(this._repository);

  Future<void> call({
    int? coolingPeriodDuration,
    AddButtonDefaultAction? addButtonDefaultAction,
  }) async {
    return _repository.updateShopSettings(
      coolingPeriodDuration: coolingPeriodDuration,
      addButtonDefaultAction: addButtonDefaultAction,
    );
  }
}
