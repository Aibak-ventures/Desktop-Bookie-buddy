import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:bookie_buddy_web/utils/extensions/number_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TotalBalanceCard extends StatelessWidget {
  const TotalBalanceCard({super.key, required this.totalBalance});

  final double totalBalance;

  @override
  Widget build(BuildContext context) => Container(
    padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: [AppColors.purple, Color(0xFF7B5CEA)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: 12.radiusBorder,
    ),
    child: Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'TOTAL BALANCE',
                style: TextStyle(
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white70,
                  letterSpacing: 1.2,
                ),
              ),
              6.height,
              Text(
                totalBalance.toCurrency(),
                style: TextStyle(
                  fontSize: 26.sp,
                  fontWeight: FontWeight.w700,
                  color: totalBalance.isNegative
                      ? AppColors.redLightOnDarkBg
                      : AppColors.white,
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: 12.padding,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.15),
            borderRadius: 10.radiusBorder,
          ),
          child: Icon(
            Icons.account_balance_wallet_rounded,
            color: AppColors.white,
            size: 28.sp,
          ),
        ),
      ],
    ),
  );
}
