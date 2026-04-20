import 'package:bookie_buddy_web/core/common/widgets/custom_shimmer_box.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:bookie_buddy_web/features/accounts/presentation/accounts_summary/widgets/account_list_tile.dart';
import 'package:bookie_buddy_web/utils/extensions/number_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AccountsSummaryShimmer extends StatelessWidget {
  const AccountsSummaryShimmer({super.key});

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      // Total balance card shimmer
      Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
        decoration: BoxDecoration(
          color: AppColors.purple.withValues(alpha: 0.08),
          borderRadius: 12.radiusBorder,
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomShimmerBox(width: 100.w, height: 11.h),
                  8.height,
                  CustomShimmerBox(width: 150.w, height: 26.h),
                ],
              ),
            ),
            CustomShimmerBox(width: 52.w, height: 52.h, borderRadius: 10),
          ],
        ),
      ),
      24.height,
      // Section header shimmer
      CustomShimmerBox(width: 100.w, height: 13.h),
      14.height,
      // Account tiles shimmer
      ...List.generate(
        4,
        (index) => Padding(
          padding: EdgeInsets.only(bottom: 10.h),
          child: const AccountListTileShimmer(),
        ),
      ),
    ],
  );
}
