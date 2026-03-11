import 'package:bookie_buddy_web/utils/app_input_validators.dart';
import 'package:bookie_buddy_web/utils/extensions/context_extensions.dart';
import 'package:bookie_buddy_web/utils/extensions/number_extensions.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:bookie_buddy_web/core/ui/widgets/custom_button.dart';
import 'package:bookie_buddy_web/core/ui/widgets/custom_sized_box.dart';
import 'package:bookie_buddy_web/core/ui/widgets/custom_textfield.dart';
import 'package:bookie_buddy_web/features/auth/presentation/bloc/reset_password_bloc/reset_password_bloc.dart';
import 'package:bookie_buddy_web/core/app/bottom_bar_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _oldPasswordController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _obscureOldPassword = true;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _logoutFromAllDevices = false;
  @override
  void dispose() {
    _oldPasswordController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Account Password'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: context.isMobile ? 20.padding : (40, 20).padding,
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomSizedBoxHeight(0.02),
                Center(
                  child: Image.asset(
                    'assets/images/reset.png',
                    height: 180.w,
                    width: 180.w,
                  ),
                ),
                const CustomSizedBoxHeight(0.04),
                Center(
                  child: Text(
                    'Create New Password',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: AppColors.purple,
                      fontSize: 22.sp,
                    ),
                  ),
                ),
                const CustomSizedBoxHeight(0.02),
                Text(
                  'Please enter your new password below',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    color: AppColors.grey,
                    fontSize: 18.sp,
                  ),
                ),
                BlocBuilder<ResetPasswordBloc, ResetPasswordState>(
                  builder: (context, state) {
                    final error = state.maybeWhen(
                      orElse: () {},
                      error: (error) => error,
                    );

                    return error == null
                        ? const SizedBox.shrink()
                        : Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Text(
                              error,
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 14.sp,
                              ),
                            ),
                          );
                  },
                ),
                const CustomSizedBoxHeight(0.04),
                CustomTextField(
                  controller: _oldPasswordController,
                  hintText: 'Old Password',
                  obscureText: _obscureOldPassword,
                  prefixIcon: const Icon(
                    Icons.lock_outline,
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureOldPassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureOldPassword = !_obscureOldPassword;
                      });
                    },
                  ),
                  validator: AppInputValidators.password,
                ),
                const CustomSizedBoxHeight(0.02),
                CustomTextField(
                  controller: _passwordController,
                  hintText: 'New Password',
                  obscureText: _obscurePassword,
                  prefixIcon: const Icon(
                    Icons.lock_outline,
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                  validator: AppInputValidators.password,
                ),
                const CustomSizedBoxHeight(0.02),
                CustomTextField(
                  controller: _confirmPasswordController,
                  hintText: 'Confirm Password',
                  obscureText: _obscureConfirmPassword,
                  prefixIcon: const Icon(
                    Icons.lock_outline,
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureConfirmPassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureConfirmPassword = !_obscureConfirmPassword;
                      });
                    },
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please confirm your password';
                    }
                    if (value != _passwordController.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                ),
                const CustomSizedBoxHeight(0.02),

                // Logout from all devices checkbox
                CheckboxMenuButton(
                  value: _logoutFromAllDevices,
                  onChanged: (value) {
                    setState(() {
                      _logoutFromAllDevices = value ?? false;
                    });
                  },
                  child: const Text('Logout from all devices'),
                ),

                const CustomSizedBoxHeight(0.04),
                BlocConsumer<ResetPasswordBloc, ResetPasswordState>(
                  listener: (context, state) {
                    state.maybeWhen(
                      orElse: () {},
                      success: () {
                        context.pushAndRemoveUntil(const BottomBarScreen());
                        context.showSnackBar('Password reset successful!');
                      },
                      error: (error) => context.showSnackBar(
                        error,
                        isError: true,
                      ),
                    );
                  },
                  builder: (context, state) {
                    final isLoading = state.maybeWhen(
                      orElse: () => false,
                      submitted: () => true,
                    );

                    return CustomElevatedButton(
                      isLoading: isLoading,
                      width: double.infinity,
                      onPressed: () async {
                        if (_formKey.currentState?.validate() ?? false) {
                          context.read<ResetPasswordBloc>().add(
                                ResetPasswordEvent.resetPassword(
                                  oldPassword:
                                      _oldPasswordController.text.trim(),
                                  newPassword: _passwordController.text.trim(),
                                  logoutFromAllDevices: _logoutFromAllDevices,
                                ),
                              );
                        }
                      },
                      text: 'Reset Password',
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
