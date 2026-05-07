import 'package:bookie_buddy_web/core/common/widgets/expandable_summary_tile.dart';
import 'package:bookie_buddy_web/core/constants/enums/booking_status_enums.dart';
import 'package:bookie_buddy_web/core/constants/enums/service_type_enums.dart';
import 'package:bookie_buddy_web/features/booking/domain/entities/additional_charges_entity/additional_charges_entity.dart';
import 'package:bookie_buddy_web/features/product/domain/entities/product_selected_entity/product_selected_entity.dart';
import 'package:bookie_buddy_web/utils/extensions/number_extensions.dart';
import 'package:bookie_buddy_web/utils/extensions/string_extensions.dart';
import 'package:flutter/material.dart';

/// Standalone reactive summary tile — shows the amount breakdown without any
/// action buttons. Use this when you only need to display the summary (e.g.
/// in a read-only panel or a details drawer).
class BookingAmountSummary extends StatelessWidget {
  final ValueNotifier<List<ProductSelectedEntity>> selectedProductsNotifier;
  final ValueNotifier<List<AdditionalChargesEntity>> additionalChargesNotifier;
  final TextEditingController advanceAmountController;
  final TextEditingController discountAmountController;
  final ValueNotifier<bool> isDiscountPercentage;
  final TextEditingController securityAmountController;

  /// Display name for the security payment method.
  final String securityMethodLabel;

  final bool isSales;
  final int Function() calculateRentalDays;

  /// Label for the advance/paid row (e.g. 'Advance' for add, 'Paid' for edit).
  final String advanceLabel;

  /// Header label on the expandable tile.
  final String totalRemainingLabel;

  const BookingAmountSummary({
    super.key,
    required this.selectedProductsNotifier,
    required this.additionalChargesNotifier,
    required this.advanceAmountController,
    required this.discountAmountController,
    required this.isDiscountPercentage,
    required this.securityAmountController,
    required this.securityMethodLabel,
    required this.isSales,
    required this.calculateRentalDays,
    this.advanceLabel = 'Paid',
    this.totalRemainingLabel = 'Total Payable Amount',
  });

  bool _shouldMultiplyByDays(MainServiceType? type) =>
      type?.requiresDateRange ?? false;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: Listenable.merge([
        selectedProductsNotifier,
        additionalChargesNotifier,
        advanceAmountController,
        discountAmountController,
        isDiscountPercentage,
        securityAmountController,
      ]),
      builder: (context, _) {
        final products = selectedProductsNotifier.value;
        final additionalCharges = additionalChargesNotifier.value;
        final advanceAmount = isSales
            ? 0
            : (advanceAmountController.text.trim().toIntOrNull() ?? 0);
        final securityAmount = isSales
            ? 0
            : (int.tryParse(securityAmountController.text.trim()) ?? 0);

        final summaryRentalDays = !isSales ? calculateRentalDays() : 1;
        final productTotal = products.fold<int>(0, (sum, product) {
          final daysMultiplier =
              (!isSales &&
                  _shouldMultiplyByDays(product.variant.mainServiceType))
              ? (summaryRentalDays > 0 ? summaryRentalDays : 1)
              : 1;
          return sum + (product.amount * product.quantity * daysMultiplier);
        });
        final additionalTotal = additionalCharges.fold<int>(
          0,
          (sum, charge) => sum + (charge.amount ?? 0),
        );

        final discountInput =
            discountAmountController.text.trim().toIntOrNull() ?? 0;
        final discountAmount = isDiscountPercentage.value
            ? ((productTotal + additionalTotal) * discountInput / 100).round()
            : discountInput;

        final totalPayable = productTotal + additionalTotal - discountAmount;

        if (isSales) {
          final clampedTotal = totalPayable > 0 ? totalPayable : 0;
          final salesFields = <SummaryField>[
            SummaryField(
              label: 'Product total',
              value: productTotal.toCurrency(),
            ),
            if (additionalTotal > 0)
              SummaryField(
                label: 'Additional charges',
                value: additionalTotal.toCurrency(),
              ),
            if (discountAmount > 0)
              SummaryField(
                label: 'Discount',
                value: '- ${discountAmount.toCurrency()}',
                color: const Color(0xFFD30000),
              ),
            SummaryField(
              label: 'Total',
              value: clampedTotal.toCurrency(),
              labelStyle: const TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w600,
                fontSize: 13,
              ),
              valueStyle: const TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w700,
                fontSize: 13,
              ),
            ),
          ];
          return ExpandableSummaryTile(
            totalLabel: totalRemainingLabel,
            totalValue: clampedTotal.toCurrency(),
            fields: salesFields,
          );
        }

        final netRemaining = (totalPayable - advanceAmount)
            .clamp(0, 999999999)
            .toInt();
        final pendingTotal =
            productTotal + securityAmount + additionalTotal - discountAmount;
        final receivedTotal = advanceAmount + securityAmount;

        final summaryPayableFields = <SummaryField>[
          SummaryField(
            label: 'Product total',
            value: productTotal.toCurrency(),
          ),
          if (securityAmount > 0)
            SummaryField(
              label: 'Security Deposit',
              value: securityAmount.toCurrency(),
            ),
          if (additionalTotal > 0)
            SummaryField(
              label: 'Additional charges',
              value: additionalTotal.toCurrency(),
            ),
          if (discountAmount > 0)
            SummaryField(
              label: 'Discount',
              value: '- ${discountAmount.toCurrency()}',
              color: const Color(0xFFD30000),
            ),
        ];

        final summaryReceivedFields = <SummaryField>[
          if (advanceAmount > 0)
            SummaryField(
              label: advanceLabel,
              value: advanceAmount.toCurrency(),
              valueStyle: const TextStyle(fontSize: 13),
            ),
          if (securityAmount > 0)
            SummaryField(
              label: 'Security Deposit ($securityMethodLabel)',
              value: securityAmount.toCurrency(),
            ),
        ];

        final allFields = <SummaryField>[
          ...summaryPayableFields,
          if (pendingTotal > 0)
            SummaryField(
              label: 'Total',
              value: pendingTotal.toCurrency(),
              labelStyle: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 13,
              ),
              valueStyle: const TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w700,
                fontSize: 13,
              ),
            ),
          if (summaryReceivedFields.isNotEmpty)
            const SummaryField(label: '', value: '', showDivider: true),
          ...summaryReceivedFields,
          if (receivedTotal > 0)
            SummaryField(
              label: 'Total',
              value: receivedTotal.toCurrency(),
              labelStyle: const TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w600,
                fontSize: 13,
              ),
              valueStyle: const TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w700,
                fontSize: 13,
              ),
            ),
        ];

        return ExpandableSummaryTile(
          totalLabel: totalRemainingLabel,
          totalValue: netRemaining.toCurrency(),
          subLabel: advanceAmount > 0
              ? 'paid ${receivedTotal.toCurrency()}'
              : null,
          fields: allFields,
        );
      },
    );
  }
}

/// Full summary panel used in booking and sales form screens. Wraps
/// [BookingAmountSummary] and adds the customization button, status banners,
/// and confirm/save action button.
class BookingSummarySection extends StatelessWidget {
  final ValueNotifier<List<ProductSelectedEntity>> selectedProductsNotifier;
  final ValueNotifier<List<AdditionalChargesEntity>> additionalChargesNotifier;
  final TextEditingController advanceAmountController;
  final TextEditingController discountAmountController;
  final ValueNotifier<bool> isDiscountPercentage;
  final TextEditingController securityAmountController;

  /// Display name for the security payment method (e.g. account name or
  /// payment method label). Evaluated at widget-creation time via parent
  /// setState — updates are reflected on the next listenable rebuild.
  final String securityMethodLabel;

  final bool isSales;
  final int Function() calculateRentalDays;

  /// Optional: customization button (only for dress/costume products)
  final VoidCallback? onShowCustomization;

  /// Optional: booking status (for edit mode banners)
  final BookingStatus? bookingStatus;
  final String? bookingCompletedDate;

  /// Label for the advance/paid field in the received section.
  /// Use 'Advance' for add booking, 'Paid' for edit booking.
  final String advanceLabel;

  /// Header label on the expandable tile.
  /// Use 'Total Payable Amount' for add, 'Balance Amount' for edit.
  final String totalRemainingLabel;

  /// Confirm button
  final VoidCallback onConfirm;
  final String confirmLabel;

  const BookingSummarySection({
    super.key,
    required this.selectedProductsNotifier,
    required this.additionalChargesNotifier,
    required this.advanceAmountController,
    required this.discountAmountController,
    required this.isDiscountPercentage,
    required this.securityAmountController,
    required this.securityMethodLabel,
    required this.isSales,
    required this.calculateRentalDays,
    this.advanceLabel = 'Paid',
    this.totalRemainingLabel = 'Total Payable Amount',
    this.onShowCustomization,
    this.bookingStatus,
    this.bookingCompletedDate,
    required this.onConfirm,
    required this.confirmLabel,
  });

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
          BookingAmountSummary(
            selectedProductsNotifier: selectedProductsNotifier,
            additionalChargesNotifier: additionalChargesNotifier,
            advanceAmountController: advanceAmountController,
            discountAmountController: discountAmountController,
            isDiscountPercentage: isDiscountPercentage,
            securityAmountController: securityAmountController,
            securityMethodLabel: securityMethodLabel,
            isSales: isSales,
            calculateRentalDays: calculateRentalDays,
            advanceLabel: advanceLabel,
            totalRemainingLabel: totalRemainingLabel,
          ),

          // Customization button — only for dresses/costumes
          if (onShowCustomization != null)
            ValueListenableBuilder<List<ProductSelectedEntity>>(
              valueListenable: selectedProductsNotifier,
              builder: (context, products, _) {
                if (isSales) return const SizedBox.shrink();

                final hasDressesOrCostumes = products.any(
                  (p) =>
                      (p.variant.mainServiceType?.isDress ?? false) ||
                      (p.variant.mainServiceType?.isCostume ?? false),
                );
                if (!hasDressesOrCostumes) return const SizedBox.shrink();

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
                        onPressed: onShowCustomization,
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
          if (bookingStatus == BookingStatus.completed &&
              bookingCompletedDate != null)
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
                          'Completed on: $bookingCompletedDate',
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
          else if (bookingStatus == BookingStatus.cancelled)
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
            SizedBox(
              width: double.infinity,
              height: 39,
              child: ElevatedButton(
                onPressed: onConfirm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF6132E4),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  confirmLabel,
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
