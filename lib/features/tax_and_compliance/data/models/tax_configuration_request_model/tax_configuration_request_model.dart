import 'package:bookie_buddy_shared/core/core/constants/enums/tax_calculation_type_enum.dart';
import 'package:bookie_buddy_shared/core/core/constants/enums/taxable_component_enum.dart';
import 'package:bookie_buddy_web/features/tax_and_compliance/domain/entities/tax_configuration_request_entity/tax_configuration_request_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'tax_configuration_request_model.freezed.dart';
part 'tax_configuration_request_model.g.dart';

@freezed
abstract class TaxConfigurationRequestModel
    with _$TaxConfigurationRequestModel {
  const factory TaxConfigurationRequestModel({
    @JsonKey(name: 'tax_name', includeIfNull: false) String? taxName,
    @JsonKey(name: 'tax_rate', includeIfNull: false) double? taxRate,
    @JsonKey(name: 'is_enabled', includeIfNull: false) bool? isEnabled,
    @JsonKey(
      name: 'taxable_components',
      fromJson: TaxableComponent.tryFromJsonList,
      toJson: TaxableComponent.tryToJsonList,
      includeIfNull: false,
    )
    List<TaxableComponent>? taxableComponents,
    @JsonKey(
      name: 'tax_calculation_type',
      fromJson: TaxCalculationType.tryFromJson,
      toJson: TaxCalculationType.tryToJson,
      includeIfNull: false,
    )
    TaxCalculationType? taxCalculationType,
  }) = _TaxConfigurationRequestModel;

  factory TaxConfigurationRequestModel.fromJson(Map<String, dynamic> json) =>
      _$TaxConfigurationRequestModelFromJson(json);

  factory TaxConfigurationRequestModel.fromEntity(
    TaxConfigurationRequestEntity entity,
  ) => TaxConfigurationRequestModel(
    taxName: entity.taxName,
    taxRate: entity.taxRate,
    isEnabled: entity.isEnabled,
    taxableComponents: entity.taxableComponents,
    taxCalculationType: entity.taxCalculationType,
  );
}
