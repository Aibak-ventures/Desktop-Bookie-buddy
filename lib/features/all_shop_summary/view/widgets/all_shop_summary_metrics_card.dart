import 'package:bookie_buddy_web/core/constants/custom_icons_icons.dart';
import 'package:bookie_buddy_web/core/extensions/number_extensions.dart';
import 'package:bookie_buddy_web/features/all_shop_summary/view/widgets/all_shop_summary_metrics_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AllShopSummaryMetricsCard extends StatelessWidget {
  final String label;
  final int value;
  final int growth;
  final bool isFullWidth;
  final Color valueColor;
  final String? growthPrefix;
  final Widget? background;
  final Color bgColor;
  final Color? growthColor;
  final Gradient? gradient;
  final bool negativeGrowth;

  const AllShopSummaryMetricsCard({
    super.key,
    required this.label,
    required this.value,
    required this.growth,
    this.isFullWidth = false,
    required this.valueColor,
    this.growthPrefix,
    this.background,
    this.bgColor = Colors.white,
    this.gradient,
    this.growthColor,
    this.negativeGrowth = false,
  });

  @override
  Widget build(BuildContext context) {
    final isPositive = negativeGrowth ? growth < 0 : growth >= 0;
    final _growthColor = growthColor ?? (isPositive ? _greenColor : _redColor);

    final content = Padding(
      padding: 16.padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
              letterSpacing: 0.5,
            ),
          ),
          4.height,
          FittedBox(
            child: Text(
              value.toCurrency(decimalDigits: 2),
              style: TextStyle(
                fontSize: isFullWidth ? 36.sp : 26.sp,
                fontWeight: FontWeight.bold,
                // color: valueColor,
                color: Colors.white,
              ),
            ),
          ),
          4.height,
          Row(
            children: [
              Icon(
                isPositive
                    ? CustomIcons.growthIncrease
                    : CustomIcons.growthDecrease,
                size: 14.sp,
                color: _growthColor,
              ),
              4.width,
              Text(
                '${growth.abs()}%',
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                  color: _growthColor,
                ),
              ),
              if (growthPrefix != null) ...[
                4.width,
                Text(
                  growthPrefix!,
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );

    return AllShopSummaryMetricsContainer(
      bgColor: bgColor,
      gradient: gradient,
      padding: EdgeInsets.zero,
      child: background == null
          ? content
          : Stack(
              fit: StackFit.passthrough,
              children: [
                // Background
                background!,

                // Content
                content,
              ],
            ),
    );
  }

  Color get _greenColor => const Color.fromARGB(255, 89, 255, 131);
  Color get _redColor => const Color.fromARGB(255, 255, 153, 148);
}
