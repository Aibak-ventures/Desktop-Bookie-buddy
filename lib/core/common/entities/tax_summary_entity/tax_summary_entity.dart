import 'package:bookie_buddy_web/core/common/utils/tax_label_formatter.dart';
import 'package:bookie_buddy_web/core/constants/enums/tax_calculation_type_enum.dart';

/// One tax rule's contribution to a [TaxSummaryEntity] — just the fields a
/// UI needs to render a line item. Deliberately not tied to
/// [TaxConfigurationEntity] or [AppliedTaxEntity]: both the shop's live tax
/// config and a booking/sale/custom work's frozen tax snapshot produce this
/// same shape, so one summary/rendering path serves both.
class TaxSummaryLineEntity {
  const TaxSummaryLineEntity({
    required this.taxName,
    required this.taxRate,
    required this.taxCalculationType,
    required this.amount,
  });

  final String taxName;
  final double taxRate;
  final TaxCalculationType taxCalculationType;
  final double amount;

  /// e.g. `GST (18%)`, or `GST (18%) (incl.)` for an inclusive rule.
  String get formattedTaxLabel => formatTaxLabel(
    taxName: taxName,
    taxRate: taxRate,
    taxCalculationType: taxCalculationType,
  );
}

/// Result of applying a set of tax rules (a shop's live config, or a
/// booking/sale/custom work's frozen applied-tax snapshot) to a set of
/// component amounts. Built by [UserShopEntityX.calculateTaxSummary] or
/// [AppliedTaxListCalculator.calculateTaxSummary], and reused wherever a tax
/// breakdown needs to be shown or added to a total, so every screen
/// renders/sums tax the same way.
class TaxSummaryEntity {
  const TaxSummaryEntity({
    required this.appliedTaxes,
    required this.additionalTaxAmount,
    required this.includedTaxAmount,
  });

  /// Every tax rule that produced a non-zero amount, in display order.
  final List<TaxSummaryLineEntity> appliedTaxes;

  /// Sum of tax from exclusive-type rules. Must be added on top of a total.
  final double additionalTaxAmount;

  /// Sum of tax from inclusive-type rules. Already baked into the amounts
  /// passed in — informational only, never add this to a total.
  final double includedTaxAmount;
}
