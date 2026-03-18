import 'dart:async';
import 'dart:developer';

import 'package:bookie_buddy_web/core/di/app_dependencies.dart';
import 'package:bookie_buddy_web/features/auth/domain/repositories/i_auth_repository.dart';
import 'package:bookie_buddy_web/utils/app_input_validators.dart';
// import 'package:bookie_buddy_web/core/constants/enums/enums.dart' show SecretPasswordLocations;
import 'package:bookie_buddy_web/core/constants/enums/shop_based_enums.dart'
    hide UserPasswordSettingRole;
import 'package:bookie_buddy_web/core/constants/enums/enums.dart' hide ShopRole;
// show SecretPasswordLocations;

// import 'package:bookie_buddy_web/core/constants/enums/shop_based_enums.dart';
import 'package:bookie_buddy_web/utils/extensions/color_extensions.dart';
import 'package:bookie_buddy_web/utils/extensions/context_extensions.dart';
import 'package:bookie_buddy_web/core/models/user_model/user_model.dart';
import 'package:bookie_buddy_web/core/services/secure_action_auth_session_manager.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:bookie_buddy_web/core/common/widgets/custom_snack_bar.dart';
import 'package:bookie_buddy_web/core/common/widgets/custom_textfield.dart';
import 'package:bookie_buddy_web/core/view_model/user_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

bool _roleCheck(UserPasswordSettingsModel? settings, ShopRole shopRole) {
  if (settings == null) return true;

  switch (settings.role) {
    case UserPasswordSettingRole.none:
      return false;

    case UserPasswordSettingRole.all:
      return true;

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
  final passwordSetting =
      context.read<UserCubit>().state?.passwordSettings.firstWhere(
    (e) => e.location == location,
    orElse: () {
      debugPrint('No password setting found for location: $location');
      return UserPasswordSettingsModel(
        location: location,
        role: UserPasswordSettingRole.none,
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
  // skip the password verification if already authenticated within grace period
  // NOTE: Debug mode bypass is DISABLED - password now required in development too

  // if (kDebugMode || SecureActionAuthSessionManager.isWithinGracePeriod) {
  if (SecureActionAuthSessionManager.isWithinGracePeriod) {
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
                await getIt.get<IAuthRepository>().secretLogin(password);
                SecureActionAuthSessionManager
                    .markVerified(); // Mark as verified for to skip re auth for next 1 min
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

          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: context.screenWidth < 600 ? 400 : 450,
                minWidth: 350,
              ),
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Icon
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: AppColors.purple.lighten(0.75),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.lock_outline,
                        size: 48,
                        color: AppColors.purple,
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Title
                    Text(
                      'Secret Password',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),

                    // Subtitle
                    Text(
                      'Enter your password to continue',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 32),

                    // Password Field
                    CustomTextField(
                      hintText: 'Enter Password',
                      controller: textController,
                      autofocus: true,
                      suffixIcon: IconButton(
                        icon: Icon(
                          obscurePassword
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
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
                    const SizedBox(height: 32),

                    // Action Buttons
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: isLoading ? null : () => context.pop(),
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              side: BorderSide(color: Colors.grey[300]!),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Text(
                              'Cancel',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey[700],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: isLoading ? null : onSubmit,
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              backgroundColor: AppColors.purple,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              elevation: 0,
                            ),
                            child: isLoading
                                ? SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        AppColors.white,
                                      ),
                                    ),
                                  )
                                : Text(
                                    'Confirm',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: AppColors.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    },
  );
}
