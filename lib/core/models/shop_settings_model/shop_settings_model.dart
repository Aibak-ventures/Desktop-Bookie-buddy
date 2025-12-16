import 'package:bookie_buddy_web/core/enums/shop_based_enums.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'shop_settings_model.g.dart';
part 'shop_settings_model.freezed.dart';

@freezed
class ShopSettingsModel with _$ShopSettingsModel {
  const factory ShopSettingsModel({
    @JsonKey(name: 'cooling_days', defaultValue: 0)
    required int coolingPeriodDuration,
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
