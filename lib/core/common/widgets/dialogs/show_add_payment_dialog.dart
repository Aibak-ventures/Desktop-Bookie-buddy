// ignore_for_file: use_build_context_synchronously

import 'package:bookie_buddy_web/utils/app_input_validators.dart';
import 'package:bookie_buddy_web/features/accounts/domain/entities/account_entity/account_entity.dart';
import 'package:bookie_buddy_web/features/accounts/presentation/common/widgets/account_selection_field.dart';
import 'package:bookie_buddy_web/utils/extensions/color_extensions.dart';
import 'package:bookie_buddy_web/utils/extensions/context_extensions.dart';
import 'package:bookie_buddy_web/utils/extensions/number_extensions.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:bookie_buddy_web/core/common/widgets/custom_snack_bar.dart';
import 'package:bookie_buddy_web/core/common/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';

/// The kind of transaction being added through [showAddPaymentDialog].
enum PaymentTransactionType {
  payment,
  refund;

  bool get isRefund => this == PaymentTransactionType.refund;
}

/// Called when the user submits the dialog. Return `null` on success, or an
/// error message to show and keep the dialog open.
typedef PaymentDialogSubmitCallback =
    Future<String?> Function({
      required int amount,
      required AccountEntity account,
      required PaymentTransactionType transactionType,
      String? reason,
    });

/// Generic add-payment / add-refund dialog. Feature-agnostic: the caller
/// supplies [onSubmit] to actually perform the payment or refund action.
///
/// - Payment-only (default): `showTypeSelector: false`, `defaultType: PaymentTransactionType.payment`.
/// - Refund-only: `showTypeSelector: false`, `defaultType: PaymentTransactionType.refund`.
/// - Let the user pick either: `showTypeSelector: true`.
void showAddPaymentDialog({
  required BuildContext context,
  required num balanceAmount,
  bool showTypeSelector = false,
  PaymentTransactionType defaultType = PaymentTransactionType.payment,
  num? refundableAmount,
  required PaymentDialogSubmitCallback onSubmit,
}) {
  final TextEditingController textController = TextEditingController();
  final TextEditingController reasonController = TextEditingController();
  final ValueNotifier<bool> isLoading = ValueNotifier(false);
  final ValueNotifier<PaymentTransactionType> transactionTypeNotifier =
      ValueNotifier(defaultType);
  final ValueNotifier<AccountEntity?> selectedAccountNotifier = ValueNotifier(
    null,
  );

  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (dialogCtx) => ValueListenableBuilder<PaymentTransactionType>(
      valueListenable: transactionTypeNotifier,
      builder: (context, transactionType, _) {
        final isRefund = transactionType.isRefund;
        final accentColor = isRefund ? AppColors.red : AppColors.purple;
        final maxAllowedAmount = isRefund
            ? (refundableAmount ?? balanceAmount)
            : balanceAmount;

        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Column(
            spacing: 8,
            children: [
              Container(
                padding: 20.padding,
                decoration: BoxDecoration(
                  color: accentColor.lighten(0.75),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.currency_rupee, size: 48, color: accentColor),
              ),
              Text(
                isRefund ? 'Add Refund' : 'Add Payment',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
              ),
              Text(
                '${isRefund ? 'Refundable' : 'Balance'}: ${maxAllowedAmount.toCurrency()}',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          content: SizedBox(
            width: context.isMobile ? null : 450,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (showTypeSelector) ...[
                  RadioGroup<PaymentTransactionType>(
                    groupValue: transactionType,
                    onChanged: (value) =>
                        transactionTypeNotifier.value = value!,
                    child: Row(
                      children: [
                        Expanded(
                          child: RadioListTile<PaymentTransactionType>(
                            contentPadding: EdgeInsets.zero,
                            dense: true,
                            title: const Text(
                              'Payment',
                              style: TextStyle(fontSize: 13),
                            ),
                            value: PaymentTransactionType.payment,
                          ),
                        ),
                        Expanded(
                          child: RadioListTile<PaymentTransactionType>(
                            contentPadding: EdgeInsets.zero,
                            dense: true,
                            title: const Text(
                              'Refund',
                              style: TextStyle(fontSize: 13),
                            ),
                            value: PaymentTransactionType.refund,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                ],
                Text(
                  'Amount',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 8),
                CustomTextField(
                  hintText: 'Enter amount',
                  controller: textController,
                  autofocus: true,
                  validator: AppInputValidators.amount,
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 20),
                ValueListenableBuilder<AccountEntity?>(
                  valueListenable: selectedAccountNotifier,
                  builder: (context, selectedAccount, _) =>
                      AccountSelectionField(
                        selectedAccount: selectedAccount,
                        onChanged: (account) =>
                            selectedAccountNotifier.value = account,
                        label: isRefund ? 'Refund Account' : 'Payment Option',
                      ),
                ),
                if (isRefund) ...[
                  const SizedBox(height: 20),
                  Text(
                    'Reason',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 8),
                  CustomTextField(
                    hintText: 'Reason (optional)',
                    controller: reasonController,
                    validator: (_) => null,
                  ),
                ],
              ],
            ),
          ),
          actionsPadding: const EdgeInsets.fromLTRB(24, 0, 24, 20),
          actions: [
            OutlinedButton(
              onPressed: () {
                dialogCtx.pop();
              },
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 14,
                ),
                side: BorderSide(color: Colors.grey.shade400),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Cancel',
                style: TextStyle(fontSize: 14, color: Colors.black87),
              ),
            ),
            ValueListenableBuilder<bool>(
              valueListenable: isLoading,
              builder: (btnContext, loading, child) => ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: loading ? Colors.grey : accentColor,
                ),
                onPressed: loading
                    ? null
                    : () async {
                        final amount = int.tryParse(textController.text);

                        if (amount == null || amount <= 0) {
                          CustomSnackBar(
                            title: 'Invalid Input',
                            message: 'Please enter a valid amount.',
                          );
                          return;
                        }

                        if (amount > maxAllowedAmount) {
                          CustomSnackBar(
                            title: isRefund
                                ? 'Exceeded Refundable Amount'
                                : 'Exceeded Balance',
                            message: isRefund
                                ? 'You cannot refund more than ₹$maxAllowedAmount.'
                                : 'You cannot pay more than ₹$maxAllowedAmount.',
                          );
                          return;
                        }

                        if (selectedAccountNotifier.value == null) {
                          context.showSnackBar(
                            isRefund
                                ? 'Please select a refund account'
                                : 'Please select a payment account',
                            isError: true,
                          );
                          return;
                        }

                        isLoading.value = true;

                        try {
                          final error = await onSubmit(
                            amount: amount,
                            account: selectedAccountNotifier.value!,
                            transactionType: transactionType,
                            reason: reasonController.text.isEmpty
                                ? null
                                : reasonController.text,
                          );

                          if (error == null) {
                            if (dialogCtx.mounted) {
                              dialogCtx.pop();
                              context.showSnackBar(
                                isRefund
                                    ? 'Refund added successfully'
                                    : 'Payment added successfully',
                              );
                            }
                          } else {
                            CustomSnackBar(title: 'Error', message: error);
                            isLoading.value = false;
                          }
                        } catch (e) {
                          if (dialogCtx.mounted) {
                            CustomSnackBar(
                              message: isRefund
                                  ? 'Failed to add refund. Please try again.'
                                  : 'Failed to update payment. Please try again.',
                            );
                            isLoading.value = false;
                          }
                        }
                      },
                child: loading
                    ? Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            'Processing...',
                            style: TextStyle(
                              fontSize: 14,
                              color: AppColors.white,
                            ),
                          ),
                        ],
                      )
                    : Text(
                        isRefund ? 'Add Refund' : 'Add Payment',
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
              ),
            ),
          ],
        );
      },
    ),
  );
}
