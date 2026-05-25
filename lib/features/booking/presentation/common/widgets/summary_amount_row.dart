import 'package:bookie_buddy_web/utils/extensions/number_extensions.dart';
import 'package:flutter/material.dart';

/// A single label/amount row used in booking summary breakdowns.
///
/// Applies special styling for "Total payable", "Paid", and "Product total"
/// labels automatically; all others use standard body styling.
class SummaryAmountRow extends StatelessWidget {
  final String label;
  final int amount;
  final Color? valueColor;
  final bool isBold;
  final bool isNegative;

  const SummaryAmountRow(
    this.label,
    this.amount, {
    super.key,
    this.valueColor,
    this.isBold = false,
    this.isNegative = false,
  });

  @override
  Widget build(BuildContext context) {
    final isTotalPayable = label == 'Total payable';
    final isPaid = label == 'Paid';
    final isProductTotal = label == 'Product total';

    double labelSize = 15;
    double valueSize = 13;
    FontWeight labelWeight = isBold ? FontWeight.w600 : FontWeight.w400;
    FontWeight valueWeight = isBold ? FontWeight.w700 : FontWeight.w500;
    const labelColor = Color(0xFF3E3E3E);
    Color? resolvedValueColor = valueColor;

    if (isTotalPayable) {
      labelSize = 15;
      valueSize = 15;
      labelWeight = FontWeight.w600;
      valueWeight = FontWeight.w700;
      resolvedValueColor = const Color(0xFFD30000);
    } else if (isPaid) {
      labelSize = 15;
      valueSize = 15;
      labelWeight = FontWeight.w500;
      valueWeight = FontWeight.w600;
      resolvedValueColor = const Color(0xFF1AB000);
    } else if (isProductTotal) {
      labelSize = 13;
      valueSize = 13;
      labelWeight = FontWeight.w400;
      valueWeight = FontWeight.w500;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: labelSize,
              fontFamily: 'Inter',
              fontWeight: labelWeight,
              color: labelColor,
            ),
          ),
          Text(
            '${isNegative ? '-' : ''}${amount.abs().toCurrency()}',
            style: TextStyle(
              fontSize: valueSize,
              fontFamily: 'Inter',
              fontWeight: valueWeight,
              color: resolvedValueColor ?? Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
