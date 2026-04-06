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
        padding: 8.padding,
        child: Row(
          children: [
            Icon(
              Icons.tune,
              size: 22.sp,
              color: hasActiveFilter ? AppColors.purple : AppColors.black,
            ),
            // SvgPicture.asset(
            //   AppIcons.filterSvg,
            //   height: 18,
            //   semanticsLabel: 'Filter Booking',
            //   colorFilter: ColorFilter.mode(
            //     hasActiveFilter ? AppColors.purple : AppColors.black,
            //     BlendMode.srcIn,
            //   ),
            // ),
            if (showLabel) ...[
              4.width,
              Text(
                'Filter',
                style: TextStyle(
                  fontSize: 15.sp,
                  color: hasActiveFilter ? AppColors.purple : AppColors.black,
                ),
              ),
            ]
          ],
        ),
      ).onTap(onTap);
}
