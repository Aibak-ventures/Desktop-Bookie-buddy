import 'package:bookie_buddy_web/core/extensions/number_extensions.dart';
import 'package:bookie_buddy_web/core/extensions/string_extensions.dart';
import 'package:bookie_buddy_web/features/add_booking/models/additional_charges_model/additional_charges_model.dart';
import 'package:bookie_buddy_web/features/select_product_booking/models/product_selected_model/product_selected_model.dart';
import 'package:flutter/material.dart';

class BookingSummarySection extends StatelessWidget {
  final ValueNotifier<List<ProductSelectedModel>> selectedProductsNotifier;
  final ValueNotifier<List<AdditionalChargesModel>> additionalChargesNotifier;
  final TextEditingController advanceAmountController;
  final TextEditingController discountAmountController;
  final VoidCallback onConfirmBooking;

  const BookingSummarySection({
    super.key,
    required this.selectedProductsNotifier,
    required this.additionalChargesNotifier,
    required this.advanceAmountController,
    required this.discountAmountController,
    required this.onConfirmBooking,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 245, 242, 254),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        children: [
          ListenableBuilder(
            listenable: Listenable.merge([
              selectedProductsNotifier,
              additionalChargesNotifier,
              advanceAmountController,
              discountAmountController,
            ]),
            builder: (context, _) {
              final products = selectedProductsNotifier.value;
              final additionalCharges = additionalChargesNotifier.value;
              final advanceAmount =
                  advanceAmountController.text.trim().toIntOrNull() ?? 0;
              final discountAmount =
                  discountAmountController.text.trim().toIntOrNull() ?? 0;

              final productTotal = products.fold<int>(
                0,
                (sum, product) => sum + (product.amount * product.quantity),
              );
              final additionalTotal = additionalCharges.fold<int>(
                0,
                (sum, charge) => sum + (charge.amount ?? 0),
              );
              final totalPayable =
                  productTotal + additionalTotal - discountAmount;
              final remainingAmount = totalPayable - advanceAmount;

              return Column(
                children: [
                  _buildSummaryRow('Product total', productTotal),
                  if (additionalTotal > 0)
                    _buildSummaryRow('Additional charges', additionalTotal),
                  if (discountAmount > 0)
                    _buildSummaryRow('- Discount', discountAmount,
                        isNegative: true),
                  const Divider(height: 6),
                  _buildSummaryRow('Paid', advanceAmount,
                      valueColor: const Color(0xFF1AB000)),
                  _buildSummaryRow(
                    'Total payable',
                    remainingAmount > 0 ? remainingAmount : 0,
                    valueColor: const Color(0xFFD30000),
                    isBold: true,
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    height: 45,
                    child: ElevatedButton(
                      onPressed: onConfirmBooking,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF6132E4),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        elevation: 0,
                      ),
                      child: const Text(
                        'Confirm Booking',
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
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
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: isLarge ? 15 : 13,
              fontWeight: isBold ? FontWeight.w600 : FontWeight.w400,
              color: Colors.grey.shade700,
            ),
          ),
          Text(
            '${isNegative ? '-' : ''}${amount.abs().toCurrency()}',
            style: TextStyle(
              fontSize: isLarge ? 15 : 13,
              fontWeight: isBold ? FontWeight.w700 : FontWeight.w500,
              color: valueColor ?? Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
