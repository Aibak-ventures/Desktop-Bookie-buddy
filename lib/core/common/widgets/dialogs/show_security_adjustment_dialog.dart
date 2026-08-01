import 'package:bookie_buddy_web/utils/app_input_validators.dart';
import 'package:bookie_buddy_web/core/constants/enums/security_payment_enums.dart';
import 'package:bookie_buddy_web/features/accounts/domain/entities/account_entity/account_entity.dart';
import 'package:bookie_buddy_web/features/accounts/presentation/common/widgets/account_selection_field.dart';
import 'package:bookie_buddy_web/utils/extensions/color_extensions.dart';
import 'package:bookie_buddy_web/utils/extensions/context_extensions.dart';
import 'package:bookie_buddy_web/utils/extensions/number_extensions.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:bookie_buddy_web/core/common/widgets/custom_snack_bar.dart';
import 'package:bookie_buddy_web/core/common/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';

/// Called when the user submits the security adjustment dialog. Return
/// `null` on success, or an error message to show and keep the dialog open.
typedef SecurityAdjustmentSubmitCallback =
    Future<String?> Function({
      required int amount,
      required SecurityTransactionAction action,
      AccountEntity? account,
      String? note,
    });

/// Dialog for refunding or deducting a booking's security deposit.
///
/// Unlike a normal payment refund, a deduction reuses the security deposit's
/// original payment account for consistency, so the account picker is hidden
/// once "Deduction" is selected.
void showSecurityAdjustmentDialog({
  required BuildContext context,
  required num balanceAmount,
  required SecurityAdjustmentSubmitCallback onSubmit,
}) {
  final TextEditingController textController = TextEditingController();
  final TextEditingController noteController = TextEditingController();
  final ValueNotifier<bool> isLoading = ValueNotifier(false);
  final ValueNotifier<SecurityTransactionAction> actionNotifier = ValueNotifier(
    SecurityTransactionAction.refund,
  );
  final ValueNotifier<AccountEntity?> selectedAccountNotifier = ValueNotifier(
    null,
  );

  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (dialogCtx) => ValueListenableBuilder<SecurityTransactionAction>(
      valueListenable: actionNotifier,
      builder: (context, action, _) {
        final isDeduction = action.isDeduction;
        final accentColor = isDeduction ? AppColors.red : AppColors.purple;

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
              const Text(
                'Security Refund',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
              ),
              Text(
                'Pending: ${balanceAmount.toCurrency()}',
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
                RadioGroup<SecurityTransactionAction>(
                  groupValue: action,
                  onChanged: (value) => actionNotifier.value = value!,
                  child: Row(
                    children: [
                      Expanded(
                        child: RadioListTile<SecurityTransactionAction>(
                          contentPadding: EdgeInsets.zero,
                          dense: true,
                          title: Text(
                            SecurityTransactionAction.refund.label,
                            style: const TextStyle(fontSize: 13),
                          ),
                          value: SecurityTransactionAction.refund,
                        ),
                      ),
                      Expanded(
                        child: RadioListTile<SecurityTransactionAction>(
                          contentPadding: EdgeInsets.zero,
                          dense: true,
                          title: Text(
                            SecurityTransactionAction.deduction.label,
                            style: const TextStyle(fontSize: 13),
                          ),
                          value: SecurityTransactionAction.deduction,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
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
                if (!isDeduction) ...[
                  const SizedBox(height: 20),
                  ValueListenableBuilder<AccountEntity?>(
                    valueListenable: selectedAccountNotifier,
                    builder: (context, selectedAccount, _) =>
                        AccountSelectionField(
                          selectedAccount: selectedAccount,
                          onChanged: (account) =>
                              selectedAccountNotifier.value = account,
                          label: 'Refund Account',
                        ),
                  ),
                ],
                const SizedBox(height: 20),
                Text(
                  'Note',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 8),
                CustomTextField(
                  hintText: 'Note (optional)',
                  controller: noteController,
                  validator: (_) => null,
                ),
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

                        if (amount > balanceAmount) {
                          CustomSnackBar(
                            title: 'Exceeded Pending Amount',
                            message:
                                'You cannot ${isDeduction ? 'deduct' : 'refund'} more than ₹$balanceAmount.',
                          );
                          return;
                        }

                        if (!isDeduction &&
                            selectedAccountNotifier.value == null) {
                          context.showSnackBar(
                            'Please select a refund account',
                            isError: true,
                          );
                          return;
                        }

                        isLoading.value = true;

                        try {
                          final error = await onSubmit(
                            amount: amount,
                            action: action,
                            account: selectedAccountNotifier.value,
                            note: noteController.text.isEmpty
                                ? null
                                : noteController.text,
                          );

                          if (error == null) {
                            if (dialogCtx.mounted) {
                              dialogCtx.pop();
                              context.showSnackBar(
                                isDeduction
                                    ? 'Deduction added successfully'
                                    : 'Refund added successfully',
                              );
                            }
                          } else {
                            CustomSnackBar(title: 'Error', message: error);
                            isLoading.value = false;
                          }
                        } catch (e) {
                          if (dialogCtx.mounted) {
                            CustomSnackBar(
                              message: 'Failed to submit. Please try again.',
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
                        isDeduction ? 'Add Deduction' : 'Add Refund',
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
