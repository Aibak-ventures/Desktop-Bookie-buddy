import 'package:bookie_buddy_web/core/constants/enums/shop_based_enums.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'shop_settings_model.g.dart';
part 'shop_settings_model.freezed.dart';

@freezed
abstract class ShopSettingsModel with _$ShopSettingsModel {
  const factory ShopSettingsModel({
    @JsonKey(name: 'cooling_days', defaultValue: 0)
    required int coolingPeriodDuration,
    @JsonKey(
      name: 'cooling_period_mode',
      fromJson: CoolingPeriodMode.fromJson,
      defaultValue: CoolingPeriodMode.after,
    )
    required CoolingPeriodMode coolingPeriodMode,
    @JsonKey(
      name: 'default_action',
      fromJson: AddButtonDefaultAction.fromString,
      defaultValue: AddButtonDefaultAction.booking,
    )
    required AddButtonDefaultAction addButtonDefaultAction,
    @JsonKey(name: 'search_client', defaultValue: false)
    required bool searchClient,
  }) = _ShopSettingsModel;

  factory ShopSettingsModel.fromJson(Map<String, dynamic> json) =>
      _$ShopSettingsModelFromJson(json);
}
