// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tax_configuration_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TaxConfigurationModel _$TaxConfigurationModelFromJson(
  Map<String, dynamic> json,
) => _TaxConfigurationModel(
  id: (json['id'] as num).toInt(),
  taxName: json['tax_name'] as String,
  taxRate: StringX.toDoubleFromString(json['tax_rate']),
  isEnabled: json['is_enabled'] as bool,
  taxableComponents: TaxableComponent.fromJsonList(
    json['taxable_components'] as List,
  ),
  taxCalculationType: json['tax_calculation_type'] == null
      ? TaxCalculationType.exclusive
      : TaxCalculationType.fromJson(json['tax_calculation_type'] as String),
  createdAt: json['created_at'] as String?,
  updatedAt: json['updated_at'] as String?,
);

Map<String, dynamic> _$TaxConfigurationModelToJson(
  _TaxConfigurationModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'tax_name': instance.taxName,
  'tax_rate': instance.taxRate,
  'is_enabled': instance.isEnabled,
  'taxable_components': TaxableComponent.toJsonList(instance.taxableComponents),
  'tax_calculation_type': TaxCalculationType.toJson(
    instance.taxCalculationType,
  ),
  'created_at': instance.createdAt,
  'updated_at': instance.updatedAt,
};
