import 'dart:async';
import 'dart:developer';

import 'package:bookie_buddy_web/core/app_dependencies.dart';
import 'package:bookie_buddy_web/core/app_input_validators.dart';
import 'package:bookie_buddy_web/core/enums/enums.dart';
import 'package:bookie_buddy_web/core/extensions/color_extensions.dart';
import 'package:bookie_buddy_web/core/extensions/context_extensions.dart';
import 'package:bookie_buddy_web/core/extensions/number_extensions.dart';
import 'package:bookie_buddy_web/core/models/user_model/user_model.dart';
import 'package:bookie_buddy_web/core/repositories/auth_repository.dart';
import 'package:bookie_buddy_web/core/services/secure_action_auth_session_manager.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:bookie_buddy_web/core/ui/widgets/custom_snack_bar.dart';
import 'package:bookie_buddy_web/core/ui/widgets/custom_textfield.dart';
import 'package:bookie_buddy_web/core/view_model/user_cubit.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

bool _roleCheck(UserPasswordSettingsModel? settings, ShopRole shopRole) {
  // Return true => password required, false => action allowed without password
  if (settings == null) {
    log('No password settings found, defaulting to password required');
    return true;
  }

  final actionRole = settings.role;

  switch (actionRole) {
    case UserPasswordSettingRole.none:
      return false; // No one needs a password
    case UserPasswordSettingRole.all:
      return true; // Everyone must authenticate
    case UserPasswordSettingRole.managerAndStaff:
      return shopRole == ShopRole.manager || shopRole == ShopRole.staff;
    case UserPasswordSettingRole.staff:
      return shopRole == ShopRole.staff;
  }
}

// Main function to handle any action that requires authentication
Future<void> performSecureActionDialog(
  BuildContext context,
  SecretPasswordLocations location, {
  required VoidCallback? onSuccess,
}) async {
  final shopRole = context.read<UserCubit>().state?.shopRole ?? ShopRole.staff;
  final passwordSetting = context
      .read<UserCubit>()
      .state
      ?.passwordSettings
      .firstWhere(
        (e) => e.location == location,
        orElse: () {
          debugPrint('No password setting found for location: $location');
          return UserPasswordSettingsModel(
            location: location,
            role: UserPasswordSettingRole.all,
          );
        },
      );
  if (!_roleCheck(passwordSetting, shopRole)) {
    log(
      '🟢 User is authorized to perform this action without password, ask for: ${passwordSetting?.role.value}, Location: $location, shopRole: ${shopRole.value}',
    );
    onSuccess?.call();
    return;
  } else {
    log(
      '🔒 User is not authorized to perform this action without password, ask for: ${passwordSetting?.role.value}, Location: $location, shopRole: ${shopRole.value}',
    );
  }
  // Show password verification dialog first
  _verifyPasswordThenPerformActionDialog(
    context,
    onSuccess ??
        () {
          debugPrint(
            'Password verification successful, but no action was taken.',
          );
        },
  );
}

// Password verification dialog
void _verifyPasswordThenPerformActionDialog(
  BuildContext context,
  VoidCallback onSuccessfulPasswordVerification,
) {
  // skip the password verification if in debug mode or already authenticated for 1 min

  if (kDebugMode || SecureActionAuthSessionManager.isWithinGracePeriod) {
    onSuccessfulPasswordVerification();
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
              // Call the reAuth function with the entered password
              try {
                await getIt.get<AuthRepository>().secretLogin(password);
                SecureActionAuthSessionManager.markVerified(); // Mark as verified for to skip re auth for next 1 min
                context.pop();
                onSuccessfulPasswordVerification(); // Call the callback after successful authentication
              } catch (e) {
                context.showSnackBar(e.toString(), isError: true);
              } finally {
                // Reset loading state
                setState(() => isLoading = false);
              }
            } else {
              setState(() => isLoading = false);
              context.showSnackBar('Password cannot be empty', isError: true);
            }
          }

          return AlertDialog(
            insetPadding: const EdgeInsets.symmetric(vertical: 24.0),
            title: SizedBox(
              width: context.screenWidth < 600
                  ? context.mediaQueryWidth(0.68)
                  : context.mediaQueryWidth(0.45),
              child: Column(
                spacing: 2,
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
                  validator: (value) =>
                      AppInputValidators.onEmpty(value, 'Password'),
                  onFieldSubmit: (value) {
                    if (value != null && value.isNotEmpty) {
                      onSubmit();
                    } else {
                      CustomSnackBar(message: 'Password cannot be empty');
                    }
                  },
                ),
              ],
            ),
            actions: [
              // Cancel button
              TextButton(
                onPressed: () => context.pop(),
                child: const Text('Cancel'),
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
