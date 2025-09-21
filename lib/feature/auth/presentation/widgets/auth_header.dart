import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../common/theme/app_theme.dart';

class AuthHeader extends StatelessWidget {
  final String title;
  final String subtitle;
  final Widget? logo;

  const AuthHeader({
    super.key,
    required this.title,
    required this.subtitle,
    this.logo,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Logo
        if (logo != null) ...[
          logo!,
          SizedBox(height: 24.h),
        ] else ...[
          Container(
            width: 80.w,
            height: 80.h,
            decoration: const BoxDecoration(
              color: AppTheme.primaryColor,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.book,
              color: Colors.white,
              size: 40.w,
            ),
          ),
          SizedBox(height: 24.h),
        ],
        
        // Title
        Text(
          title,
          style: TextStyle(
            fontSize: 28.sp,
            fontWeight: FontWeight.bold,
            color: AppTheme.textPrimaryColor,
          ),
          textAlign: TextAlign.center,
        ),
        
        SizedBox(height: 8.h),
        
        // Subtitle
        Text(
          subtitle,
          style: TextStyle(
            fontSize: 16.sp,
            color: AppTheme.textSecondaryColor,
            height: 1.4,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
