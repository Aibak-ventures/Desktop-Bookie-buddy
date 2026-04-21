import 'package:bookie_buddy_web/core/constants/enums/app_premium_features_enum.dart';
import 'package:bookie_buddy_web/core/constants/enums/payment_method_enums.dart';
import 'package:bookie_buddy_web/features/auth/presentation/bloc/user_cubit/user_cubit.dart';
import 'package:bookie_buddy_web/features/booking/presentation/common/booking_form/booking_form_controllers.dart';
import 'package:bookie_buddy_web/features/booking/presentation/new_booking/helpers/booking_text_field_builder.dart';
import 'package:bookie_buddy_web/features/booking/presentation/new_booking/widgets/booking_payment_method_section.dart';
import 'package:bookie_buddy_web/features/staff/presentation/widgets/staff_search_name_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Right-side panel shown when the booking type is Sales.
/// Extracted from NewBookingScreen to keep the screen file lean.
class BookingSalesRightPanel extends StatelessWidget {
  const BookingSalesRightPanel({
    super.key,
    required this.form,
    required this.phoneError,
    required this.staffNameError,
    required this.sendPdfToWhatsApp,
    required this.onSendPdfChanged,
    required this.selectedPaymentMethod,
    required this.onPaymentMethodChanged,
    required this.decreaseStockForPastDate,
    required this.onDecreaseStockChanged,
    required this.isPastDate,
    required this.summarySection,
  });

  final BookingFormControllers form;
  final String? phoneError;
  final String? staffNameError;
  final bool sendPdfToWhatsApp;
  final ValueChanged<bool> onSendPdfChanged;
  final PaymentMethod selectedPaymentMethod;
  final ValueChanged<PaymentMethod> onPaymentMethodChanged;
  final bool decreaseStockForPastDate;
  final ValueChanged<bool> onDecreaseStockChanged;
  final bool isPastDate;
  final Widget summarySection;

  static const double _fieldSpacing = 8.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BookingTextFieldBuilder.buildRightPanelTextField(
                    controller: form.clientPhone1Controller,
                    hint: 'Client Phone (WP)',
                    isNumber: true,
                    errorText: phoneError,
                    prefixIcon: Icons.phone,
                  ),
                  const SizedBox(height: _fieldSpacing),
                  BookingTextFieldBuilder.buildRightPanelTextField(
                    controller: form.clientAddressController,
                    hint: 'Place',
                    prefixIcon: Icons.location_on,
                  ),
                  const SizedBox(height: _fieldSpacing),
                  const Text(
                    'Staff',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 7),
                  StaffSearchNameField(
                    nameController: form.staffNameController,
                    errorText: staffNameError,
                  ),
                  const SizedBox(height: _fieldSpacing),
                  _buildNotesField(),
                  const SizedBox(height: _fieldSpacing),
                  ValueListenableBuilder<bool>(
                    valueListenable: form.isDiscountPercentage,
                    builder: (context, isPercent, _) {
                      return Row(
                        children: [
                          Expanded(
                            child: BookingTextFieldBuilder.buildRightPanelTextField(
                              controller: form.discountAmountController,
                              hint: isPercent ? 'Discount %' : 'Discount amount',
                              isNumber: true,
                            ),
                          ),
                          const SizedBox(width: 8),
                          PopupMenuButton<String>(
                            icon: Icon(
                              Icons.more_vert,
                              color: Colors.grey.shade600,
                            ),
                            onSelected: (value) {
                              form.isDiscountPercentage.value =
                                  value == 'percentage';
                              form.discountAmountController.clear();
                            },
                            itemBuilder: (context) => [
                              PopupMenuItem(
                                value: 'amount',
                                child: Row(
                                  children: [
                                    Icon(
                                      isPercent
                                          ? Icons.circle_outlined
                                          : Icons.check_circle,
                                      size: 18,
                                      color: isPercent
                                          ? Colors.grey
                                          : const Color(0xFF6132E4),
                                    ),
                                    const SizedBox(width: 8),
                                    const Text('Amount (₹)'),
                                  ],
                                ),
                              ),
                              PopupMenuItem(
                                value: 'percentage',
                                child: Row(
                                  children: [
                                    Icon(
                                      isPercent
                                          ? Icons.check_circle
                                          : Icons.circle_outlined,
                                      size: 18,
                                      color: isPercent
                                          ? const Color(0xFF6132E4)
                                          : Colors.grey,
                                    ),
                                    const SizedBox(width: 8),
                                    const Text('Percentage (%)'),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    },
                  ),
                  const SizedBox(height: _fieldSpacing),
                  BookingPaymentMethodSection(
                    selectedPaymentMethod: selectedPaymentMethod,
                    onChanged: onPaymentMethodChanged,
                  ),
                  const SizedBox(height: 16),
                  _buildWhatsAppCheckbox(context),
                  if (isPastDate) _buildPastDateStockCheckbox(),
                ],
              ),
            ),
          ),
          summarySection,
        ],
      ),
    );
  }

  Widget _buildNotesField() {
    return Container(
      height: 80,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextField(
        controller: form.descriptionController,
        maxLines: null,
        expands: true,
        decoration: const InputDecoration(
          border: InputBorder.none,
          hintText: 'Notes',
          hintStyle: TextStyle(fontSize: 13, color: Colors.grey),
        ),
        style: const TextStyle(fontSize: 13),
      ),
    );
  }

  Widget _buildWhatsAppCheckbox(BuildContext context) {
    if (!context.read<UserCubit>().hasFeature(AppPremiumFeatures.whatsappMessage))
      return const SizedBox.shrink();
    return Row(
      children: [
        Checkbox(
          value: sendPdfToWhatsApp,
          onChanged: (v) => onSendPdfChanged(v ?? false),
          activeColor: Colors.black87,
        ),
        const Text(
          'Send invoice to whatsapp',
          style: TextStyle(fontSize: 13, color: Colors.grey),
        ),
      ],
    );
  }

  Widget _buildPastDateStockCheckbox() {
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: const Color(0xFFF5F2FE),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Checkbox(
              value: decreaseStockForPastDate,
              onChanged: (v) => onDecreaseStockChanged(v ?? false),
            ),
            const Expanded(
              child: Text(
                'Decrease Stock quantity',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
