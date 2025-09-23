// ignore_for_file: use_build_context_synchronously

import 'package:bookie_buddy_web/core/app_input_validators.dart';
import 'package:bookie_buddy_web/core/enums/enums.dart';
import 'package:bookie_buddy_web/core/extensions/color_extensions.dart';
import 'package:bookie_buddy_web/core/extensions/context_extensions.dart';
import 'package:bookie_buddy_web/core/extensions/number_extensions.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:bookie_buddy_web/core/ui/widgets/custom_snack_bar.dart';
import 'package:bookie_buddy_web/core/ui/widgets/custom_textfield.dart';
import 'package:bookie_buddy_web/features/booking_details/view_model/bloc_booking_details/booking_details_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void showCustomAlertDialog({
  required BuildContext context,
  required int id,
  required num balanceAmount,
}) {
  final TextEditingController textController = TextEditingController();
  final ValueNotifier<bool> isLoading = ValueNotifier(false);
  final ValueNotifier<PaymentMethod> paymentMethodNotifier =
      ValueNotifier(PaymentMethod.gPay);
  showDialog(
    context: context,
    builder: (dialogCtx) {
      return AlertDialog(
        title: Column(
          spacing: 2,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: 18.padding,
              decoration: BoxDecoration(
                color: AppColors.purple.lighten(0.75),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.currency_rupee,
                size: 40,
                color: AppColors.purple,
              ),
            ),
            Text(
              'Add amount',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        contentPadding: 16.padding,
        content: SizedBox(
          width: context.isMobile ? null : 0.5.widthR,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomTextField(
                hintText: 'Enter amount',
                controller: textController,
                // fillColor: AppColors.purple.lighten(0.75),
                autofocus: true,
                validator: AppInputValidators.amount, // For password security
              ),
              ValueListenableBuilder(
                valueListenable: paymentMethodNotifier,
                builder: (context, paymentMethod, child) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Radio(
                            value: PaymentMethod.gPay,
                            groupValue: paymentMethod,
                            onChanged: (value) {
                              paymentMethodNotifier.value =
                                  value as PaymentMethod;
                            },
                          ),
                          Text(
                            'UPI',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Radio(
                            value: PaymentMethod.cash,
                            groupValue: paymentMethod,
                            onChanged: (value) {
                              paymentMethodNotifier.value =
                                  value as PaymentMethod;
                            },
                          ),
                          Text(
                            'Cash',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              )
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              dialogCtx.pop();
            },
            child: const Text(
              'Cancel',
            ),
          ),
          ValueListenableBuilder<bool>(
            valueListenable: isLoading,
            builder: (context, loading, child) {
              return ElevatedButton(
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
                            title: "Invalid Input",
                            message: "Please enter a valid amount.",
                          );
                          return;
                        }

                        // Ensure the user cannot enter an amount greater than the balance
                        if (amount > balanceAmount) {
                          CustomSnackBar(
                            title: "Exceeded Balance",
                            message:
                                "You cannot pay more than ₹$balanceAmount.",
                          );
                          return;
                        }

                        isLoading.value = true; // Start loading

                        try {
                          context.read<BookingDetailsBloc>().add(
                                BookingDetailsEvent.updatePayment(
                                  bookingId: id,
                                  amount: amount,
                                  paymentMethod: paymentMethodNotifier.value,
                                ),
                              );
                          // Close the dialog after update
                          context.pop();
                        } catch (e) {
                          CustomSnackBar(
                            message:
                                "Failed to update booking. Please try again.",
                          );
                        } finally {
                          isLoading.value = false; // End loading
                        }
                      },
                child: Text(
                  loading ? 'Loading..' : 'Update',
                  style: const TextStyle(
                    color: AppColors.white,
                  ),
                ),
              );
            },
          ),
        ],
      );
    },
  );
}
