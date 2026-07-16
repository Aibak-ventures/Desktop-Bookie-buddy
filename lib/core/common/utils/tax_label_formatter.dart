import 'package:bookie_buddy_web/core/constants/enums/tax_calculation_type_enum.dart';

/// Shared display label for a tax line, e.g. `GST (18%)` or, for an
/// inclusive rule, `GST (18%) (incl.)`. Used anywhere a tax rule or applied
/// tax snapshot needs to be shown next to its amount — add booking, edit
/// booking, booking details, and any future sales/custom work screens.
String formatTaxLabel({
  required String taxName,
  required double taxRate,
  required TaxCalculationType taxCalculationType,
}) {
  final rateLabel = taxRate.truncateToDouble() == taxRate
      ? taxRate.toStringAsFixed(0)
      : taxRate.toStringAsFixed(2);
  final suffix = taxCalculationType == TaxCalculationType.inclusive
      ? ' (incl.)'
      : '';
  return '$taxName ($rateLabel%)$suffix';
}
