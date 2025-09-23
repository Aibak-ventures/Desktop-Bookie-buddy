import 'package:bookie_buddy_web/core/extensions/color_extensions.dart';
import 'package:bookie_buddy_web/core/extensions/context_extensions.dart';
import 'package:bookie_buddy_web/core/extensions/number_extensions.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? label;
  final String? hintText;
  final TextInputType? keyboardType;
  final String? Function(String? value)? validator;
  final String? Function(String? value)? submitFun;
  final List<TextInputFormatter>? textInputFormatter;
  final AutovalidateMode? autovalidateMode;

  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final Widget? prefix;
  final Widget? suffix;
  final int? maxLengths;
  final int? minLines;
  final int? maxLines;
  final bool? isEnabled;
  final bool obscureText;
  final void Function(String value)? onChanged;

  final TextCapitalization textCapitalization;

  /// [onTapOutside] is called when the user taps outside the text field
  ///
  /// default behavior is *keyboard dismissed*
  final void Function()? onTapOutside;
  final bool? ignorePointers;
  final Color? fillColor;
  final bool autofocus;
  final TextInputAction? textInputAction;
  final FocusNode? focusNode;
  final bool readOnly;

  final TextAlign textAlign;
  final String? errorText;

  const CustomTextField({
    required this.controller,
    required this.validator,
    this.hintText,
    this.textInputFormatter,
    super.key,
    this.label,
    this.maxLines,
    this.keyboardType,
    this.suffixIcon,
    this.prefixIcon,
    this.prefix,
    this.maxLengths,
    this.minLines,
    this.submitFun,
    this.isEnabled,
    this.obscureText = false,
    this.autovalidateMode,
    this.onChanged,
    this.ignorePointers,
    this.fillColor,
    this.autofocus = false,
    this.onTapOutside,
    this.textInputAction,
    this.focusNode,
    this.suffix,
    this.textCapitalization = TextCapitalization.none,
    this.readOnly = false,
    this.textAlign = TextAlign.start,
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    final borderRadius = 5.0;
    return TextFormField(
      key: key,
      enabled: isEnabled,
      textInputAction: textInputAction,
      focusNode: focusNode,
      onFieldSubmitted: submitFun ??
          (_) {
            // final focus = FocusManager.instance.primaryFocus;
            // if (focus == null) return;
            // if (focus.traversalDescendants.isEmpty) return;
            // focus.focusInDirection(TraversalDirection.down);
          },
      ignorePointers: ignorePointers,
      textAlign: textAlign,
      inputFormatters: textInputFormatter,
      maxLines: obscureText ? 1 : maxLines ?? 1,
      maxLength: maxLengths,
      minLines: minLines,
      readOnly: readOnly,
      autofocus: autofocus,
      textCapitalization: textCapitalization,
      cursorColor: AppColors.grey600,
      style: TextStyle(
        color: AppColors.grey600,
        fontWeight: FontWeight.w500,
      ),
      onTapOutside: (_) => onTapOutside ?? context.hideKeyboard(),
      autovalidateMode: autovalidateMode,
      controller: controller,
      onChanged: onChanged,
      validator: validator,
      obscureText: obscureText,
      decoration: InputDecoration(
        errorText: errorText,
        border: OutlineInputBorder(
          borderRadius: borderRadius.radiusBorder,
          borderSide: BorderSide(
            color: AppColors.grey400,
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.grey400,
          ),
          borderRadius: borderRadius.radiusBorder,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.grey400,
          ),
          borderRadius: borderRadius.radiusBorder,
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: AppColors.black,
          ),
          borderRadius: borderRadius.radiusBorder,
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: AppColors.redTomato,
          ),
          borderRadius: borderRadius.radiusBorder,
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: AppColors.redTomato,
          ),
          borderRadius: borderRadius.radiusBorder,
        ),
        counterText: '',
        labelText: label,
        hintText: hintText,
        alignLabelWithHint: true,
        prefix: prefix,
        prefixIcon: prefixIcon,
        prefixIconColor: AppColors.purple.lighten(0.2),
        suffixIcon: suffixIcon,
        suffix: suffix,
        fillColor: fillColor,
        filled: fillColor != null,
        hintStyle: const TextStyle(
          color: AppColors.grey,
          fontWeight: FontWeight.w500,
        ),
        labelStyle: const TextStyle(
          color: AppColors.grey,
          fontWeight: FontWeight.w500,
          // fontSize: 18.sp,
        ),
      ),
      keyboardType: keyboardType,
    );
  }
}
