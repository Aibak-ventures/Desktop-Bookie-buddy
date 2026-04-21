import 'package:bookie_buddy_web/utils/extensions/context_extensions.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomDropDownField<T> extends StatelessWidget {
  final List<T> items;
  final String Function(T item)? itemLabelBuilder;
  final void Function(T? newValue) onChanged;
  final Widget? prefixIcon;
  final T? selectedValue;
  final String hintText;
  final String? label;
  final EdgeInsetsGeometry contentPadding;
  final double? menuHeight;
  final InputDecorationTheme? inputDecorationTheme;
  final double? width;
  final bool enableFilter;

  const CustomDropDownField({
    super.key,
    required this.hintText,
    required this.onChanged,
    required this.items,
    required this.itemLabelBuilder,
    this.prefixIcon,
    this.selectedValue,
    this.contentPadding = const EdgeInsets.symmetric(
      horizontal: 12,
      vertical: 8,
    ),
    this.menuHeight,
    this.inputDecorationTheme,
    this.label,
    this.width,
    this.enableFilter = false,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownMenu<T>(
      initialSelection: selectedValue,
      onSelected: onChanged,
      menuHeight: menuHeight,
      hintText: hintText,
      filterCallback: !enableFilter
          ? null
          : (entries, filter) {
              final String trimmedFilter = filter.trim().toLowerCase();
              if (trimmedFilter.isEmpty) {
                return entries;
              }

              return entries
                  .where(
                    (entry) =>
                        entry.label.toLowerCase().contains(trimmedFilter),
                  )
                  .toList();
            },
      enableFilter: enableFilter,
      enableSearch: false,
      label: label != null
          ? Text(label!, style: TextStyle(color: AppColors.grey600))
          : null,
      leadingIcon: prefixIcon,
      width: width,
      trailingIcon: Icon(
        Icons.keyboard_arrow_down_outlined,
        color: AppColors.grey600,
      ),
      inputDecorationTheme:
          inputDecorationTheme ??
          context.theme.dropdownMenuTheme.inputDecorationTheme?.copyWith(
            contentPadding: contentPadding,
          ),
      dropdownMenuEntries: items
          .map(
            (item) => DropdownMenuEntry<T>(
              value: item,
              label: itemLabelBuilder?.call(item) ?? item.toString(),
              style: ButtonStyle(
                textStyle: WidgetStateProperty.all(TextStyle(fontSize: 16.sp)),
                padding: WidgetStateProperty.all(
                  const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                ),
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
            ),
          )
          .toList(),
    );
  }
}
