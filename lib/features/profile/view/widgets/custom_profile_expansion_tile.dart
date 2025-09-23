// ignore_for_file: use_build_context_synchronously

import 'package:bookie_buddy_web/core/extensions/color_extensions.dart';
import 'package:bookie_buddy_web/core/extensions/context_extensions.dart';
import 'package:bookie_buddy_web/core/extensions/number_extensions.dart';
import 'package:bookie_buddy_web/core/extensions/widget_extensions.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomProfileExpansionTile extends StatelessWidget {
  const CustomProfileExpansionTile({
    required this.title,
    required this.icon,
    required this.cards,
    super.key,
  });

  final String title;
  final IconData icon;
  final List<CustomProfileExpandedCard> cards;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(
        title,
        style: TextStyle(
          fontSize: 17.sp,
        ),
      ),
      leading: Icon(
        icon,
        size: 24.sp,
        color: AppColors.blackShade,
      ),
      iconColor: AppColors.purple,
      expandedCrossAxisAlignment: CrossAxisAlignment.start,
      shape: const Border(),
      childrenPadding: 15.paddingHorizontal,
      children: [
        Container(
          padding: 16.padding,
          decoration: BoxDecoration(
            borderRadius: 5.radiusBorder,
            border: Border.all(color: AppColors.greyBorder),
          ),
          child: Row(
            spacing: 10.w,
            children: cards,
          ),
        ),
      ],
    );
  }
}

class CustomProfileExpandedCard extends StatelessWidget {
  const CustomProfileExpandedCard({
    required this.icon,
    required this.text,
    required this.color,
    required this.onTap,
    super.key,
  });

  final Widget icon;
  final String text;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15.w, horizontal: 25.w),
      decoration: BoxDecoration(
          color: color.lighten(0.85),
          borderRadius: 5.radiusBorder,
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            )
          ]),
      child: Column(
        children: [
          Theme(
            data: context.theme.copyWith(
              iconTheme: IconThemeData(
                color: color,
              ),
            ),
            child: icon,
          ),
          Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: color,
              fontSize: 12.sp,
            ),
          ),
        ],
      ),
    ).onTap(onTap);
  }
}
