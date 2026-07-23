import 'package:bookie_buddy_web/core/constants/enums/tax_calculation_type_enum.dart';
import 'package:bookie_buddy_web/core/constants/enums/taxable_component_enum.dart';

/// Shared math behind every "apply a tax rule to some amounts" calculation
/// in the app — used by both [TaxConfigurationEntity] (the shop's live rule)
/// and [AppliedTaxEntity] (a frozen snapshot of a rule applied to a past
/// booking/sale/custom work). Kept as plain functions, not tied to either
/// entity, so both can share one implementation of the rate math.

/// Sums only the components a rule applies to, out of whatever amounts the
/// caller has available, minus [discountAmount].
///
/// [discountAmount] is only taken off whichever of [_discountableComponents]
/// are present in [taxableComponents] — and is capped at that discountable portion so the result never
/// goes negative.
double calculateTaxableAmount({
  required List<TaxableComponent> taxableComponents,
  required Map<TaxableComponent, double> componentAmounts,
  double discountAmount = 0,
}) {
  final rawBase = taxableComponents.fold(
    0.0,
    (sum, component) => sum + (componentAmounts[component] ?? 0),
  );

  return rawBase - discountAmount;
}

/// The tax amount for [componentAmounts] under the given rate/type/components,
/// after subtracting [discountAmount] from the taxable base.
double calculateTaxAmount({
  required double taxRate,
  required TaxCalculationType taxCalculationType,
  required List<TaxableComponent> taxableComponents,
  required Map<TaxableComponent, double> componentAmounts,
  double discountAmount = 0,
}) {
  if (taxRate <= 0) return 0;
  final base = calculateTaxableAmount(
    taxableComponents: taxableComponents,
    componentAmounts: componentAmounts,
    discountAmount: discountAmount,
  );
  return switch (taxCalculationType) {
    // Rate is added on top of the taxable base.
    TaxCalculationType.exclusive => base * taxRate / 100,
    // Rate is already baked into the taxable base; back it out.
    TaxCalculationType.inclusive => base - (base * 100 / (100 + taxRate)),
  };
}
