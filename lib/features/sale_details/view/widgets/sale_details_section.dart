import 'package:bookie_buddy_web/core/extensions/number_extensions.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SaleDetailsSection extends StatelessWidget {
  const SaleDetailsSection({
    super.key,
    required this.title,
    required this.child,
    this.trailing,
    this.leading,
    this.padding,
  });

  final String title;
  final Widget child;
  final Widget? trailing;
  final Widget? leading;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) => Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (leading != null) leading!,
              if (title.isNotEmpty)
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w300,
                    color: Colors.grey,
                  ),
                ),
              if (trailing != null) trailing!,
            ],
          ),
          10.height,
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
        ],
      );
}
