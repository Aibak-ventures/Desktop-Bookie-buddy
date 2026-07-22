import 'package:bookie_buddy_web/core/common/entities/applied_tax_entity/applied_tax_entity.dart';
import 'package:bookie_buddy_web/core/common/widgets/tax_info_button.dart';
import 'package:bookie_buddy_web/features/sales/domain/entities/sale_details_entity/sale_details_entity.dart';
import 'package:bookie_buddy_web/utils/extensions/number_extensions.dart';
import 'package:flutter/material.dart';

/// Payment details section for [SalesDetailsDrawer].
class SalesDetailsPaymentSection extends StatelessWidget {
  final SaleDetailsEntity sale;

  const SalesDetailsPaymentSection({super.key, required this.sale});

  @override
  Widget build(BuildContext context) {
    final subtotal = sale.products.fold<int>(
      0,
      (sum, item) => sum + item.subtotal,
    );
    final appliedTaxes = sale.appliedTaxes.appliedOnly;
    final totalTaxAmount = appliedTaxes.totalTaxAmount;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Payment details',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 12),
          if (sale.accountName != null)
            Row(
              children: [
                Text(
                  'Payment Option: ',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey.shade700,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Spacer(),
                Text(
                  sale.accountName ?? '—',
                  style: const TextStyle(
                    fontSize: 13,
                    color: Colors.black87,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          const SizedBox(height: 16),
          _buildPaymentRow('Subtotal', '₹$subtotal'),
          const SizedBox(height: 8),
          if (sale.discountAmount > 0) ...[
            _buildPaymentRow(
              'Discount',
              '- ₹${sale.discountAmount}',
              valueColor: Colors.red.shade600,
            ),
            const SizedBox(height: 8),
          ],
          const Divider(height: 24),
          if (totalTaxAmount > 0) ...[
            _buildTaxRow(appliedTaxes, totalTaxAmount),
            const SizedBox(height: 8),
          ],
          _buildPaymentRow(
            'Grand Total',
            '₹${sale.paidAmount}',
            isBold: true,
            fontSize: 15,
          ),
        ],
      ),
    );
  }

  Widget _buildTaxRow(List<AppliedTaxEntity> appliedTaxes, int totalTaxAmount) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            const Text(
              'Tax amount',
              style: TextStyle(
                fontSize: 13,
                color: Colors.black87,
                fontWeight: FontWeight.w400,
              ),
            ),
            TaxAllInfoButton(taxes: appliedTaxes),
          ],
        ),
        Text(
          totalTaxAmount.toCurrency(),
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }

  Widget _buildPaymentRow(
    String label,
    String value, {
    bool isBold = false,
    Color? valueColor,
    double? fontSize,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: fontSize ?? 13,
            color: Colors.black87,
            fontWeight: isBold ? FontWeight.w600 : FontWeight.w400,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: fontSize ?? 13,
            fontWeight: isBold ? FontWeight.w700 : FontWeight.w600,
            color: valueColor ?? Colors.black87,
          ),
        ),
      ],
    );
  }
}
