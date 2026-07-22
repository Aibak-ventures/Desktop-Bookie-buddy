// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tax_configuration_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TaxConfigurationRequestModel _$TaxConfigurationRequestModelFromJson(
  Map<String, dynamic> json,
) => _TaxConfigurationRequestModel(
  taxName: json['tax_name'] as String?,
  taxRate: (json['tax_rate'] as num?)?.toDouble(),
  isEnabled: json['is_enabled'] as bool?,
  taxableComponents: TaxableComponent.tryFromJsonList(
    json['taxable_components'] as List?,
  ),
  taxCalculationType: TaxCalculationType.tryFromJson(
    json['tax_calculation_type'] as String?,
  ),
);

Map<String, dynamic> _$TaxConfigurationRequestModelToJson(
  _TaxConfigurationRequestModel instance,
) => <String, dynamic>{
  'tax_name': ?instance.taxName,
  'tax_rate': ?instance.taxRate,
  'is_enabled': ?instance.isEnabled,
  'taxable_components': ?TaxableComponent.tryToJsonList(
    instance.taxableComponents,
  ),
  'tax_calculation_type': ?TaxCalculationType.tryToJson(
    instance.taxCalculationType,
  ),
};
