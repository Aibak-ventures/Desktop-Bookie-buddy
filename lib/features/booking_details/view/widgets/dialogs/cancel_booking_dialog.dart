import 'package:bookie_buddy_web/core/enums/payment_method_enums.dart';
import 'package:bookie_buddy_web/core/extensions/number_extensions.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CancelBookingDialog extends StatefulWidget {
  final int maxRefundAmount;
  final VoidCallback onCancel;
  final Function(int refundAmount, PaymentMethod paymentMethod, String reason)
      onConfirm;

  const CancelBookingDialog({
    required this.maxRefundAmount,
    required this.onCancel,
    required this.onConfirm,
    super.key,
  });

  @override
  State<CancelBookingDialog> createState() => _CancelBookingDialogState();
}

class _CancelBookingDialogState extends State<CancelBookingDialog> {
  final _formKey = GlobalKey<FormState>();
  final _refundAmountController = TextEditingController();
  PaymentMethod _selectedPaymentMethod = PaymentMethod.cash;
  String _selectedReason = 'Customer Request';

  final List<String> _refundReasons = [
    'Customer Request',
    'Product Unavailable',
    'Quality Issues',
    'Delivery Delay',
    'Wrong Product',
    'Other',
  ];

  @override
  void initState() {
    super.initState();
    // Set default refund amount to max (full refund)
    _refundAmountController.text = widget.maxRefundAmount.toString();
  }

  @override
  void dispose() {
    _refundAmountController.dispose();
    super.dispose();
  }

  void _handleConfirm() {
    if (_formKey.currentState!.validate()) {
      final refundAmount = int.tryParse(_refundAmountController.text) ?? 0;
      widget.onConfirm(refundAmount, _selectedPaymentMethod, _selectedReason);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        width: 500,
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              // Header
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.red.shade50,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      Icons.cancel_outlined,
                      color: Colors.red.shade700,
                      size: 28,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Cancel Booking',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey.shade900,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Process refund for cancelled booking',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),

              const SizedBox(height: 24),
              const Divider(),
              const SizedBox(height: 24),

              // Refund Amount
              Text(
                'Refund Amount',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey.shade800,
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _refundAmountController,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: InputDecoration(
                  prefixText: '₹ ',
                  hintText: 'Enter refund amount',
                  suffixText: '/ ₹${widget.maxRefundAmount}',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                  fillColor: Colors.grey.shade50,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter refund amount';
                  }
                  final amount = int.tryParse(value);
                  if (amount == null || amount <= 0) {
                    return 'Please enter valid amount';
                  }
                  if (amount > widget.maxRefundAmount) {
                    return 'Amount cannot exceed ₹${widget.maxRefundAmount}';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 20),

              // Payment Method
              Text(
                'Refund Method',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey.shade800,
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: _buildPaymentMethodOption(
                      PaymentMethod.cash,
                      Icons.money,
                      'Cash',
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildPaymentMethodOption(
                      PaymentMethod.gPay,
                      Icons.account_balance_wallet,
                      'UPI',
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // Refund Reason
              Text(
                'Cancellation Reason',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey.shade800,
                ),
              ),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                value: _selectedReason,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                  fillColor: Colors.grey.shade50,
                ),
                items: _refundReasons.map((reason) {
                  return DropdownMenuItem(
                    value: reason,
                    child: Text(reason),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() => _selectedReason = value);
                  }
                },
              ),

              const SizedBox(height: 24),
              const Divider(),
              const SizedBox(height: 16),

              // Warning message
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.orange.shade50,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.orange.shade200),
                ),
                child: Row(
                  children: [
                    Icon(Icons.warning_amber, color: Colors.orange.shade700),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'This action cannot be undone. The booking will be cancelled permanently.',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.orange.shade900,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Action Buttons
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: widget.onCancel,
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text('Keep Booking'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _handleConfirm,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text('Cancel & Refund'),
                    ),
                  ),
                ],
              ),
            ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPaymentMethodOption(
    PaymentMethod method,
    IconData icon,
    String label,
  ) {
    final isSelected = _selectedPaymentMethod == method;
    return InkWell(
      onTap: () => setState(() => _selectedPaymentMethod = method),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.purple.withOpacity(0.1) : Colors.white,
          border: Border.all(
            color: isSelected ? AppColors.purple : Colors.grey.shade300,
            width: isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: isSelected ? AppColors.purple : Colors.grey.shade600,
              size: 32,
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                color: isSelected ? AppColors.purple : Colors.grey.shade700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
