import 'package:bookie_buddy_web/core/constants/enums/payment_method_enums.dart';
import 'package:bookie_buddy_web/utils/extensions/context_extensions.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CancelBookingDialog extends StatefulWidget {
  final int maxRefundAmount;
  final VoidCallback onCancel;
  final Function(int refundAmount, PaymentMethod? paymentMethod) onConfirm;

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
  PaymentMethod? _selectedPaymentMethod;
  bool _noRefund = false;

  @override
  void initState() {
    super.initState();
    if (widget.maxRefundAmount > 0) {
      _refundAmountController.text = widget.maxRefundAmount.toString();
    } else {
      _refundAmountController.text = '0';
      _noRefund = true;
    }
  }

  @override
  void dispose() {
    _refundAmountController.dispose();
    super.dispose();
  }

  void _handleConfirm() {
    if (_formKey.currentState!.validate()) {
      if (!_noRefund && _selectedPaymentMethod == null) {
        // Use context extension for snackbar
        context.showSnackBar('Please select refund method', isError: true);
        return;
      }

      final refundAmount =
          _noRefund ? 0 : (int.tryParse(_refundAmountController.text) ?? 0);

      // Call the callback - the calling code will handle dialog closure
      widget.onConfirm(refundAmount, _selectedPaymentMethod);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        width: 450,
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
                        shape: BoxShape.circle,
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
                            widget.maxRefundAmount > 0
                                ? 'Process refund for this booking'
                                : 'Cancel booking',
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

                // Show refund section only if there's paid amount
                if (widget.maxRefundAmount > 0) ...[
                  // Rupee icon with refund amount
                  Row(
                    children: [
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: AppColors.purple.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.currency_rupee,
                          color: AppColors.purple,
                          size: 28,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: TextFormField(
                          controller: _refundAmountController,
                          enabled: !_noRefund,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                          decoration: InputDecoration(
                            prefixText: '₹ ',
                            labelText: 'Refund Amount',
                            suffixText: '/ ₹${widget.maxRefundAmount}',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 16,
                            ),
                          ),
                          validator: (value) {
                            if (_noRefund) return null;
                            if (value == null || value.isEmpty) {
                              return 'Enter refund amount';
                            }
                            final amount = int.tryParse(value);
                            if (amount == null || amount < 0) {
                              return 'Invalid amount';
                            }
                            if (amount > widget.maxRefundAmount) {
                              return 'Exceeds paid amount';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // Payment Method - Radio buttons
                  if (!_noRefund) ...[
                    Text(
                      'Refund Method',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey.shade700,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: _buildRadioButton(
                            method: PaymentMethod.gPay,
                            label: 'UPI',
                            icon: Icons.account_balance_wallet,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _buildRadioButton(
                            method: PaymentMethod.cash,
                            label: 'Cash',
                            icon: Icons.money,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                  ],

                  // No refund checkbox
                  InkWell(
                    onTap: () {
                      setState(() {
                        _noRefund = !_noRefund;
                        if (_noRefund) {
                          _selectedPaymentMethod = null;
                          _refundAmountController.text = '0';
                        } else {
                          _refundAmountController.text =
                              widget.maxRefundAmount.toString();
                        }
                      });
                    },
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: _noRefund
                              ? AppColors.purple
                              : Colors.grey.shade300,
                          width: _noRefund ? 2 : 1,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Checkbox(
                            value: _noRefund,
                            onChanged: (value) {
                              setState(() {
                                _noRefund = value ?? false;
                                if (_noRefund) {
                                  _selectedPaymentMethod = null;
                                  _refundAmountController.text = '0';
                                } else {
                                  _refundAmountController.text =
                                      widget.maxRefundAmount.toString();
                                }
                              });
                            },
                            activeColor: AppColors.purple,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'No refund',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: _noRefund
                                  ? FontWeight.w600
                                  : FontWeight.normal,
                              color: _noRefund
                                  ? AppColors.purple
                                  : Colors.grey.shade700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),
                ],

                const SizedBox(height: 12),

                // Action Buttons
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: widget.onCancel,
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text('Cancel'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: _handleConfirm,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          'Update',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRadioButton({
    required PaymentMethod method,
    required String label,
    required IconData icon,
  }) {
    final isSelected = _selectedPaymentMethod == method;
    return InkWell(
      onTap: _noRefund
          ? null
          : () => setState(() => _selectedPaymentMethod = method),
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.purple.withOpacity(0.1)
              : Colors.grey.shade50,
          border: Border.all(
            color: isSelected ? AppColors.purple : Colors.grey.shade300,
            width: isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: isSelected ? AppColors.purple : Colors.grey.shade600,
              size: 20,
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                color: isSelected ? AppColors.purple : Colors.grey.shade700,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
