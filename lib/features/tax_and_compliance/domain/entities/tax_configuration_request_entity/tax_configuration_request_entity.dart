import 'package:bookie_buddy_core/core/constants/enums/tax_calculation_type_enum.dart';
import 'package:bookie_buddy_core/core/constants/enums/taxable_component_enum.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'tax_configuration_request_entity.freezed.dart';

@freezed
abstract class TaxConfigurationRequestEntity
    with _$TaxConfigurationRequestEntity {
  const factory TaxConfigurationRequestEntity({
    String? taxName,
    double? taxRate,
    bool? isEnabled,
    List<TaxableComponent>? taxableComponents,
    TaxCalculationType? taxCalculationType,
  }) = _TaxConfigurationRequestEntity;
}
