import 'package:bookie_buddy_web/core/constants/enums/payment_method_enums.dart';
import 'package:flutter/material.dart';

/// Displays the two payment method options ( / cash) with selection state.
/// Extracted from NewBookingScreen to keep the screen file lean.
class BookingPaymentMethodSection extends StatelessWidget {
  const BookingPaymentMethodSection({
    super.key,
    required this.selectedPaymentMethod,
    required this.onChanged,
  });

  final PaymentMethod selectedPaymentMethod;
  final ValueChanged<PaymentMethod> onChanged;

  @override
  Widget build(BuildContext context) {
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
            _option(PaymentMethod.upi, Icons.qr_code),
            const SizedBox(width: 8),
            _option(PaymentMethod.cash, Icons.money),
          ],
        ),
      ],
    );
  }

  Widget _option(PaymentMethod method, IconData icon) {
    final isSelected = selectedPaymentMethod == method;
    return Expanded(
      child: InkWell(
        onTap: () => onChanged(method),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            border: Border.all(
              color: isSelected ? const Color(0xFF6132E4) : Colors.grey.shade300,
            ),
            borderRadius: BorderRadius.circular(8),
            color: isSelected
                ? const Color(0xFF6132E4).withValues(alpha: 0.05)
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
