// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:bookie_buddy_web/utils/app_input_validators.dart';
import 'package:bookie_buddy_web/features/accounts/domain/entities/account_entity/account_entity.dart';
import 'package:bookie_buddy_web/features/accounts/presentation/common/widgets/account_selection_field.dart';
import 'package:bookie_buddy_web/utils/extensions/color_extensions.dart';
import 'package:bookie_buddy_web/utils/extensions/context_extensions.dart';
import 'package:bookie_buddy_web/utils/extensions/number_extensions.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:bookie_buddy_web/core/common/widgets/custom_snack_bar.dart';
import 'package:bookie_buddy_web/core/common/widgets/custom_textfield.dart';
import 'package:bookie_buddy_web/features/booking/presentation/booking_details/bloc/booking_details_bloc/booking_details_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void showBookingDetailsAddPaymentDialog({
  required BuildContext context,
  required int id,
  required num balanceAmount,
}) {
  final TextEditingController textController = TextEditingController();
  final ValueNotifier<bool> isLoading = ValueNotifier(false);
  final ValueNotifier<AccountEntity?> selectedAccountNotifier = ValueNotifier(
    null,
  );
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (dialogCtx) => AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: Column(
        spacing: 8,
        children: [
          Container(
            padding: 20.padding,
            decoration: BoxDecoration(
              color: AppColors.purple.lighten(0.75),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.currency_rupee,
              size: 48,
              color: AppColors.purple,
            ),
          ),
          Text(
            'Add Payment',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
          ),
          Text(
            'Balance: ${balanceAmount.toCurrency()}',
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
              builder: (context, selectedAccount, _) => AccountSelectionField(
                selectedAccount: selectedAccount,
                onChanged: (account) => selectedAccountNotifier.value = account,
                label: 'Payment Option',
              ),
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
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
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
              backgroundColor: loading ? Colors.grey : null,
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
                        title: 'Exceeded Balance',
                        message: 'You cannot pay more than ₹$balanceAmount.',
                      );
                      return;
                    }

                    if (selectedAccountNotifier.value == null) {
                      context.showSnackBar(
                        'Please select a payment account',
                        isError: true,
                      );
                      return;
                    }

                    isLoading.value = true;

                    try {
                      final bloc = context.read<BookingDetailsBloc>();

                      bloc.add(
                        BookingDetailsEvent.updatePayment(
                          bookingId: id,
                          amount: amount,
                          accountId: selectedAccountNotifier.value!.id,
                        ),
                      );

                      final state = await bloc.stream
                          .firstWhere(
                            (state) => state.maybeWhen(
                              loaded: (_) => true,
                              failed: (_) => true,
                              orElse: () => false,
                            ),
                          )
                          .timeout(
                            const Duration(seconds: 30),
                            onTimeout: () {
                              throw TimeoutException('Request timed out');
                            },
                          );

                      state.maybeWhen(
                        loaded: (_) {
                          if (dialogCtx.mounted) {
                            dialogCtx.pop();
                            context.showSnackBar('Payment added successfully');
                          }
                        },
                        failed: (error) {
                          CustomSnackBar(title: 'Error', message: error);
                          isLoading.value = false;
                        },
                        orElse: () {},
                      );
                    } catch (e) {
                      if (dialogCtx.mounted) {
                        CustomSnackBar(
                          message:
                              'Failed to update payment. Please try again.',
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
                        style: TextStyle(fontSize: 14, color: AppColors.white),
                      ),
                    ],
                  )
                : const Text(
                    'Add Payment',
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
          ),
        ),
      ],
    ),
  );
}
