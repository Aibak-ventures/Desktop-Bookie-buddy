import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:bookie_buddy_web/core/common/widgets/custom_sized_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomErrorWidget extends StatelessWidget {
  const CustomErrorWidget({
    required this.errorText,
    super.key,
    this.icon,
    this.onRetry,
    this.showIcon = true,
    this.showRetry = true,
    this.height,
  });

  final String errorText;
  final Icon? icon;
  final VoidCallback? onRetry;
  final bool showIcon;
  final bool showRetry;

  /// height should be between 0 to 1
  final double? height;

  @override
  Widget build(BuildContext context) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min, // Adjusts to content
          children: [
            if (height != null) CustomSizedBoxHeight(height!),
            if (showIcon)
              icon ??
                  const Icon(
                    Icons.error_outline,
                    size: 48,
                    color: Colors.grey,
                  ),
            const SizedBox(height: 12),
            Text(
              errorText,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16.sp,
                color: Colors.black87,
              ),
            ),
            if (showRetry) ...[
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: onRetry,
                icon: const Icon(
                  Icons.refresh,
                  color: AppColors.white,
                ),
                label: const Text(
                  'Retry',
                  style: TextStyle(
                    color: AppColors.white,
                  ),
                ),
              ),
            ],
          ],
        ),
      );
}
