import 'package:bookie_buddy_web/core/app_input_validators.dart';
import 'package:bookie_buddy_web/core/extensions/context_extensions.dart';
import 'package:bookie_buddy_web/core/extensions/number_extensions.dart';
import 'package:bookie_buddy_web/core/ui/widgets/custom_button.dart';
import 'package:bookie_buddy_web/core/ui/widgets/custom_textfield.dart';
import 'package:bookie_buddy_web/features/change_password/view_model/bloc_secret_password/secret_password_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChangeSecretPasswordScreen extends StatefulWidget {
  const ChangeSecretPasswordScreen({super.key});

  @override
  State<ChangeSecretPasswordScreen> createState() =>
      _ChangeSecretPasswordScreenState();
}

class _ChangeSecretPasswordScreenState
    extends State<ChangeSecretPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _oldPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  final _oldPasswordFocus = FocusNode();
  final _newPasswordFocus = FocusNode();
  final _confirmPasswordFocus = FocusNode();

  bool _isOldPasswordVisible = false;
  bool _isNewPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  @override
  void dispose() {
    _oldPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    _oldPasswordFocus.dispose();
    _newPasswordFocus.dispose();
    _confirmPasswordFocus.dispose();
    super.dispose();
  }

  void _togglePasswordVisibility(String field) {
    setState(() {
      switch (field) {
        case 'old':
          _isOldPasswordVisible = !_isOldPasswordVisible;
          break;
        case 'new':
          _isNewPasswordVisible = !_isNewPasswordVisible;
          break;
        case 'confirm':
          _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
          break;
      }
    });
  }

  void _handleSubmit() {
    if (!_formKey.currentState!.validate()) {
      context.showSnackBar(
        'Please fill in all fields correctly',
        isError: true,
      );
      return;
    }

    // Unfocus all text fields
    FocusScope.of(context).unfocus();

    context.read<SecretPasswordBloc>().add(
          SecretPasswordEvent.submitPasswordChange(
            oldPassword: _oldPasswordController.text.trim(),
            newPassword: _newPasswordController.text.trim(),
          ),
        );
  }

  String? _validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }
    if (value != _newPasswordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Secret Password'),
      ),
      body: BlocConsumer<SecretPasswordBloc, SecretPasswordState>(
        listener: (context, state) {
          state.maybeWhen(
            orElse: () {},
            success: () {
              // Clear form fields
              _oldPasswordController.clear();
              _newPasswordController.clear();
              _confirmPasswordController.clear();

              context.pop();
              context.showSnackBar('Password changed successfully!');
            },
            failure: (message) => context.showSnackBar(
              message,
              isError: true,
            ),
          );
        },
        builder: (context, state) {
          final isLoading = state.maybeWhen(
            orElse: () => false,
            loading: () => true,
          );

          return SafeArea(
            child: SingleChildScrollView(
              padding: context.isMobile ? 20.padding : (40, 20).padding,
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Header Section
                    _buildHeaderSection(),

                    32.height,

                    // Password Fields
                    _buildPasswordField(
                      controller: _oldPasswordController,
                      focusNode: _oldPasswordFocus,
                      nextFocusNode: _newPasswordFocus,
                      label: 'Current Password',
                      hint: 'Enter your current password',
                      isVisible: _isOldPasswordVisible,
                      onToggleVisibility: () =>
                          _togglePasswordVisibility('old'),
                      validator: AppInputValidators.password,
                      isEnabled: !isLoading,
                    ),

                    24.height,

                    _buildPasswordField(
                      controller: _newPasswordController,
                      focusNode: _newPasswordFocus,
                      nextFocusNode: _confirmPasswordFocus,
                      label: 'New Password',
                      hint: 'Enter your new password',
                      isVisible: _isNewPasswordVisible,
                      onToggleVisibility: () =>
                          _togglePasswordVisibility('new'),
                      validator: AppInputValidators.password,
                      isEnabled: !isLoading,
                    ),

                    24.height,

                    _buildPasswordField(
                      controller: _confirmPasswordController,
                      focusNode: _confirmPasswordFocus,
                      label: 'Confirm New Password',
                      hint: 'Re-enter your new password',
                      isVisible: _isConfirmPasswordVisible,
                      onToggleVisibility: () =>
                          _togglePasswordVisibility('confirm'),
                      validator: _validateConfirmPassword,
                      isEnabled: !isLoading,
                      textInputAction: TextInputAction.done,
                      onSubmitted: (_) {
                        _handleSubmit();
                        return null;
                      },
                    ),

                    40.height,

                    // Submit Button
                    CustomElevatedButton(
                      width: double.infinity,
                      text: 'Update Password',
                      onPressed: isLoading ? () {} : _handleSubmit,
                      isLoading: isLoading,
                    ),

                    // 16.height,

                    // Security tip
                    // _buildSecurityTip(),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildHeaderSection() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            Icons.security,
            size: 48.sp,
            color: Theme.of(context).colorScheme.onPrimaryContainer,
          ),
        ),
        16.height,
        Text(
          'Update Your Password',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24.sp,
          ),
          textAlign: TextAlign.center,
        ),
        8.height,
        Text(
          'Keep your account secure by updating your password regularly',
          style: TextStyle(
            fontSize: 15.sp,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildPasswordField({
    required TextEditingController controller,
    required FocusNode focusNode,
    required String label,
    required String hint,
    required bool isVisible,
    required VoidCallback onToggleVisibility,
    required String? Function(String?) validator,
    required bool isEnabled,
    FocusNode? nextFocusNode,
    TextInputAction textInputAction = TextInputAction.next,
    String? Function(String?)? onSubmitted,
  }) {
    return CustomTextField(
      controller: controller,
      focusNode: focusNode,
      validator: validator,
      obscureText: !isVisible,
      label: label,
      hintText: hint,
      isEnabled: isEnabled,
      textInputAction: textInputAction,
      submitFun: onSubmitted ??
          (_) {
            if (nextFocusNode != null) {
              FocusScope.of(context).requestFocus(nextFocusNode);
            }
            return null;
          },
      prefixIcon: const Icon(Icons.lock_outline),
      suffixIcon: IconButton(
        icon: Icon(
          isVisible ? Icons.visibility : Icons.visibility_off,
        ),
        onPressed: isEnabled ? onToggleVisibility : null,
        tooltip: isVisible ? 'Hide password' : 'Show password',
      ),
    );
  }

  // Widget _buildSecurityTip() {
  //   return Container(
  //     padding: const EdgeInsets.all(16),
  //     decoration: BoxDecoration(
  //       color: Theme.of(context).colorScheme.surfaceVariant,
  //       borderRadius: BorderRadius.circular(12),
  //       border: Border.all(
  //         color: Theme.of(context).colorScheme.outline.withOpacity(0.3),
  //       ),
  //     ),
  //     child: Row(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Icon(
  //           Icons.info_outline,
  //           size: 20,
  //           color: Theme.of(context).colorScheme.primary,
  //         ),
  //         12.width,
  //         Expanded(
  //           child: Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               Text(
  //                 'Security Tips',
  //                 style: Theme.of(context).textTheme.labelLarge?.copyWith(
  //                       fontWeight: FontWeight.w600,
  //                       color: Theme.of(context).colorScheme.primary,
  //                     ),
  //               ),
  //               4.height,
  //               Text(
  //                 'Use a strong password with at least 8 characters, including uppercase, lowercase, numbers, and special characters.',
  //                 style: Theme.of(context).textTheme.bodySmall?.copyWith(
  //                       color: Theme.of(context).colorScheme.onSurfaceVariant,
  //                     ),
  //               ),
  //             ],
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }
}
