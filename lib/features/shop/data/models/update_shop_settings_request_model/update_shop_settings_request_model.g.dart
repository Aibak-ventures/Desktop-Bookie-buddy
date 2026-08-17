// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_shop_settings_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UpdateShopSettingsRequestModel _$UpdateShopSettingsRequestModelFromJson(
  Map<String, dynamic> json,
) => _UpdateShopSettingsRequestModel(
  coolingPeriodDuration: (json['cooling_days'] as num?)?.toInt(),
  coolingPeriodMode: $enumDecodeNullable(
    _$CoolingPeriodModeEnumMap,
    json['cooling_period_mode'],
  ),
  addButtonDefaultAction: $enumDecodeNullable(
    _$AddButtonDefaultActionEnumMap,
    json['default_action'],
  ),
  searchClient: json['search_client'] as bool?,
  printOutputPreference: $enumDecodeNullable(
    _$PrintOutputPreferenceEnumMap,
    json['printer_preference'],
  ),
);

Map<String, dynamic> _$UpdateShopSettingsRequestModelToJson(
  _UpdateShopSettingsRequestModel instance,
) => <String, dynamic>{
  'cooling_days': ?instance.coolingPeriodDuration,
  'cooling_period_mode': ?_coolingPeriodModeToJson(instance.coolingPeriodMode),
  'default_action': ?_addButtonDefaultActionToJson(
    instance.addButtonDefaultAction,
  ),
  'search_client': ?instance.searchClient,
  'printer_preference': ?_printOutputPreferenceToJson(
    instance.printOutputPreference,
  ),
};

const _$CoolingPeriodModeEnumMap = {
  CoolingPeriodMode.after: 'after',
  CoolingPeriodMode.before: 'before',
};

const _$AddButtonDefaultActionEnumMap = {
  AddButtonDefaultAction.booking: 'booking',
  AddButtonDefaultAction.sales: 'sales',
  AddButtonDefaultAction.customWork: 'customWork',
  AddButtonDefaultAction.ask: 'ask',
};

const _$PrintOutputPreferenceEnumMap = {
  PrintOutputPreference.receipt: 'receipt',
  PrintOutputPreference.pdfInvoice: 'pdfInvoice',
  PrintOutputPreference.askEveryTime: 'askEveryTime',
};
