import 'package:bookie_buddy_web/core/extensions/number_extensions.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SaleDetailsPaymentDetailsRow extends StatelessWidget {
  const SaleDetailsPaymentDetailsRow({
    super.key,
    required this.title,
    required this.amount,
    this.isTotal = false,
    this.trailing,
  });
  final String title;
  final int amount;
  final bool isTotal;
  final String? trailing;

  @override
  Widget build(BuildContext context) => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(title, style: TextStyle(fontSize: 16.sp)),
      !isTotal
          ? Text(
              trailing ?? amount.toCurrency(),
              style: TextStyle(fontSize: 16.sp),
            )
          : Container(
              padding: 5.padding,
              decoration: BoxDecoration(
                color: AppColors.purpleLight,
                borderRadius: 5.radiusBorder,
              ),
              child: Text(
                amount.toCurrency(),
                style: TextStyle(fontSize: 16.sp, color: AppColors.purple),
              ),
            ),
    ],
  );
}
