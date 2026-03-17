import 'package:bookie_buddy_web/utils/extensions/number_extensions.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BookingDetailsSection extends StatelessWidget {
  const BookingDetailsSection({
    super.key,
    required this.title,
    this.trailing,
    this.leading,
    required this.child,
    this.padding,
    this.customChild,
  });
  final String title;
  final Widget? trailing;
  final Widget? leading;
  final Widget? child;
  final Widget? customChild;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    assert(
      child == null || customChild == null,
      'Provide either child or customChild, not both.',
    );
    final titleWidget = Text(
      title,
      style: TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.w300,
        color: Colors.grey,
      ),
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (leading == null && trailing == null)
          titleWidget
        else
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Leading widget
              if (leading != null) leading!,

              // Title
              if (title.isNotEmpty) titleWidget,

              // Trailing widget
              if (trailing != null) trailing!,
            ],
          ),
        // Spacing
        if (child != null || customChild != null) 10.height,

        // Child widget with container
        if (child != null)
          Container(
            width: double.infinity,
            padding: padding,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: 10.radiusBorder,
              border: Border.all(color: AppColors.greyBorder),
              boxShadow: [
                BoxShadow(
                  color: AppColors.grey200,
                  spreadRadius: 1,
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: child,
          ),

        // If you want to provide your own
        // child without container
        if (customChild != null) customChild!,
      ],
    );
  }
}
