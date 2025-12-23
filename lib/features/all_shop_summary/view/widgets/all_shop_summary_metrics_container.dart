import 'package:bookie_buddy_web/core/extensions/color_extensions.dart';
import 'package:bookie_buddy_web/core/extensions/number_extensions.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AllShopSummaryMetricsContainer extends StatelessWidget {
  const AllShopSummaryMetricsContainer({
    super.key,
    required this.child,
    this.bgColor = Colors.white,
    this.gradient,
    this.padding,
  });
  final Widget child;
  final Color bgColor;
  final Gradient? gradient;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? 16.padding,
      decoration: BoxDecoration(
        color: bgColor,
        gradient: gradient,
        borderRadius: 10.radiusBorder,
        border: Border.all(color: AppColors.grey100),
        boxShadow: [
          BoxShadow(
            color: Colors.black.changeOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: child,
    );
  }
}
