import 'package:bookie_buddy_web/core/common/entities/tax_configuration_entity/tax_configuration_entity.dart';
import 'package:bookie_buddy_web/core/constants/enums/tax_calculation_type_enum.dart';
import 'package:bookie_buddy_web/core/constants/enums/taxable_component_enum.dart';
import 'package:bookie_buddy_web/utils/extensions/string_extensions.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'tax_configuration_model.freezed.dart';
part 'tax_configuration_model.g.dart';

@freezed
abstract class TaxConfigurationModel with _$TaxConfigurationModel {
  const factory TaxConfigurationModel({
    required int id,
    @JsonKey(name: 'tax_name') required String taxName,
    @JsonKey(name: 'tax_rate', fromJson: StringX.toDoubleFromString)
    required double taxRate,
    @JsonKey(name: 'is_enabled') required bool isEnabled,
    @JsonKey(
      name: 'taxable_components',
      fromJson: TaxableComponent.fromJsonList,
      toJson: TaxableComponent.toJsonList,
    )
    required List<TaxableComponent> taxableComponents,
    @JsonKey(
      name: 'tax_calculation_type',
      fromJson: TaxCalculationType.fromJson,
      toJson: TaxCalculationType.toJson,
      defaultValue: TaxCalculationType.exclusive,
    )
    required TaxCalculationType taxCalculationType,
    @JsonKey(name: 'created_at') String? createdAt,
    @JsonKey(name: 'updated_at') String? updatedAt,
  }) = _TaxConfigurationModel;

  factory TaxConfigurationModel.fromJson(Map<String, dynamic> json) =>
      _$TaxConfigurationModelFromJson(json);

  static List<TaxConfigurationModel> listFromJson(dynamic json) {
    if (json == null) return [];
    if (json is List) {
      return json
          .map((e) => TaxConfigurationModel.fromJson(e as Map<String, dynamic>))
          .toList();
    }
    return [TaxConfigurationModel.fromJson(json as Map<String, dynamic>)];
  }
}

extension TaxConfigurationModelMapper on TaxConfigurationModel {
  TaxConfigurationEntity toEntity() => TaxConfigurationEntity(
    id: id,
    taxName: taxName,
    taxRate: taxRate,
    isEnabled: isEnabled,
    taxableComponents: taxableComponents,
    taxCalculationType: taxCalculationType,
    createdAt: createdAt,
    updatedAt: updatedAt,
  );
}
