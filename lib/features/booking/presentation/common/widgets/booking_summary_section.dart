import 'package:bookie_buddy_web/core/constants/enums/service_type_enums.dart';
import 'package:bookie_buddy_web/core/constants/enums/booking_status_enums.dart';
import 'package:bookie_buddy_web/features/booking/presentation/common/booking_form/booking_form_controllers.dart';
import 'package:bookie_buddy_web/features/booking/presentation/common/booking_form/booking_form_mixin.dart';
import 'package:bookie_buddy_web/features/product/domain/entities/product_selected_entity/product_selected_entity.dart';
import 'package:bookie_buddy_web/utils/extensions/string_extensions.dart';
import 'package:flutter/material.dart';

/// Shared summary section used in the right-side panel of both
/// [NewBookingScreen] and [EditNewBookingScreen].
///
/// Displays product total, additional charges, discount, paid, and total
/// payable. Also includes an optional customization button and confirm button.
class BookingSummarySection extends StatefulWidget {
  final BookingFormControllers form;
  final bool isSales;
  final int Function() calculateRentalDays;

  /// Optional: customization button (only for dress/costume products)
  final VoidCallback? onShowCustomization;

  /// Optional: Booking status (for edit mode)
  final BookingStatus? bookingStatus;
  final String? bookingCompletedDate;

  /// Confirm button
  final VoidCallback onConfirm;
  final String confirmLabel;

  const BookingSummarySection({
    super.key,
    required this.form,
    required this.isSales,
    required this.calculateRentalDays,
    this.onShowCustomization,
    this.bookingStatus,
    this.bookingCompletedDate,
    required this.onConfirm,
    required this.confirmLabel,
  });

  @override
  State<BookingSummarySection> createState() => _BookingSummarySectionState();
}

class _BookingSummarySectionState extends State<BookingSummarySection>
    with BookingFormMixin<BookingSummarySection> {
  @override
  BookingFormControllers get form => widget.form;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 245, 242, 254),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.white),
      ),
      child: Column(
        children: [
          // Summary rows
          ListenableBuilder(
            listenable: Listenable.merge([
              form.selectedProductsNotifier,
              form.additionalChargesNotifier,
              form.advanceAmountController,
              form.discountAmountController,
              form.isDiscountPercentage,
            ]),
            builder: (context, _) {
              final products = form.selectedProductsNotifier.value;
              final additionalCharges = form.additionalChargesNotifier.value;
              final advanceAmount = widget.isSales
                  ? 0
                  : (form.advanceAmountController.text.trim().toIntOrNull() ??
                        0);

              final summaryRentalDays = !widget.isSales
                  ? widget.calculateRentalDays()
                  : 1;
              final productTotal = products.fold<int>(0, (sum, product) {
                final daysMultiplier =
                    (!widget.isSales &&
                        shouldMultiplyByDays(product.variant.mainServiceType))
                    ? (summaryRentalDays > 0 ? summaryRentalDays : 1)
                    : 1;
                return sum +
                    (product.amount * product.quantity * daysMultiplier);
              });
              final additionalTotal = additionalCharges.fold<int>(
                0,
                (sum, charge) => sum + (charge.amount ?? 0),
              );

              final discountInput =
                  form.discountAmountController.text.trim().toIntOrNull() ?? 0;
              int discountAmount;
              if (form.isDiscountPercentage.value) {
                discountAmount = (productTotal * discountInput / 100).round();
              } else {
                discountAmount = discountInput;
              }

              final totalPayable =
                  productTotal + additionalTotal - discountAmount;
              final remainingAmount = totalPayable - advanceAmount;

              return Column(
                children: [
                  if (widget.isSales)
                    buildSummaryRow(
                      'Total amount',
                      remainingAmount > 0 ? remainingAmount : 0,
                      valueColor: const Color(0xFF6132E4),
                      isBold: true,
                    )
                  else ...[
                    buildSummaryRow('Product total', productTotal),
                    if (additionalTotal > 0)
                      buildSummaryRow('Additional charges', additionalTotal),
                    if (discountAmount > 0)
                      buildSummaryRow(
                        '- Discount',
                        discountAmount,
                        isNegative: true,
                      ),
                    const Divider(height: 6),
                    buildSummaryRow(
                      'Paid',
                      advanceAmount,
                      valueColor: const Color(0xFF1AB000),
                    ),
                    buildSummaryRow(
                      'Total payable',
                      remainingAmount > 0 ? remainingAmount : 0,
                      valueColor: const Color(0xFFD30000),
                      isBold: true,
                    ),
                  ],
                ],
              );
            },
          ),

          // Customization button — only for dresses/costumes
          if (widget.onShowCustomization != null)
            ValueListenableBuilder<List<ProductSelectedEntity>>(
              valueListenable: form.selectedProductsNotifier,
              builder: (context, products, _) {
                // Hide customization button for sales mode
                if (widget.isSales) return const SizedBox.shrink();

                final hasDressesOrCostumes = products.any(
                  (p) =>
                      (p.variant.mainServiceType?.isDress ?? false) ||
                      (p.variant.mainServiceType?.isCostume ?? false),
                );
                if (!hasDressesOrCostumes) return const SizedBox.shrink();

                // Check if any dress/costume product has measurements
                final hasCustomizations = products.any(
                  (p) =>
                      ((p.variant.mainServiceType?.isDress ?? false) ||
                          (p.variant.mainServiceType?.isCostume ?? false)) &&
                      p.measurements.isNotEmpty,
                );

                return Column(
                  children: [
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      height: 36,
                      child: OutlinedButton(
                        onPressed: widget.onShowCustomization,
                        style: OutlinedButton.styleFrom(
                          backgroundColor: hasCustomizations
                              ? const Color(0xFFF3F0FF)
                              : Colors.transparent,
                          foregroundColor: hasCustomizations
                              ? const Color(0xFF6132E4)
                              : Colors.grey.shade600,
                          side: BorderSide(
                            color: hasCustomizations
                                ? const Color(0xFF6132E4)
                                : Colors.grey.shade300,
                            width: 1,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              hasCustomizations
                                  ? Icons.edit_outlined
                                  : Icons.add,
                              size: 16,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              hasCustomizations
                                  ? 'Edit customization'
                                  : 'Add customization (Optional)',
                              style: const TextStyle(
                                fontSize: 13,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),

          const SizedBox(height: 8),

          // Show completed/cancelled status info
          if (widget.bookingStatus == BookingStatus.completed &&
              widget.bookingCompletedDate != null)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFE8F5E9),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: const Color(0xFF4CAF50)),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.check_circle,
                    color: Color(0xFF4CAF50),
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Booking Completed',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF2E7D32),
                          ),
                        ),
                        Text(
                          'Completed on: ${widget.bookingCompletedDate}',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          else if (widget.bookingStatus == BookingStatus.cancelled)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFFFEBEE),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: const Color(0xFFF44336)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.cancel, color: Color(0xFFF44336), size: 20),
                  const SizedBox(width: 8),
                  const Expanded(
                    child: Text(
                      'Booking Cancelled',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFFC62828),
                      ),
                    ),
                  ),
                ],
              ),
            )
          else
            // Confirm button
            SizedBox(
              width: double.infinity,
              height: 39,
              child: ElevatedButton(
                onPressed: widget.onConfirm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF6132E4),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  widget.confirmLabel,
                  style: const TextStyle(
                    fontSize: 14,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
