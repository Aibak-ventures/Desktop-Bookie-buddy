// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:bookie_buddy_web/utils/app_input_validators.dart';
import 'package:bookie_buddy_web/core/constants/enums/payment_method_enums.dart';
import 'package:bookie_buddy_web/utils/extensions/color_extensions.dart';
import 'package:bookie_buddy_web/utils/extensions/context_extensions.dart';
import 'package:bookie_buddy_web/utils/extensions/number_extensions.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:bookie_buddy_web/core/ui/widgets/custom_snack_bar.dart';
import 'package:bookie_buddy_web/core/ui/widgets/custom_textfield.dart';
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
  final ValueNotifier<PaymentMethod> paymentMethodNotifier = ValueNotifier(
    PaymentMethod.gPay,
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
            Text(
              'Payment Method',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 8),
            const SizedBox(height: 8),
            ValueListenableBuilder(
              valueListenable: paymentMethodNotifier,
              builder: (context, paymentMethod, child) => RadioGroup(
                onChanged: (value) {
                  if (value != null) paymentMethodNotifier.value = value;
                },
                groupValue: paymentMethod,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: RadioListTile(
                          title: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.phone_android,
                                  size: 18, color: AppColors.purple),
                              const SizedBox(width: 4),
                              Text(
                                PaymentMethod.gPay.name,
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 8),
                          visualDensity: VisualDensity.compact,
                          controlAffinity: ListTileControlAffinity.leading,
                          value: PaymentMethod.gPay,
                          activeColor: AppColors.purple,
                        ),
                      ),
                      Container(
                          width: 1, height: 40, color: Colors.grey.shade300),
                      Expanded(
                        child: RadioListTile(
                          title: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.money,
                                  size: 18, color: Colors.green),
                              const SizedBox(width: 4),
                              Text(
                                PaymentMethod.cash.name,
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 8),
                          visualDensity: VisualDensity.compact,
                          controlAffinity: ListTileControlAffinity.leading,
                          value: PaymentMethod.cash,
                          activeColor: AppColors.purple,
                        ),
                      ),
                    ],
                  ),
                ),
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
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          child: const Text('Cancel',
              style: TextStyle(fontSize: 14, color: Colors.black87)),
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

                    // Validate input amount
                    if (amount == null || amount <= 0) {
                      CustomSnackBar(
                        title: 'Invalid Input',
                        message: 'Please enter a valid amount.',
                      );
                      return;
                    }

                    // Ensure the user cannot enter an amount greater than the balance
                    if (amount > balanceAmount) {
                      CustomSnackBar(
                        title: 'Exceeded Balance',
                        message: 'You cannot pay more than ₹$balanceAmount.',
                      );
                      return;
                    }

                    isLoading.value = true; // Start loading

                    try {
                      // Get the bloc from the correct context
                      final bloc = context.read<BookingDetailsBloc>();

                      // Dispatch the update payment event
                      bloc.add(
                        BookingDetailsEvent.updatePayment(
                          bookingId: id,
                          amount: amount,
                          paymentMethod: paymentMethodNotifier.value,
                        ),
                      );

                      // Wait for the bloc to emit the loaded or failed state with a timeout
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

                      // Check if the operation was successful
                      state.maybeWhen(
                        loaded: (_) {
                          // Close the dialog after update completes
                          if (dialogCtx.mounted) {
                            dialogCtx.pop();
                            // Show success message
                            context.showSnackBar('Payment added successfully');
                          }
                        },
                        failed: (error) {
                          CustomSnackBar(
                            title: 'Error',
                            message: error,
                          );
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
            // style: ElevatedButton.styleFrom(
            //   backgroundColor: loading ? Colors.grey : AppColors.purple,
            //   padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
            //   shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.circular(8)),
            // ),
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
                        fontWeight: FontWeight.w600),
                  ),
          ),
        ),
      ],
    ),
  );
}
