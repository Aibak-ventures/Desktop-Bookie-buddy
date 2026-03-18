import 'package:bookie_buddy_web/utils/extensions/number_extensions.dart';
import 'package:bookie_buddy_web/utils/extensions/string_extensions.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:bookie_buddy_web/features/booking/domain/models/additional_charges_model/additional_charges_model.dart';
import 'package:bookie_buddy_web/features/select_product_booking/domain/models/product_selected_model/product_selected_model.dart';
import 'package:flutter/material.dart';

class BookingSummarySection extends StatelessWidget {
  final ValueNotifier<List<ProductSelectedModel>> selectedProductsNotifier;
  final ValueNotifier<List<AdditionalChargesModel>> additionalChargesNotifier;
  final TextEditingController advanceAmountController;
  final TextEditingController discountAmountController;
  final VoidCallback onConfirmBooking;
  final Color? confirmButtonColor;

  const BookingSummarySection({
    super.key,
    required this.selectedProductsNotifier,
    required this.additionalChargesNotifier,
    required this.advanceAmountController,
    required this.discountAmountController,
    required this.onConfirmBooking,
    this.confirmButtonColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Summary',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 16),
          // Summary items
          _buildSummaryContent(),
          const SizedBox(height: 20),
          // Confirm button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: onConfirmBooking,
              style: ElevatedButton.styleFrom(
                backgroundColor: confirmButtonColor ?? AppColors.green,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 0,
              ),
              child: const Text(
                'Confirm booking',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryContent() {
    return ListenableBuilder(
      listenable: Listenable.merge([
        selectedProductsNotifier,
        additionalChargesNotifier,
        discountAmountController,
      ]),
      builder: (context, _) {
        final products = selectedProductsNotifier.value;
        final additionalCharges = additionalChargesNotifier.value;
        final discountAmount =
            discountAmountController.text.trim().toIntOrNull() ?? 0;

        // Calculate product total
        final productTotal = products.fold<int>(
          0,
          (sum, product) => sum + (product.amount * product.quantity),
        );

        // Calculate additional charges total
        final additionalTotal = additionalCharges.fold<int>(
          0,
          (sum, charge) => sum + (charge.amount ?? 0),
        );

        // Calculate total payable
        final totalPayable = productTotal + additionalTotal - discountAmount;

        return Column(
          children: [
            // Hidden: Product total
            // _buildSummaryRow('Product total', productTotal),
            // const SizedBox(height: 8),

            // Hidden: Additional charges
            // _buildSummaryRow('Additional charges', additionalTotal),

            if (discountAmount > 0) ...[
              _buildSummaryRow('Discount', -discountAmount, isNegative: true),
              const SizedBox(height: 8),
            ],

            // Hidden: Paid (advance amount)
            // const Padding(
            //   padding: EdgeInsets.symmetric(vertical: 12),
            //   child: Divider(),
            // ),
            // _buildSummaryRow(
            //   'Paid',
            //   advanceAmount,
            //   valueColor: AppColors.green,
            //   isBold: true,
            // ),
            // const SizedBox(height: 8),

            _buildSummaryRow(
              'Total',
              totalPayable,
              valueColor: AppColors.purple,
              isBold: true,
              isLarge: true,
            ),
          ],
        );
      },
    );
  }

  Widget _buildSummaryRow(
    String label,
    int amount, {
    Color? valueColor,
    bool isBold = false,
    bool isLarge = false,
    bool isNegative = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isLarge ? 17 : 15,
            fontWeight: isBold ? FontWeight.w600 : FontWeight.w400,
            color: Colors.grey.shade700,
          ),
        ),
        Text(
          '${isNegative ? '-' : ''}${amount.abs().toCurrency()}',
          style: TextStyle(
            fontSize: isLarge ? 18 : 14,
            fontWeight: isBold ? FontWeight.w700 : FontWeight.w500,
            color: valueColor ?? Colors.black87,
          ),
        ),
      ],
    );
  }
}
