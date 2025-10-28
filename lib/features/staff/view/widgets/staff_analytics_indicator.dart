import 'package:bookie_buddy_web/core/extensions/number_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StaffAnalyticsIndicator extends StatelessWidget {
  const StaffAnalyticsIndicator({
    super.key,
    required this.color,
    required this.title,
    required this.amount,
  });

  final Color color;
  final String title;
  final int amount;

  @override
  Widget build(BuildContext context) => ListTile(
    leading: Icon(Icons.square_rounded, color: color, size: 20),
    title: Text(
      title,
      style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16.sp),
    ),
    trailing: Text(
      amount.toCurrency(),
      style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16.sp),
    ),
  );
}
