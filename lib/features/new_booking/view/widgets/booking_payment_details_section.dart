import 'package:bookie_buddy_web/core/extensions/number_extensions.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:bookie_buddy_web/features/add_booking/models/additional_charges_model/additional_charges_model.dart';
import 'package:bookie_buddy_web/features/new_booking/view/widgets/booking_address_autocomplete_field.dart';
import 'package:bookie_buddy_web/features/new_booking/view/widgets/booking_summary_section.dart';
import 'package:bookie_buddy_web/features/select_product_booking/models/product_selected_model/product_selected_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BookingPaymentDetailsSection extends StatelessWidget {
  final TextEditingController startLocationController;
  final TextEditingController pickupLocationController;
  final TextEditingController destinationController;
  final TextEditingController advanceAmountController;
  final TextEditingController securityAmountController;
  final TextEditingController discountAmountController;
  final ValueNotifier<List<AdditionalChargesModel>> additionalChargesNotifier;
  final ValueNotifier<List<ProductSelectedModel>> selectedProductsNotifier;
  final VoidCallback onBack;
  final VoidCallback onConfirmBooking;

  static const double kFieldSpacing = 10.0;

  const BookingPaymentDetailsSection({
    super.key,
    required this.startLocationController,
    required this.pickupLocationController,
    required this.destinationController,
    required this.advanceAmountController,
    required this.securityAmountController,
    required this.discountAmountController,
    required this.additionalChargesNotifier,
    required this.selectedProductsNotifier,
    required this.onBack,
    required this.onConfirmBooking,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Back Button Header
                  Row(
                    children: [
                      InkWell(
                        onTap: onBack,
                        child: Icon(Icons.arrow_back,
                            size: 18, color: Colors.grey.shade700),
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        'Details',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Locations Section
                  Row(
                    children: const [
                      Text(
                        'Locations',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF3E3E3E),
                        ),
                      ),
                      SizedBox(width: 4),
                      Text(
                        '(optional)',
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xFF8C8C8C),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  BookingAddressAutocompleteField(
                      label: "Start location",
                      controller: startLocationController),
                  const SizedBox(height: kFieldSpacing),
                  BookingAddressAutocompleteField(
                      label: "Pickup location",
                      controller: pickupLocationController),
                  const SizedBox(height: kFieldSpacing),
                  BookingAddressAutocompleteField(
                      label: "Destination location",
                      controller: destinationController),

                  const SizedBox(height: 16),

                  // Payment Details Section
                  Row(
                    children: const [
                      Text(
                        'Payment details',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF3E3E3E),
                        ),
                      ),
                      SizedBox(width: 4),
                      Text(
                        '(optional)',
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xFF8C8C8C),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  _buildCompactAmountField(
                      controller: advanceAmountController,
                      label: "Advance amount"),
                  const SizedBox(height: kFieldSpacing),
                  _buildCompactAmountField(
                      controller: securityAmountController,
                      label: "Security amount"),
                  const SizedBox(height: kFieldSpacing),
                  _buildCompactAmountField(
                      controller: discountAmountController,
                      label: "Discount amount"),

                  const SizedBox(height: 16),

                  // Additional Charges Section
                  _buildAdditionalChargesSection(context),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        // Summary Header for the second step
        Row(
          children: const [
            SizedBox(width: 6),
            Text(
              'Summary',
              style: TextStyle(
                fontSize: 14,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w500,
                color: Color(0xFF3E3E3E),
              ),
            ),
          ],
        ),
        BookingSummarySection(
          selectedProductsNotifier: selectedProductsNotifier,
          additionalChargesNotifier: additionalChargesNotifier,
          advanceAmountController: advanceAmountController,
          discountAmountController: discountAmountController,
          onConfirmBooking: onConfirmBooking,
        ),
      ],
    );
  }

  Widget _buildCompactAmountField({
    required TextEditingController controller,
    required String label,
  }) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            controller: controller,
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.allow(
                  RegExp(r'[0-9]')), // Strict regex for digits
            ],
            onChanged: (value) {
              // Extra layer of protection
              if (value.contains(RegExp(r'[^0-9]'))) {
                final cleanText = value.replaceAll(RegExp(r'[^0-9]'), '');
                controller.value = TextEditingValue(
                  text: cleanText,
                  selection: TextSelection.collapsed(offset: cleanText.length),
                );
              }
            },
            validator: (value) {
              if (value != null && value.isNotEmpty) {
                final amount = int.tryParse(value);
                if (amount == 0) {
                  return 'Amount cannot be 0';
                }
              }
              return null;
            },
            style: const TextStyle(
              fontSize: 13,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w500,
            ),
            decoration: InputDecoration(
              hintStyle: const TextStyle(
                fontSize: 13,
                fontFamily: 'Inter',
                color: Color(0xFF8C8C8C),
              ),
              hintText: label,
              prefixText: '₹ ',
              prefixStyle: TextStyle(
                fontSize: 16,
                color: Colors.grey.shade600,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w600,
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
                borderRadius: BorderRadius.circular(8),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide:
                    const BorderSide(color: Color(0xFF6132E4), width: 1),
                borderRadius: BorderRadius.circular(8),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.red, width: 1),
                borderRadius: BorderRadius.circular(8),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.red, width: 1),
                borderRadius: BorderRadius.circular(8),
              ),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAdditionalChargesSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Additional charges',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w400,
                color: Color(0xFF8C8C8C),
              ),
            ),
            InkWell(
              onTap: () => _addAdditionalCharge(context),
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: const Color(0xFFF5F2FF),
                  borderRadius: BorderRadius.circular(4),
                ),
                child:
                    const Icon(Icons.add, size: 16, color: Color(0xFF6132E4)),
              ),
            ),
          ],
        ),
        // List of additional charges
        ValueListenableBuilder<List<AdditionalChargesModel>>(
          valueListenable: additionalChargesNotifier,
          builder: (context, charges, _) {
            if (charges.isEmpty) return const SizedBox.shrink();
            return Column(
              children: charges.map((charge) {
                return Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          charge.name ?? 'Charge',
                          style: const TextStyle(fontSize: 13),
                        ),
                      ),
                      Text(
                        '+ ₹${charge.amount ?? 0}',
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(width: 8),
                      InkWell(
                        onTap: () => _removeCharge(charge),
                        child: const Icon(Icons.close,
                            size: 14, color: Colors.red),
                      ),
                    ],
                  ),
                );
              }).toList(),
            );
          },
        ),
      ],
    );
  }

  void _addAdditionalCharge(BuildContext context) {
    final nameController = TextEditingController();
    final amountController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Charge'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Charge Name'),
            ),
            TextField(
              controller: amountController,
              decoration: const InputDecoration(labelText: 'Amount'),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (nameController.text.isNotEmpty &&
                  amountController.text.isNotEmpty) {
                final charges = List<AdditionalChargesModel>.from(
                    additionalChargesNotifier.value);
                charges.add(AdditionalChargesModel(
                  name: nameController.text,
                  amount: int.tryParse(amountController.text) ?? 0,
                ));
                additionalChargesNotifier.value = charges;
                Navigator.pop(context);
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  void _removeCharge(AdditionalChargesModel charge) {
    final charges =
        List<AdditionalChargesModel>.from(additionalChargesNotifier.value);
    charges.remove(charge);
    additionalChargesNotifier.value = charges;
  }
}
