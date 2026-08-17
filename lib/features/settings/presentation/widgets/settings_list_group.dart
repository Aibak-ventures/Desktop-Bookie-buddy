import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:bookie_buddy_web/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

class SettingsListGroup extends StatelessWidget {
  const SettingsListGroup({required this.title, required this.children});

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 10),
          child: Text(
            title.toUpperCase(),
            style: AppTextStyles.subheading.copyWith(
              color: AppColors.grey600,
              letterSpacing: 0.6,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: AppColors.greyBorder),
            boxShadow: [AppColors.softShadow],
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: [
              for (var i = 0; i < children.length; i++) ...[
                if (i > 0) Divider(height: 1, color: AppColors.greyBorder),
                children[i],
              ],
            ],
          ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}
