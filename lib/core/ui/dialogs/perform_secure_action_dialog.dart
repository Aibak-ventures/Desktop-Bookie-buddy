import 'package:bookie_buddy_web/core/app_input_validators.dart';
import 'package:bookie_buddy_web/core/extensions/color_extensions.dart';
import 'package:bookie_buddy_web/core/extensions/context_extensions.dart';
import 'package:bookie_buddy_web/core/extensions/number_extensions.dart';
import 'package:bookie_buddy_web/core/models/booking_details_model/booking_details_model.dart';
import 'package:bookie_buddy_web/core/services/auth_service.dart';
import 'package:bookie_buddy_web/core/services/secure_action_auth_session_manager.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:bookie_buddy_web/core/ui/widgets/custom_snack_bar.dart';
import 'package:bookie_buddy_web/core/ui/widgets/custom_textfield.dart';
import 'package:bookie_buddy_web/core/view_model/bloc_client/client_bloc.dart';
import 'package:bookie_buddy_web/features/booking_details/view/edit_booking_screen/edit_booking_screen.dart';
import 'package:bookie_buddy_web/features/booking_details/view/widgets/show_delete_booking_dialog.dart';
import 'package:bookie_buddy_web/features/booking_details/view_model/cubit_update_booking/update_booking_cubit.dart';
import 'package:bookie_buddy_web/features/wallet/view/ledger_screen.dart';
import 'package:bookie_buddy_web/features/wallet/view_model/bloc_ledger_security_amounts/ledger_security_amounts_bloc.dart';
import 'package:bookie_buddy_web/features/wallet/view_model/bloc_wallet_expense/wallet_expense_bloc.dart';
import 'package:bookie_buddy_web/features/wallet/view_model/bloc_wallet_payments/wallet_payments_bloc.dart';
import 'package:bookie_buddy_web/features/wallet/view_model/bloc_wallet_pending/wallet_pending_bloc.dart';
import 'package:bookie_buddy_web/features/wallet/view_model/ledger_simple_summary_cubit.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Main function to handle any action that requires authentication
void performSecureActionDialog(
  BuildContext context,
  String actionType, {
  int? bookingId,
  BookingDetailsModel? booking,
  num? balance,
  VoidCallback? onSuccess,
}) {
  // Show password verification dialog first
  _verifyPasswordThenPerformActionDialog(context, () async {
    // This callback runs after successful password verification
    switch (actionType) {
      case 'edit':
        // Handle edit action
        if (booking != null) {
          context.push(BlocProvider(
            create: (context) => UpdateBookingCubit(),
            child: EditBookingScreen(booking: booking),
          ));
        }
        break;
      case 'delete':
        // Handle delete action
        if (bookingId != null) {
          await showDeleteBookingDialog(context, bookingId);
        }
        break;
      case 'wallet':
        // Handle move to wallet action
        context.push(
          MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => WalletExpenseBloc()),
              BlocProvider(
                create: (context) => WalletPaymentsBloc(),
              ),
              BlocProvider(
                  create: (context) =>
                      ClientBloc()..add(const ClientEvent.clearSelected())),
              BlocProvider(create: (context) => LedgerSimpleSummaryCubit()),
              BlocProvider(create: (context) => WalletPendingBloc()),
              BlocProvider(create: (context) => LedgerSecurityAmountsBloc()),
            ],
            child: const WalletScreen(),
          ),
        );
        break;
    }

    onSuccess?.call();
  });
}

// Password verification dialog
void _verifyPasswordThenPerformActionDialog(
  BuildContext context,
  Function onSuccess,
) {
  //? skip the password verification if in debug mode or already authenticated for 1 min
  if (kDebugMode || SecureActionAuthSessionManager.isWithinGracePeriod) {
    onSuccess();
    return;
  }

  final TextEditingController textController = TextEditingController();
  bool isLoading = false;

  showDialog(
    context: context,
    builder: (BuildContext context) {
      bool obscurePassword = true;
      return StatefulBuilder(
        builder: (context, setState) {
          void onSubmit() async {
            context.clearSnackBars();
            if (isLoading) return;

            final password = textController.text;
            setState(() => isLoading = true);
            if (password.isNotEmpty) {
              final response = await AuthService.secretLogin(
                password,
              ); // Call the reAuth function with the entered password
              setState(() => isLoading = false);

              if (response['success']) {
                SecureActionAuthSessionManager
                    .markVerified(); // Mark as verified for to skip re auth for next 1 min
                context.pop();
                onSuccess(); // Call the callback after successful authentication
              } else {
                context.showSnackBar(
                  'Incorrect Password, try again',
                  isError: true,
                );
              }
            } else {
              setState(() => isLoading = false);
              CustomSnackBar(message: 'Password cannot be empty');
            }
            ;
          }

          ;
          return AlertDialog(
            insetPadding:
                const EdgeInsets.symmetric(horizontal: 0, vertical: 24.0),
            title: SizedBox(
              width: context.screenWidth < 600
                  ? context.mediaQueryWidth(0.68)
                  : context.mediaQueryWidth(0.45),
              child: Column(
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
                      Icons.lock,
                      size: 40,
                      color: AppColors.purple,
                    ),
                  ),
                  Text(
                    'Secret Password',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomTextField(
                  hintText: 'Enter Password',
                  controller: textController,
                  autofocus: true,
                  suffixIcon: IconButton(
                    icon: Icon(
                      obscurePassword ? Icons.visibility_off : Icons.visibility,
                      color: AppColors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        obscurePassword = !obscurePassword;
                      });
                    },
                  ),
                  obscureText: obscurePassword,
                  validator: (value) => AppInputValidators.onEmpty(
                    value,
                    'Password',
                  ),
                  submitFun: (value) {
                    if (value != null && value.isNotEmpty) {
                      onSubmit();
                    } else {
                      CustomSnackBar(message: 'Password cannot be empty');
                    }
                    return null;
                  },
                ),
              ],
            ),
            actions: [
              // Cancel button
              TextButton(
                onPressed: () => context.pop(),
                child: const Text(
                  'Cancel',
                ),
              ),

              // Confirm button
              ElevatedButton(
                onPressed: onSubmit,
                child: Text(
                  isLoading ? 'Loading' : 'Confirm',
                  style: const TextStyle(
                    color: AppColors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          );
        },
      );
    },
  );
}
