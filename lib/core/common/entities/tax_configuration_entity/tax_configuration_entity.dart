import 'package:bookie_buddy_web/core/common/utils/tax_calculator.dart'
    as tax_calculator;
import 'package:bookie_buddy_web/core/constants/enums/tax_calculation_type_enum.dart';
import 'package:bookie_buddy_web/core/constants/enums/taxable_component_enum.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'tax_configuration_entity.freezed.dart';

@freezed
abstract class TaxConfigurationEntity with _$TaxConfigurationEntity {
  const factory TaxConfigurationEntity({
    required int id,
    required String taxName,
    required double taxRate,
    required bool isEnabled,
    required List<TaxableComponent> taxableComponents,
    required TaxCalculationType taxCalculationType,
    String? createdAt,
    String? updatedAt,
  }) = _TaxConfigurationEntity;
}

/// Tax calculation helpers, driven purely by [taxableComponents] and
/// [taxCalculationType] so new [TaxableComponent] values just need an entry
/// in the [componentAmounts] map passed by the caller — no branching here.
/// The actual rate math lives in `tax_calculator.dart`, shared with
/// [AppliedTaxEntity]'s equivalent calculator.
extension TaxConfigurationCalculator on TaxConfigurationEntity {
  /// Sums only the components this tax rule applies to, minus [discountAmount].
  double taxableAmount(
    Map<TaxableComponent, double> componentAmounts, {
    double discountAmount = 0,
  }) => tax_calculator.calculateTaxableAmount(
    taxableComponents: taxableComponents,
    componentAmounts: componentAmounts,
    discountAmount: discountAmount,
  );

  /// The tax amount for [componentAmounts] (after [discountAmount] is taken
  /// off the taxable base), or 0 if this rule is disabled.
  double calculateTaxAmount(
    Map<TaxableComponent, double> componentAmounts, {
    double discountAmount = 0,
  }) {
    if (!isEnabled) return 0;
    return tax_calculator.calculateTaxAmount(
      taxRate: taxRate,
      taxCalculationType: taxCalculationType,
      taxableComponents: taxableComponents,
      componentAmounts: componentAmounts,
      discountAmount: discountAmount,
    );
  }

  /// The amount actually payable for [componentAmounts]. For exclusive tax
  /// this is base + tax; for inclusive tax the base already contains it.
  double calculateTotalWithTax(
    Map<TaxableComponent, double> componentAmounts, {
    double discountAmount = 0,
  }) {
    final base = taxableAmount(
      componentAmounts,
      discountAmount: discountAmount,
    );
    if (taxCalculationType == TaxCalculationType.inclusive) return base;
    return base +
        calculateTaxAmount(componentAmounts, discountAmount: discountAmount);
  }
}
