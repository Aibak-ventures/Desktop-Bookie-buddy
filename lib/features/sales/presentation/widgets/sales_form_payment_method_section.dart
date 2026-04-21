import 'package:bookie_buddy_web/core/constants/enums/payment_method_enums.dart';
import 'package:flutter/material.dart';

/// Payment method toggle ( Cash) for [EditSalesScreen].
class SalesFormPaymentMethodSection extends StatelessWidget {
  final ValueNotifier<PaymentMethod> paymentMethodNotifier;

  const SalesFormPaymentMethodSection({
    super.key,
    required this.paymentMethodNotifier,
  });

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
        ValueListenableBuilder(
          valueListenable: paymentMethodNotifier,
          builder: (context, selected, _) => Row(
            children: [
              _buildOption(PaymentMethod.upi, Icons.qr_code, selected),
              const SizedBox(width: 8),
              _buildOption(PaymentMethod.cash, Icons.money, selected),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildOption(
    PaymentMethod method,
    IconData icon,
    PaymentMethod selected,
  ) {
    final isSelected = selected == method;
    return Expanded(
      child: InkWell(
        onTap: () => paymentMethodNotifier.value = method,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            border: Border.all(
              color: isSelected ? const Color(0xFF6132E4) : Colors.grey.shade300,
              width: isSelected ? 1.5 : 1,
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
