import 'package:bookie_buddy_web/core/constants/enums/shop_based_enums.dart';
import 'package:bookie_buddy_web/core/models/user_model/user_model.dart';

abstract class ISettingsRepository {
  Future<void> updateShopPrivacySettings(
    List<UserPasswordSettingsModel> updatedPasswordSettings,
  );

  Future<void> updateShopSettings({
    int? coolingPeriodDuration,
    AddButtonDefaultAction? addButtonDefaultAction,
  });
}
