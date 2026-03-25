import 'package:bookie_buddy_web/core/constants/enums/payment_method_enums.dart';
import 'package:bookie_buddy_web/core/constants/enums/service_type_enums.dart';
import 'package:bookie_buddy_web/features/booking/domain/entities/additional_charges_entity/additional_charges_entity.dart';
import 'package:bookie_buddy_web/features/booking/presentation/common/booking_form/booking_form_controllers.dart';
import 'package:bookie_buddy_web/features/booking/presentation/common/booking_form/booking_form_mixin.dart';
import 'package:bookie_buddy_web/features/booking/presentation/new_booking/helpers/booking_text_field_builder.dart';
import 'package:bookie_buddy_web/features/product/domain/entities/product_selected_entity/product_selected_entity.dart';
import 'package:flutter/material.dart';

class BookingPaymentSummaryPanel extends StatefulWidget {
  final BookingFormControllers form;
  final PaymentMethod? selectedPaymentMethod;
  final ValueChanged<PaymentMethod>? onPaymentMethodChanged;
  final VoidCallback onBack;
  final Widget summarySection;

  const BookingPaymentSummaryPanel({
    super.key,
    required this.form,
    this.selectedPaymentMethod,
    this.onPaymentMethodChanged,
    required this.onBack,
    required this.summarySection,
  });

  @override
  State<BookingPaymentSummaryPanel> createState() =>
      _BookingPaymentSummaryPanelState();
}

class _BookingPaymentSummaryPanelState
    extends State<BookingPaymentSummaryPanel>
    with BookingFormMixin<BookingPaymentSummaryPanel> {
  static const double _fieldSpacing = 8.0;

  @override
  BookingFormControllers get form => widget.form;

  @override
  Widget build(BuildContext context) {
    return Container(
      key: const ValueKey(1),
      color: Colors.white,
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Back Button
                  InkWell(
                    onTap: widget.onBack,
                    child: Row(
                      children: [
                        Icon(
                          Icons.arrow_back,
                          size: 20,
                          color: Colors.grey.shade700,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Back',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade700,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Locations - Only for Vehicles
                  ValueListenableBuilder<List<ProductSelectedEntity>>(
                    valueListenable: form.selectedProductsNotifier,
                    builder: (context, products, _) {
                      final hasVehicles = products.any(
                        (p) => p.variant.mainServiceType?.isVehicle ?? false,
                      );
                      if (!hasVehicles) return const SizedBox.shrink();
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          BookingTextFieldBuilder.buildSectionHeader(
                            'Locations',
                            optional: true,
                          ),
                          const SizedBox(height: _fieldSpacing),
                          BookingTextFieldBuilder.buildRightPanelTextField(
                            controller: form.startLocationController,
                            hint: 'Start location',
                          ),
                          const SizedBox(height: _fieldSpacing),
                          BookingTextFieldBuilder.buildRightPanelTextField(
                            controller: form.pickupLocationController,
                            hint: 'Pickup location',
                          ),
                          const SizedBox(height: _fieldSpacing),
                          BookingTextFieldBuilder.buildRightPanelTextField(
                            controller: form.destinationLocationController,
                            hint: 'Destination',
                          ),
                          const SizedBox(height: 14),
                        ],
                      );
                    },
                  ),

                  // Payment details
                  BookingTextFieldBuilder.buildSectionHeader(
                    'Payment details',
                    optional: true,
                  ),
                  const SizedBox(height: _fieldSpacing),
                  BookingTextFieldBuilder.buildRightPanelTextField(
                    controller: form.advanceAmountController,
                    hint: 'Advance amount',
                    isNumber: true,
                  ),
                  const SizedBox(height: _fieldSpacing),
                  BookingTextFieldBuilder.buildRightPanelTextField(
                    controller: form.securityAmountController,
                    hint: 'Security amount',
                    isNumber: true,
                  ),
                  const SizedBox(height: _fieldSpacing),
                  BookingTextFieldBuilder.buildRightPanelTextField(
                    controller: form.discountAmountController,
                    hint: 'Discount amount',
                    isNumber: true,
                  ),

                  const SizedBox(height: 14),
                  // Payment Method Selection - only show if advance amount has value
                  ValueListenableBuilder<TextEditingValue>(
                    valueListenable: form.advanceAmountController,
                    builder: (context, value, child) {
                      final hasAdvanceAmount =
                          value.text.trim().isNotEmpty &&
                          (int.tryParse(value.text.trim()) ?? 0) > 0;
                      if (hasAdvanceAmount && widget.selectedPaymentMethod != null && widget.onPaymentMethodChanged != null) {
                        return Column(
                          children: [
                            _buildPaymentMethodSection(),
                            const SizedBox(height: 14),
                          ],
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),

                  // Additional Charges
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Additional charges',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      InkWell(
                        onTap: addAdditionalCharge,
                        borderRadius: BorderRadius.circular(4),
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: const Color(0xFF6132E4).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: const Icon(
                            Icons.add,
                            size: 16,
                            color: Color(0xFF6132E4),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  // Additional charges list
                  ValueListenableBuilder<List<AdditionalChargesEntity>>(
                    valueListenable: form.additionalChargesNotifier,
                    builder: (context, charges, _) {
                      if (charges.isEmpty) return const SizedBox();
                      return Column(
                        children: charges.map((charge) {
                          return Container(
                            margin: const EdgeInsets.only(bottom: 6),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 10,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF8F9FA),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: const Color(
                                  0xFF6132E4,
                                ).withOpacity(0.2),
                                width: 1.5,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.03),
                                  blurRadius: 4,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    charge.name ?? 'Charge',
                                    style: const TextStyle(
                                      fontSize: 13,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFF2D2D2D),
                                    ),
                                  ),
                                ),
                                Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 4,
                                      ),
                                      decoration: BoxDecoration(
                                        color: const Color(
                                          0xFF6132E4,
                                        ).withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      child: Text(
                                        '₹${charge.amount ?? 0}',
                                        style: const TextStyle(
                                          fontSize: 13,
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w700,
                                          color: Color(0xFF6132E4),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    InkWell(
                                      onTap: () => removeCharge(charge),
                                      child: Container(
                                        padding: const EdgeInsets.all(4),
                                        decoration: BoxDecoration(
                                          color: Colors.red.shade50,
                                          shape: BoxShape.circle,
                                        ),
                                        child: Icon(
                                          Icons.close,
                                          size: 14,
                                          color: Colors.red.shade600,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),

          // Fixed Bottom Section
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.transparent,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, -5),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Summary',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 16),
                widget.summarySection,
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentMethodSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Payment Method',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            _buildPaymentMethodOption(PaymentMethod.gPay, Icons.qr_code),
            const SizedBox(width: 8),
            _buildPaymentMethodOption(PaymentMethod.cash, Icons.money),
          ],
        ),
      ],
    );
  }

  Widget _buildPaymentMethodOption(PaymentMethod method, IconData icon) {
    final isSelected = widget.selectedPaymentMethod == method;
    return Expanded(
      child: InkWell(
        onTap: () => widget.onPaymentMethodChanged?.call(method),
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            border: Border.all(
              color: isSelected
                  ? const Color(0xFF6132E4)
                  : Colors.grey.shade300,
              width: isSelected ? 1.5 : 1,
            ),
            borderRadius: BorderRadius.circular(8),
            color: isSelected
                ? const Color(0xFF6132E4).withOpacity(0.05)
                : Colors.white,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 20,
                color: isSelected
                    ? const Color(0xFF6132E4)
                    : Colors.grey.shade700,
              ),
              const SizedBox(width: 8),
              Text(
                method.name,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                  color: isSelected
                      ? const Color(0xFF6132E4)
                      : Colors.grey.shade700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
