import 'package:bookie_buddy_shared/core/core/common/entities/tax_configuration_entity/tax_configuration_entity.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:bookie_buddy_web/utils/extensions/number_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TaxConfigurationCard extends StatelessWidget {
  const TaxConfigurationCard({
    super.key,
    required this.taxConfiguration,
    required this.canManage,
    required this.onToggleEnabled,
    required this.onEdit,
  });

  final TaxConfigurationEntity taxConfiguration;
  final bool canManage;
  final ValueChanged<bool> onToggleEnabled;
  final VoidCallback onEdit;

  @override
  Widget build(BuildContext context) => Container(
    padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 18.h),
    decoration: BoxDecoration(
      color: AppColors.white,
      borderRadius: 12.radiusBorder,
      border: Border.all(color: AppColors.grey200),
      boxShadow: [
        BoxShadow(
          color: AppColors.black.withValues(alpha: 0.04),
          blurRadius: 8,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: 10.padding,
              decoration: BoxDecoration(
                color: AppColors.purpleLight,
                borderRadius: 10.radiusBorder,
              ),
              child: Icon(Icons.percent, color: AppColors.purple, size: 32.sp),
            ),
            12.width,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    taxConfiguration.taxName,
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  3.height,
                  Text(
                    '${taxConfiguration.taxRate.toStringAsFixed(2)}% · '
                    '${taxConfiguration.taxCalculationType.label}',
                    style: TextStyle(fontSize: 16.sp, color: AppColors.grey600),
                  ),
                ],
              ),
            ),
            if (canManage) ...[
              IconButton(
                onPressed: onEdit,
                icon: Icon(
                  Icons.edit_outlined,
                  size: 28.sp,
                  color: AppColors.grey600,
                ),
                tooltip: 'Edit',
                visualDensity: VisualDensity.compact,
                constraints: const BoxConstraints(),
                padding: EdgeInsets.all(6.w),
              ),
              4.width,
            ],
            SizedBox(
              height: 28.h,
              child: Transform.scale(
                scale: 0.75,
                child: Switch.adaptive(
                  value: taxConfiguration.isEnabled,
                  onChanged: canManage ? onToggleEnabled : null,
                  activeTrackColor: canManage
                      ? AppColors.purple
                      : AppColors.grey600,
                ),
              ),
            ),
          ],
        ),
        10.height,
        Wrap(
          spacing: 8.w,
          runSpacing: 8.h,
          children: taxConfiguration.taxableComponents
              .map((c) => _ComponentBadge(label: c.label))
              .toList(),
        ),
      ],
    ),
  );
}

class _ComponentBadge extends StatelessWidget {
  const _ComponentBadge({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) => Container(
    padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
    decoration: BoxDecoration(
      color: AppColors.grey100,
      borderRadius: 20.radiusBorder,
    ),
    child: Text(
      label,
      style: TextStyle(
        fontSize: 15.sp,
        fontWeight: FontWeight.w500,
        color: AppColors.grey700,
      ),
    ),
  );
}
