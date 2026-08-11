import 'package:bookie_buddy_web/utils/extensions/number_extensions.dart';
import 'package:bookie_buddy_web/utils/extensions/widget_extensions.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DateFilterButton extends StatelessWidget {
  final VoidCallback onTap;
  final bool hasActiveFilter;
  final bool showLabel;

  const DateFilterButton({
    required this.onTap,
    super.key,
    this.hasActiveFilter = false,
    this.showLabel = true,
  });

  @override
  Widget build(BuildContext context) => Container(
    decoration: BoxDecoration(
      color: AppColors.purpleLightShade,
      borderRadius: BorderRadius.circular(5),
    ),
    padding: 15.padding,
    child: Row(
      children: [
        Icon(
          Icons.tune,
          size: 26.sp,
          color: hasActiveFilter ? AppColors.purple : AppColors.black,
        ),
        if (showLabel) ...[
          6.width,
          Text(
            'Filter',
            style: TextStyle(
              fontSize: 22.sp,
              color: hasActiveFilter ? AppColors.purple : AppColors.black,
            ),
          ),
        ],
      ],
    ),
  ).onTap(onTap);
}
