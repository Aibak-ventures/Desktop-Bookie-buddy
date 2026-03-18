// import 'package:bookie_buddy_web/core/extensions/color_extensions.dart';
import 'package:bookie_buddy_web/utils/extensions/number_extensions.dart';
import 'package:bookie_buddy_web/core/models/date_filter_model.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomActiveFilterIndicator extends StatelessWidget {
  const CustomActiveFilterIndicator({
    super.key,
    required this.dateFilterNotifier,
    required this.onClearFilter,
    this.padding,
  });

  final ValueNotifier<DateFilterModel> dateFilterNotifier;
  final void Function(BuildContext ctx) onClearFilter;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) => Container(
        margin: padding ?? (16, 8).padding,
        padding: (12, 8).padding,
        decoration: BoxDecoration(
          color: AppColors.purple,
          borderRadius: 8.radiusBorder,
          border: Border.all(color: AppColors.purple),
        ),
        child: Row(
          children: [
            const Icon(Icons.filter_list, size: 16, color: AppColors.purple),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                dateFilterNotifier.value.getFilterDisplayText,
                style: TextStyle(
                  fontSize: 12.sp,
                  color: AppColors.purple,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            GestureDetector(
              onTap: () => onClearFilter(context),
              child: Container(
                padding: 2.padding,
                decoration: BoxDecoration(
                  color: AppColors.purple.withValues(alpha: 0.2),
                  shape: BoxShape.circle,
                ),
                child:
                    const Icon(Icons.close, size: 14, color: AppColors.purple),
              ),
            ),
          ],
        ),
      );
}
