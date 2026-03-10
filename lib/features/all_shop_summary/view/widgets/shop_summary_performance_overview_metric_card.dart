import 'package:bookie_buddy_web/core/constants/custom_icons_icons.dart';
import 'package:bookie_buddy_web/utils/extensions/color_extensions.dart';
import 'package:bookie_buddy_web/utils/extensions/number_extensions.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ShopSummaryPerformanceOverviewMetricCard extends StatelessWidget {
  final IconData icon;
  final Color iconBgColor;
  final String label;
  final int value;
  final String subtitle;
  final int growth;
  final bool isFullWidth;
  final bool negativeColor;
  final bool negativeIcon;
  final String? suffixValue;

  const ShopSummaryPerformanceOverviewMetricCard({
    super.key,
    required this.icon,
    required this.iconBgColor,
    required this.label,
    required this.value,
    required this.subtitle,
    required this.growth,
    this.isFullWidth = false,
    this.negativeColor = false,
    this.negativeIcon = false,
    this.suffixValue,
  });

  @override
  Widget build(BuildContext context) {
    final isPositive = growth >= 0;
    final growthColor =
        (negativeColor ? !isPositive : isPositive) ? _greenColor : _redColor;
    final growthBgColor = growthColor.changeOpacity(0.1);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Icon and Growth Badge
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Label
            Text(
              label,
              style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
                color: Colors.grey[600],
                letterSpacing: 0.3,
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: (8, 4).padding,
                  decoration: BoxDecoration(
                    color: growthBgColor,
                    borderRadius: 8.radiusBorder,
                  ),
                  child: Row(
                    children: [
                      Icon(
                        (negativeIcon ? !isPositive : isPositive)
                            ? CustomIcons.growthIncrease
                            : CustomIcons.growthDecrease,
                        size: 12.sp,
                        color: growthColor,
                      ),
                      2.width,
                      Text(
                        '${growth.abs()}%',
                        style: TextStyle(
                          fontSize: 11.sp,
                          fontWeight: FontWeight.bold,
                          color: growthColor,
                        ),
                      ),
                    ],
                  ),
                ),
                if (suffixValue != null) ...[
                  5.width,
                  Text(
                    suffixValue!,
                    style: TextStyle(
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w500,
                      // color: Colors.grey[600],
                    ),
                  ),
                ],
              ],
            ),
          ],
        ),
        5.height,

        // Value
        Text(
          value.toCurrency(),
          style: TextStyle(
            fontSize: 22.sp,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        2.height,

        // Subtitle
        Text(
          subtitle,
          style: TextStyle(fontSize: 11.sp, color: Colors.grey[600]),
        ),
      ],
    );
  }

  Color get _greenColor => AppColors.green;
  Color get _redColor => AppColors.redTomato;
}
