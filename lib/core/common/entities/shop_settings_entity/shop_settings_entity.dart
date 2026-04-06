import 'package:bookie_buddy_web/core/constants/enums/shop_based_enums.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'shop_settings_entity.freezed.dart';

@freezed
abstract class ShopSettingsEntity with _$ShopSettingsEntity {
  const factory ShopSettingsEntity({
    required int coolingPeriodDuration,
    required CoolingPeriodMode coolingPeriodMode,
    required AddButtonDefaultAction addButtonDefaultAction,
    required bool searchClient,
  }) = _ShopSettingsEntity;
}
