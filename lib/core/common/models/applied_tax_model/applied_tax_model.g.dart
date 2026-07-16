// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'applied_tax_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AppliedTaxModel _$AppliedTaxModelFromJson(Map<String, dynamic> json) =>
    _AppliedTaxModel(
      isTaxApplied: json['is_tax_applied'] as bool? ?? false,
      taxName: json['tax_name'] as String? ?? '',
      taxRate: (json['tax_rate'] as num?)?.toDouble() ?? 0.0,
      taxCalculationType: json['tax_calculation_type'] == null
          ? TaxCalculationType.exclusive
          : TaxCalculationType.fromJson(json['tax_calculation_type'] as String),
      taxableComponents: json['taxable_components'] == null
          ? []
          : TaxableComponent.fromJsonList(json['taxable_components'] as List),
      subtotal: (json['subtotal'] as num?)?.toDouble() ?? 0.0,
      taxableAmount: (json['taxable_amount'] as num?)?.toDouble() ?? 0.0,
      taxAmount: (json['tax_amount'] as num?)?.toDouble() ?? 0.0,
    );

Map<String, dynamic> _$AppliedTaxModelToJson(
  _AppliedTaxModel instance,
) => <String, dynamic>{
  'is_tax_applied': instance.isTaxApplied,
  'tax_name': instance.taxName,
  'tax_rate': instance.taxRate,
  'tax_calculation_type': TaxCalculationType.toJson(
    instance.taxCalculationType,
  ),
  'taxable_components': TaxableComponent.toJsonList(instance.taxableComponents),
  'subtotal': instance.subtotal,
  'taxable_amount': instance.taxableAmount,
  'tax_amount': instance.taxAmount,
};
