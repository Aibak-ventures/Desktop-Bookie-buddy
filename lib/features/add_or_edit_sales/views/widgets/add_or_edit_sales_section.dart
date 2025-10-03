import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddOrEditSalesSection extends StatelessWidget {
  final String title;
  final Widget child;

  const AddOrEditSalesSection({
    super.key,
    required this.title,
    required this.child,
  });

  @override
  Widget build(BuildContext context) => Column(
    spacing: 10.w,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title,
        style: TextStyle(
          // color: AppColors.grey600,
          fontWeight: FontWeight.w600,
          fontSize: 16.sp,
        ),
      ),
      child,
    ],
  );
}
