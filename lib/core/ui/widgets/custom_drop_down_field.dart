import 'package:bookie_buddy_web/core/extensions/context_extensions.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomDropDownField<T> extends StatelessWidget {
  final List items;
  final void Function(T? newValue) onChanged;
  final Widget? prefixIcon;
  final T? selectedValue;
  final String hintText;
  final EdgeInsetsGeometry contentPadding;

  const CustomDropDownField({
    required this.hintText,
    required this.onChanged,
    required this.items,
    this.prefixIcon,
    this.selectedValue,
    super.key,
    this.contentPadding =
        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
  });

  @override
  Widget build(BuildContext context) {
    return DropdownMenu<T>(
      initialSelection: selectedValue,
      onSelected: onChanged,
      hintText: hintText,
      leadingIcon: prefixIcon,
      width: double.infinity,
      trailingIcon: Icon(
        Icons.keyboard_arrow_down_outlined,
        color: AppColors.grey600,
      ),

      inputDecorationTheme:
          context.theme.dropdownMenuTheme.inputDecorationTheme?.copyWith(
        contentPadding: contentPadding,
      ),
      // alignmentOffset: Offset(context.screenWidth - 200, 0),
      dropdownMenuEntries: items.map((item) {
        return DropdownMenuEntry<T>(
          value: item,
          label: item.toString(),
          style: ButtonStyle(
            textStyle: WidgetStateProperty.all(
              TextStyle(
                fontSize: 16.sp,
              ),
            ),
            fixedSize: WidgetStateProperty.all(
                Size.fromWidth(context.screenWidth - 50)),
            padding: WidgetStateProperty.all(const EdgeInsets.symmetric(
              vertical: 12,
              horizontal: 16,
            )), // 👉 item padding
            foregroundColor: WidgetStateProperty.resolveWith((states) {
              if (states.contains(WidgetState.selected)) {
                return AppColors.white;
              }
              return AppColors.black;
            }),
            backgroundColor: WidgetStateProperty.resolveWith((states) {
              if (states.contains(WidgetState.selected)) {
                return AppColors.purple;
              }
              return Colors.transparent;
            }),
          ),
        );
      }).toList(),
    );
  }
}
