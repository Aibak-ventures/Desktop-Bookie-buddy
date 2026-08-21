import 'package:bookie_buddy_web/core/constants/enums/print_output_preference_enum.dart';
import 'package:bookie_buddy_web/core/constants/enums/shop_based_enums.dart';
import 'package:bookie_buddy_web/features/shop/domain/entities/update_shop_settings_request_entity/update_shop_settings_request_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_shop_settings_request_model.freezed.dart';
part 'update_shop_settings_request_model.g.dart';

// `CoolingPeriodMode.toJson`/`PrintOutputPreference.toJson` only accept a
// non-null value, and `AddButtonDefaultAction` has no `toJson` helper at
// all (its GET-side usage in `ShopSettingsModel` only ever *reads* it) —
// without an explicit mapping here, json_serializable would default to
// serializing the enum's Dart member name (`booking`) instead of its
// wire value (`BOOKINGS`). These null-safe wrappers are what
// `@JsonKey(toJson:)` needs for the nullable fields below.
String? _coolingPeriodModeToJson(CoolingPeriodMode? mode) =>
    mode == null ? null : CoolingPeriodMode.toJson(mode);

String? _addButtonDefaultActionToJson(AddButtonDefaultAction? action) =>
    action?.value;

String? _printOutputPreferenceToJson(PrintOutputPreference? preference) =>
    preference == null ? null : PrintOutputPreference.toJson(preference);

/// PUT payload for `shop-settings/update-settings`.
///
/// NOTE: unverified against the real backend — this endpoint has no other
/// caller in this codebase to confirm the contract against. Field names
/// mirror `ShopSettingsModel`'s (the GET-side shape) as a best guess;
/// `print_output_preference` in particular has no confirmed backend key
/// at all yet. `includeIfNull: false` means only fields the caller
/// actually set are sent — correct if the endpoint does a partial
/// update, wrong if it expects/requires the full object every time.
@freezed
abstract class UpdateShopSettingsRequestModel
    with _$UpdateShopSettingsRequestModel {
  @JsonSerializable(includeIfNull: false)
  const factory UpdateShopSettingsRequestModel({
    @JsonKey(name: 'cooling_days') int? coolingPeriodDuration,
    @JsonKey(name: 'cooling_period_mode', toJson: _coolingPeriodModeToJson)
    CoolingPeriodMode? coolingPeriodMode,
    @JsonKey(name: 'default_action', toJson: _addButtonDefaultActionToJson)
    AddButtonDefaultAction? addButtonDefaultAction,
    @JsonKey(name: 'search_client') bool? searchClient,
    @JsonKey(name: 'printer_preference', toJson: _printOutputPreferenceToJson)
    PrintOutputPreference? printOutputPreference,
  }) = _UpdateShopSettingsRequestModel;

  factory UpdateShopSettingsRequestModel.fromJson(Map<String, dynamic> json) =>
      _$UpdateShopSettingsRequestModelFromJson(json);

  factory UpdateShopSettingsRequestModel.fromEntity(
    UpdateShopSettingsRequestEntity entity,
  ) => UpdateShopSettingsRequestModel(
    coolingPeriodDuration: entity.coolingPeriodDuration,
    coolingPeriodMode: entity.coolingPeriodMode,
    addButtonDefaultAction: entity.addButtonDefaultAction,
    searchClient: entity.searchClient,
    printOutputPreference: entity.printOutputPreference,
  );
}
