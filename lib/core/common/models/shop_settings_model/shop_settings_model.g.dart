// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shop_settings_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ShopSettingsModelImpl _$$ShopSettingsModelImplFromJson(
        Map<String, dynamic> json) =>
    _$ShopSettingsModelImpl(
      coolingPeriodDuration: (json['cooling_days'] as num?)?.toInt() ?? 0,
      coolingPeriodMode: json['cooling_period_mode'] == null
          ? CoolingPeriodMode.after
          : CoolingPeriodMode.fromJson(json['cooling_period_mode'] as String?),
      addButtonDefaultAction: json['default_action'] == null
          ? AddButtonDefaultAction.booking
          : AddButtonDefaultAction.fromString(
              json['default_action'] as String?),
      searchClient: json['search_client'] as bool? ?? false,
    );

Map<String, dynamic> _$$ShopSettingsModelImplToJson(
        _$ShopSettingsModelImpl instance) =>
    <String, dynamic>{
      'cooling_days': instance.coolingPeriodDuration,
      'cooling_period_mode': instance.coolingPeriodMode,
      'default_action': instance.addButtonDefaultAction,
      'search_client': instance.searchClient,
    };
