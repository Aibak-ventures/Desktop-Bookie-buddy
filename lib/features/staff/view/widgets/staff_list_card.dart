import 'package:bookie_buddy_web/core/extensions/number_extensions.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:bookie_buddy_web/core/ui/widgets/custom_shimmer_box.dart';
// import 'package:bookie_buddy_web/core/ui/widgets/premium_menu_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StaffListCard extends StatelessWidget {
  const StaffListCard({
    super.key,
    required this.name,
    required this.phoneNumber,
    required this.onEdit,
    required this.onDelete,
    this.onTapAnalytics,
  });

  final String name;
  final String phoneNumber;
  final VoidCallback? onTapAnalytics;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

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
          trailing: PopupMenuButton<String>(
            onSelected: (value) {
              switch (value) {
                // case 'analytics':
                //   if (onTapAnalytics != null) onTapAnalytics!();
                //   break;
                case 'edit':
                  onEdit();
                  break;
                case 'delete':
                  onDelete();
                  break;
                default:
              }
            },
            itemBuilder: (context) => [
              // const PopupMenuItem(
              //   value: 'analytics',
              //   child: Row(
              //     spacing: 5,
              //     children: [
              //       Icon(Icons.show_chart_rounded, color: AppColors.purple),
              //       Text('Analytics'),
              //       SizedBox(width: 5),
              //       PremiumBadge(showLabel: false),
              //     ],
              //   ),
              // ),
              // PopupMenuItem(
              //   value: 'analytics',
              //   child: Shimmer.fromColors(
              //     baseColor: Colors.amber.shade700,
              //     highlightColor: Colors.amber.shade500,
              //     child: const Row(
              //       spacing: 5,
              //       children: [
              //         Icon(Icons.show_chart_rounded, color: AppColors.purple),
              //         Text('Analytics'),
              //         const SizedBox(width: 5),
              //         // PremiumBadge(showLabel: false),
              //         Icon(CustomIcons.premium, size: 20),
              //       ],
              //     ),
              //   ),
              // ),
              // const PremiumMenuItem(
              //   value: 'analytics',
              //   label: 'Analytics',
              //   icon: Icon(Icons.show_chart_rounded),
              // ),
              const PopupMenuItem(
                value: 'edit',
                child: Row(
                  spacing: 5,
                  children: [
                    Icon(Icons.edit_outlined, color: AppColors.purple),
                    Text('Edit'),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: 'delete',
                child: Row(
                  spacing: 5,
                  children: [
                    Icon(Icons.delete_outline, color: AppColors.redTomato),
                    Text('Delete'),
                  ],
                ),
              ),
            ],
            padding: EdgeInsets.zero,
            child: Icon(Icons.more_vert_rounded, size: 20.sp),
          ),
        ),
      );
}

class StaffListCardShimmer extends StatelessWidget {
  const StaffListCardShimmer({super.key});

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
              Icon(Icons.more_vert_rounded, size: 20.sp),
              10.width,
            ],
          ),
        ),
      );
}
