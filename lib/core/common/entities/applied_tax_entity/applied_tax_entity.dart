import 'package:bookie_buddy_web/core/common/entities/tax_summary_entity/tax_summary_entity.dart';
import 'package:bookie_buddy_web/core/common/utils/tax_calculator.dart'
    as tax_calculator;
import 'package:bookie_buddy_web/core/common/utils/tax_label_formatter.dart';
import 'package:bookie_buddy_web/core/constants/enums/tax_calculation_type_enum.dart';
import 'package:bookie_buddy_web/core/constants/enums/taxable_component_enum.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'applied_tax_entity.freezed.dart';

/// A snapshot of the tax that was actually applied to a booking, sale, or
/// custom work order at the time it was created/last saved — persisted by
/// the backend on that record. This is deliberately separate from the
/// shop's current [TaxConfigurationEntity]: the shop's live tax rule can
/// change or be disabled later, but this snapshot must stay exactly what
/// was charged, so editing an old record never silently recalculates its
/// tax against today's rate.
///
/// [taxableComponents] records which components this specific tax was
/// applied to *at the time*, so if the base amounts (product total,
/// additional charges, security amount) are edited afterwards, the tax can
/// be recalculated against the original rate/type/components rather than
/// the shop's current (possibly different) live tax config.
@freezed
abstract class AppliedTaxEntity with _$AppliedTaxEntity {
  const factory AppliedTaxEntity({
    required bool isTaxApplied,
    required String taxName,
    required double taxRate,
    required TaxCalculationType taxCalculationType,
    required List<TaxableComponent> taxableComponents,
    required double subtotal,
    required double taxableAmount,
    required double taxAmount,
  }) = _AppliedTaxEntity;
}

extension AppliedTaxList on List<AppliedTaxEntity> {
  List<AppliedTaxEntity> get appliedOnly =>
      where((tax) => tax.isTaxApplied).toList();

  int get totalTaxAmount =>
      appliedOnly.fold(0.0, (sum, tax) => sum + tax.taxAmount).round();

  int get totalTaxableAmount =>
      appliedOnly.fold(0.0, (sum, tax) => sum + tax.taxableAmount).round();
}

extension AppliedTaxLabel on AppliedTaxEntity {
  String get formattedTaxLabel => formatTaxLabel(
    taxName: taxName,
    taxRate: taxRate,
    taxCalculationType: taxCalculationType,
  );
}

/// Recalculates this same tax rule (stored rate/type/components — never the
/// shop's current live config) against a fresh set of amounts. Use this
/// whenever a booking/sale/custom work's amounts are edited after creation,
/// instead of trusting the frozen [taxAmount] which only reflects the
/// amounts at the time this snapshot was taken.
extension AppliedTaxCalculator on AppliedTaxEntity {
  /// The tax amount for [componentAmounts] (after [discountAmount] is taken
  /// off the taxable base), or 0 if this tax wasn't applied.
  double recalculateTaxAmount(
    Map<TaxableComponent, double> componentAmounts, {
    double discountAmount = 0,
  }) {
    if (!isTaxApplied) return 0;
    return tax_calculator.calculateTaxAmount(
      taxRate: taxRate,
      taxCalculationType: taxCalculationType,
      taxableComponents: taxableComponents,
      componentAmounts: componentAmounts,
      discountAmount: discountAmount,
    );
  }
}

/// Same [TaxSummaryEntity] shape as [UserShopEntityX.calculateTaxSummary],
/// but recalculated from a booking/sale/custom work's frozen applied-tax
/// snapshots instead of the shop's live tax config — so editing amounts
/// after creation stays accurate without ever picking up a shop-wide rate
/// change that happened after this record was made.
extension AppliedTaxListCalculator on List<AppliedTaxEntity> {
  TaxSummaryEntity calculateTaxSummary({
    double productTotal = 0,
    double additionalCharges = 0,
    double securityAmount = 0,
    double discountAmount = 0,
  }) {
    final componentAmounts = <TaxableComponent, double>{
      TaxableComponent.productTotal: productTotal,
      TaxableComponent.additionalCharges: additionalCharges,
      // TaxableComponent.securityAmount: securityAmount,
    };
    final lines = where((tax) => tax.isTaxApplied)
        .map(
          (tax) => TaxSummaryLineEntity(
            taxName: tax.taxName,
            taxRate: tax.taxRate,
            taxCalculationType: tax.taxCalculationType,
            amount: tax.recalculateTaxAmount(
              componentAmounts,
              discountAmount: discountAmount,
            ),
          ),
        )
        .where((line) => line.amount > 0)
        .toList();

    double sumWhere(TaxCalculationType type) => lines
        .where((line) => line.taxCalculationType == type)
        .fold(0, (sum, line) => sum + line.amount);

    return TaxSummaryEntity(
      appliedTaxes: lines,
      additionalTaxAmount: sumWhere(TaxCalculationType.exclusive),
      includedTaxAmount: sumWhere(TaxCalculationType.inclusive),
    );
  }

  /// Reverses an inclusive tax's subtraction on [component] to recover the
  /// original gross amount from a stored net amount.
  ///
  /// The backend subtracts any inclusive tax on [component] before saving
  /// (`net = gross * 100 / (100 + rate)`), So: `gross = net * (100 + rate) / 100`.
  /// Returns [netAmount] unchanged if no applied, inclusive tax targets [component].
  int recoverGrossAmount({
    required int netAmount,
    required TaxableComponent component,
  }) {
    final inclusiveRate = where(
      (tax) =>
          tax.isTaxApplied &&
          tax.taxCalculationType == TaxCalculationType.inclusive &&
          tax.taxableComponents.contains(component),
    ).fold(0.0, (sum, tax) => sum + tax.taxRate);

    if (inclusiveRate <= 0) return netAmount;

    return (netAmount * (100 + inclusiveRate) / 100).floor();
  }
}
