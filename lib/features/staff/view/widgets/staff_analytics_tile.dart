import 'package:bookie_buddy_web/core/extensions/number_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StaffAnalyticsTile extends StatelessWidget {
  const StaffAnalyticsTile({
    super.key,
    required this.title,
    required this.count,
    required this.onTap,
  });

  final String title;
  final int count;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) => ListTile(
    onTap: onTap,
    title: Text(
      title,
      style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16.sp),
    ),
    trailing: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          count.toString(),
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16.sp),
        ),
        10.width,
        const Icon(Icons.arrow_forward_ios_rounded, size: 16),
      ],
    ),
  );
}
