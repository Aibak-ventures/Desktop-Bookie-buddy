import 'package:bookie_buddy_web/core/extensions/number_extensions.dart';
import 'package:bookie_buddy_web/core/extensions/widget_extensions.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  const CustomIconButton({
    required this.icon,
    this.height = 35,
    this.width = 35,
    this.color = AppColors.black,
    this.bgColor = AppColors.purpleLight,
    this.radius = 5,
    this.padding,
    this.label,
    this.onTap,
    super.key,
  });

  final double? height;
  final double? width;

  final Color color;
  final Color bgColor;
  final double radius;
  final EdgeInsetsGeometry? padding;

  final Widget icon;
  final Widget? label;

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: height,
      width: width,
      padding: padding,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: radius.radiusBorder,
      ),
      child: label == null
          ? icon
          : Row(
              mainAxisSize: MainAxisSize.min,
              spacing: 5,
              children: [
                icon,
                label!,
              ],
            ),
    ).onTap(onTap);
  }
}
