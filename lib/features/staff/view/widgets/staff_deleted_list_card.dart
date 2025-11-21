import 'package:bookie_buddy_web/core/extensions/number_extensions.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:bookie_buddy_web/core/ui/widgets/custom_shimmer_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StaffDeletedListCard extends StatelessWidget {
  const StaffDeletedListCard({
    super.key,
    required this.name,
    required this.phoneNumber,
    this.onTap,
  });

  final String name;
  final String phoneNumber;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) => DecoratedBox(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: 9.radiusBorder,
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
          border: Border.all(color: AppColors.grey200),
        ),
        child: ListTile(
          title:
              Text(name, style: const TextStyle(fontWeight: FontWeight.w500)),
          subtitle:
              Text(phoneNumber, style: TextStyle(color: AppColors.grey600)),
          trailing: OutlinedButton(
            onPressed: onTap,
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.purple,
              side: const BorderSide(color: AppColors.purple),
              shape: RoundedRectangleBorder(borderRadius: 8.radiusBorder),
            ),
            child: const Text('Restore'),
          ),
        ),
      );
}

class StaffDeletedListCardShimmer extends StatelessWidget {
  const StaffDeletedListCardShimmer({super.key});

  @override
  Widget build(BuildContext context) => DecoratedBox(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: 9.radiusBorder,
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
          border: Border.all(color: AppColors.grey200),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
          child: Row(
            children: [
              // Content (title + subtitle) shimmer
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomShimmerBox(width: 160.w, height: 14.h),
                    8.height,
                    CustomShimmerBox(width: 110.w, height: 12.h),
                  ],
                ),
              ),
              12.width,
              // Trailing menu icon shimmer
              CustomShimmerBox(width: 65.w, height: 22.h),
              10.width,
            ],
          ),
        ),
      );
}
