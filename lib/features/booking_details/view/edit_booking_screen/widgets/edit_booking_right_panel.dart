import 'package:bookie_buddy_web/features/booking/domain/models/additional_charges_model/additional_charges_model.dart';
import 'package:bookie_buddy_web/features/booking/domain/models/booking_details_model/booking_details_model.dart';
import 'package:bookie_buddy_web/features/select_product_booking/models/product_selected_model/product_selected_model.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:bookie_buddy_web/features/staff/presentation/widgets/staff_search_name_field.dart';
import 'package:bookie_buddy_web/features/booking_details/view/edit_booking_screen/controller/edit_booking_form_state_controller.dart';
import 'package:bookie_buddy_web/features/booking_details/view/edit_booking_screen/widgets/edit_booking_button.dart';
import 'package:bookie_buddy_web/features/booking_details/view/edit_booking_screen/widgets/edit_booking_client_details_section.dart';
import 'package:flutter/material.dart';

/// Right panel widget for edit booking screen
/// Contains: Staff details, Client details, Summary, Action buttons
class EditBookingRightPanel extends StatelessWidget {
  final EditBookingFormStateController formController;
  final BookingDetailsModel booking;
  final ValueNotifier<List<ProductSelectedModel>> selectedProductsNotifier;
  final ValueNotifier<List<AdditionalChargesModel>> additionalChargesNotifier;
  final TextEditingController advanceAmountController;
  final TextEditingController discountAmountController;
  final TextEditingController securityAmountController;

  const EditBookingRightPanel({
    super.key,
    required this.formController,
    required this.booking,
    required this.selectedProductsNotifier,
    required this.additionalChargesNotifier,
    required this.advanceAmountController,
    required this.discountAmountController,
    required this.securityAmountController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Staff Details
        _buildCard(
          title: 'Staff Details',
          child: StaffSearchNameField(
            nameController: formController.staffNameController,
          ),
        ),
        const SizedBox(height: 12),

        // Client Details
        EditBookingClientDetailsSection(
          clientNameController: formController.clientNameController,
          clientPhone1Controller: formController.clientPhone1Controller,
          clientPhone2Controller: formController.clientPhone2Controller,
          clientAddressController: formController.clientAddressController,
          isClientSearchEnabledNotifier:
              formController.isClientSearchEnabledNotifier,
        ),

        const SizedBox(height: 12),

        // Payment Summary
        _buildPaymentSummary(),

        const SizedBox(height: 16),

        // Action Buttons
        EditBookingButton(
          formController: formController,
          booking: booking,
        ),
        const SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          height: 44,
          child: OutlinedButton(
            onPressed: () => Navigator.pop(context),
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: Colors.grey.shade400),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(
              'Cancel',
              style: TextStyle(
                color: Colors.grey.shade700,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCard({required String title, required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title.isNotEmpty) ...[
            Text(
              title,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
          ],
          child,
        ],
      ),
    );
  }

  Widget _buildPaymentSummary() {
    return ValueListenableBuilder<List<ProductSelectedModel>>(
      valueListenable: selectedProductsNotifier,
      builder: (context, products, _) {
        return ValueListenableBuilder<List<AdditionalChargesModel>>(
          valueListenable: additionalChargesNotifier,
          builder: (context, charges, _) {
            final productTotal = products.fold<int>(0,
                (sum, item) => sum + ((item.amount) * (item.quantity)).round());
            final additional = charges.fold<double>(
                0, (sum, item) => sum + (item.amount ?? 0).toDouble());

            final advance = double.tryParse(advanceAmountController.text) ?? 0;
            final discount =
                double.tryParse(discountAmountController.text) ?? 0;
            final security =
                double.tryParse(securityAmountController.text) ?? 0;

            final totalPayable =
                productTotal + additional + security - advance - discount;

            return Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: const Color(0xFFF6F4FF),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: const Color(0xFFEBE5FF)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Payment Summary',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF1A1A1A),
                    ),
                  ),
                  const SizedBox(height: 12),
                  _buildSummaryRow('Product total', '₹$productTotal'),
                  if (additional > 0) ...[
                    const SizedBox(height: 6),
                    _buildSummaryRow('Additional charges',
                        '₹${additional.toStringAsFixed(0)}'),
                  ],
                  if (security > 0) ...[
                    const SizedBox(height: 6),
                    _buildSummaryRow(
                        'Security', '₹${security.toStringAsFixed(0)}'),
                  ],
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Divider(height: 1, color: Color(0xFFE0D9FF)),
                  ),
                  if (advance > 0)
                    _buildSummaryRow('Paid', '₹${advance.toStringAsFixed(0)}',
                        valueColor: const Color(0xFF27AE60)),
                  if (discount > 0) ...[
                    const SizedBox(height: 6),
                    _buildSummaryRow(
                        'Discount', '-₹${discount.toStringAsFixed(0)}',
                        valueColor: const Color(0xFFE74C3C)),
                  ],
                  const SizedBox(height: 8),
                  _buildSummaryRow(
                      'Total payable', '₹${totalPayable.toStringAsFixed(0)}',
                      isTotal: true),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildSummaryRow(String label, String value,
      {Color? valueColor, bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isTotal ? 13 : 12,
            color: isTotal ? const Color(0xFF1A1A1A) : const Color(0xFF2D2D2D),
            fontWeight: isTotal ? FontWeight.w600 : FontWeight.w500,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: isTotal ? 14 : 12,
            fontWeight: FontWeight.w600,
            color: valueColor ??
                (isTotal ? AppColors.purple : const Color(0xFF1A1A1A)),
          ),
        ),
      ],
    );
  }
}
