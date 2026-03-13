import 'package:bookie_buddy_web/core/models/user_model/user_model.dart';
import 'package:bookie_buddy_web/features/settings/domain/repositories/i_settings_repository.dart';

class UpdateShopPrivacySettingsUseCase {
  final ISettingsRepository _repository;

  UpdateShopPrivacySettingsUseCase(this._repository);

  Future<void> call(List<UserPasswordSettingsModel> updatedPasswordSettings) async {
    return _repository.updateShopPrivacySettings(updatedPasswordSettings);
  }
}
