import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomProfileTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final Widget? trailing;

  const CustomProfileTile({
    required this.icon,
    required this.title,
    required this.onTap,
    this.trailing,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
        color: AppColors.blackShade,
        size: 24.sp,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: AppColors.blackShade,
          fontSize: 17.sp,
        ),
      ),
      trailing: trailing ?? Icon(Icons.arrow_forward_ios, size: 16.sp),
      onTap: onTap,
    );
  }
}
