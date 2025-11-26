import 'package:bookie_buddy_web/core/extensions/context_extensions.dart';
import 'package:bookie_buddy_web/utils/debouncer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class CustomSearchField extends StatelessWidget {
  CustomSearchField({
    super.key,
    required this.searchController,
    required this.onChanged,
    required this.hintText,
    this.isSuffixHidden = false,
    this.padding = const EdgeInsets.all(10),
    this.suffixIcon,
    this.prefixIcon,
    this.suffixFunction,
    this.focusNode,
  });

  final TextEditingController searchController;
  final EdgeInsetsGeometry padding;
  final String hintText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final void Function(
    String query,
  )? onChanged;
  final void Function()? suffixFunction;
  final bool isSuffixHidden;
  final FocusNode? focusNode;

  final debouncer = Debouncer();

  @override
  Widget build(BuildContext context) => Padding(
        padding: padding,
        child: TextField(
          controller: searchController,
          onTapOutside: (_) => context.hideKeyboard(),
          focusNode: focusNode,
          textInputAction: TextInputAction.search,
          decoration: InputDecoration(
            hintText: hintText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            prefixIcon: Icon(
              LucideIcons.search500,
              size: 24.sp,
            ),
            // Padding(
            //   padding: 12.padding, // Adjust as needed
            //   child: SvgPicture.asset(
            //     AppIcons.searchSvg,
            //     height: 20,
            //     width: 20,
            //   ),
            // ),
            suffixIcon: ValueListenableBuilder<TextEditingValue>(
              valueListenable: searchController,
              builder: (context, value, _) {
                final isEmpty = value.text.trim().isEmpty;
                return suffixIcon ??
                    (isEmpty
                        ? const SizedBox.shrink()
                        : IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: suffixFunction ?? searchController.clear,
                          ));
              },
            ),
          ),
          onChanged: (query) {
            if (onChanged != null) {
              debouncer.run(() => onChanged!(query.trim()));
            }
          },
          onSubmitted: (query) {
            if (onChanged != null) {
              debouncer.run(
                () => onChanged!(query.trim()),
              );
            }
          },
        ),
      );
}
