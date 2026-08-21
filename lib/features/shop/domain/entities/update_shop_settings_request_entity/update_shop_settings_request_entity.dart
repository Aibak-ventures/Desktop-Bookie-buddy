import 'package:bookie_buddy_web/core/constants/enums/print_output_preference_enum.dart';
import 'package:bookie_buddy_web/core/constants/enums/shop_based_enums.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_shop_settings_request_entity.freezed.dart';

/// Write-side counterpart to `ShopSettingsEntity` — all fields optional so
/// a caller only sets what it's actually changing (e.g. Settings' "Print
/// Output" tile sets only [printOutputPreference]). Presentation builds
/// this; `UpdateShopSettingsRequestModel.fromEntity()` turns it into the
/// wire payload.
@freezed
abstract class UpdateShopSettingsRequestEntity
    with _$UpdateShopSettingsRequestEntity {
  const factory UpdateShopSettingsRequestEntity({
    int? coolingPeriodDuration,
    CoolingPeriodMode? coolingPeriodMode,
    AddButtonDefaultAction? addButtonDefaultAction,
    bool? searchClient,
    PrintOutputPreference? printOutputPreference,
  }) = _UpdateShopSettingsRequestEntity;
}
