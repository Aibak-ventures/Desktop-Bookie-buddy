import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EditBookingSectionColumn extends StatelessWidget {
  final String title;
  final Widget child;
  final Widget? trailing;

  const EditBookingSectionColumn({
    super.key,
    required this.title,
    required this.child,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    final titleWidget = Text(
      title,
      style: TextStyle(color: AppColors.grey600, fontSize: 16.sp),
    );
    return Column(
      spacing: 10.w,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (trailing == null)
          titleWidget
        else
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [titleWidget, trailing!],
          ),
        child,
      ],
    );
  }
}
