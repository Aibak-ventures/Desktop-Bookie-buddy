import 'package:bookie_buddy_web/core/constants/enums/booking_status_enums.dart';
import 'package:bookie_buddy_web/core/constants/enums/payment_method_enums.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:bookie_buddy_web/core/ui/dialogs/add_additional_charge_dialog.dart';
import 'package:bookie_buddy_web/features/add_booking/models/additional_charges_model/additional_charges_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BookingPaymentDetailsSection extends StatelessWidget {
  final TextEditingController advanceAmountController;
  final TextEditingController securityAmountController;
  final TextEditingController discountAmountController;
  final ValueNotifier<List<AdditionalChargesModel>> additionalChargesNotifier;
  final DeliveryStatus deliveryStatus;
  final ValueChanged<DeliveryStatus> onDeliveryStatusChanged;
  final PaymentMethod paymentMethod;
  final ValueChanged<PaymentMethod> onPaymentMethodChanged;
  final bool isSalesMode;

  const BookingPaymentDetailsSection({
    super.key,
    required this.advanceAmountController,
    required this.securityAmountController,
    required this.discountAmountController,
    required this.additionalChargesNotifier,
    required this.deliveryStatus,
    required this.onDeliveryStatusChanged,
    required this.paymentMethod,
    required this.onPaymentMethodChanged,
    this.isSalesMode = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
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
          // Only show additional fields if not in sales mode
          if (!isSalesMode) ...[
            // 1. Advance amount
            _buildAmountField(
              controller: advanceAmountController,
              hint: 'Advance amount (optional)',
            ),
            const SizedBox(height: 10),
            // 2. Security amount
            _buildAmountField(
              controller: securityAmountController,
              hint: 'Security amount (optional)',
            ),
            const SizedBox(height: 10),
            // 3. Discount amount
            _buildAmountField(
              controller: discountAmountController,
              hint: 'Discount amount (optional)',
            ),
            const SizedBox(height: 14),
            // 4. Additional charges
            _buildAdditionalChargesSection(context),
            const SizedBox(height: 14),
            // 5. Payment method
            _buildPaymentMethodSection(),
            const SizedBox(height: 14),
            // 6. Delivery status
            _buildDeliveryStatusSection(),
          ],
          // Sales mode - simplified
          if (isSalesMode) ...[
            _buildAmountField(
              controller: advanceAmountController,
              hint: 'Amount received',
            ),
            const SizedBox(height: 10),
            _buildAmountField(
              controller: discountAmountController,
              hint: 'Discount (optional)',
            ),
            const SizedBox(height: 14),
            _buildPaymentMethodSection(),
          ],
        ],
      ),
    );
  }

  Widget _buildPaymentMethodSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Payment method',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: _buildPaymentMethodOption(
                label: 'UPI',
                value: PaymentMethod.gPay,
                icon: Icons.account_balance_wallet_outlined,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildPaymentMethodOption(
                label: 'Cash',
                value: PaymentMethod.cash,
                icon: Icons.money_outlined,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPaymentMethodOption({
    required String label,
    required PaymentMethod value,
    required IconData icon,
  }) {
    final isSelected = paymentMethod == value;
    return InkWell(
      onTap: () => onPaymentMethodChanged(value),
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.purple.withOpacity(0.1)
              : Colors.grey.shade50,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isSelected ? AppColors.purple : Colors.grey.shade200,
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 18,
              color: isSelected ? AppColors.purple : Colors.grey.shade600,
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                color: isSelected ? AppColors.purple : Colors.grey.shade700,
              ),
            ),
            const Spacer(),
            if (isSelected)
              Icon(
                Icons.check_circle,
                size: 18,
                color: AppColors.purple,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildAmountField({
    required TextEditingController controller,
    required String hint,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        inputFormatters: [
          FilteringTextInputFormatter.allow(
              RegExp(r'[0-9]')), // Strict regex for digits
        ],
        onChanged: (value) {
          // Extra layer of protection: remove any non-digit characters if they somehow slip through
          if (value.contains(RegExp(r'[^0-9]'))) {
            final cleanText = value.replaceAll(RegExp(r'[^0-9]'), '');
            controller.value = TextEditingValue(
              text: cleanText,
              selection: TextSelection.collapsed(offset: cleanText.length),
            );
          }
        },
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(
            color: Colors.grey.shade500,
            fontSize: 14,
          ),
          prefixIcon: Padding(
            padding: const EdgeInsets.only(left: 12, right: 8),
            child: Text(
              '₹',
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 16,
              ),
            ),
          ),
          prefixIconConstraints:
              const BoxConstraints(minWidth: 0, minHeight: 0),
          border: InputBorder.none,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        ),
      ),
    );
  }

  Widget _buildAdditionalChargesSection(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Additional charges',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
            InkWell(
              onTap: () {
                showAddAdditionalChargeDialog(
                  context: context,
                  additionalChargesNotifier: additionalChargesNotifier,
                );
              },
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: AppColors.purple.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Icon(
                  Icons.add,
                  color: AppColors.purple,
                  size: 18,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ValueListenableBuilder<List<AdditionalChargesModel>>(
          valueListenable: additionalChargesNotifier,
          builder: (context, charges, _) {
            if (charges.isEmpty) {
              return Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: Center(
                  child: Text(
                    'No additional charges',
                    style: TextStyle(
                      color: Colors.grey.shade500,
                      fontSize: 13,
                    ),
                  ),
                ),
              );
            }
            return Column(
              children:
                  charges.map((charge) => _buildChargeItem(charge)).toList(),
            );
          },
        ),
      ],
    );
  }

  Widget _buildChargeItem(AdditionalChargesModel charge) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            charge.name ?? 'Charge',
            style: const TextStyle(fontSize: 13),
          ),
          Row(
            children: [
              Text(
                '₹${charge.amount ?? 0}',
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(width: 8),
              InkWell(
                onTap: () {
                  final charges = List<AdditionalChargesModel>.from(
                    additionalChargesNotifier.value,
                  );
                  charges.remove(charge);
                  additionalChargesNotifier.value = charges;
                },
                child: Icon(
                  Icons.close,
                  size: 16,
                  color: Colors.grey.shade500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDeliveryStatusSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Delivery status',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<DeliveryStatus>(
              value: deliveryStatus,
              isExpanded: true,
              icon:
                  Icon(Icons.keyboard_arrow_down, color: Colors.grey.shade600),
              items: DeliveryStatus.values
                  .map(
                    (status) => DropdownMenuItem(
                      value: status,
                      child: Text(
                        status.name,
                        style: const TextStyle(fontSize: 14),
                      ),
                    ),
                  )
                  .toList(),
              onChanged: (value) {
                if (value != null) {
                  onDeliveryStatusChanged(value);
                }
              },
            ),
          ),
        ),
      ],
    );
  }
}
