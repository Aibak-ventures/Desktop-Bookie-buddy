import 'package:bookie_buddy_web/core/extensions/number_extensions.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:bookie_buddy_web/features/add_booking/models/measurement_value_model/measurement_value_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomizationExpansionTile extends StatelessWidget {
  const CustomizationExpansionTile({
    required this.measurements,
    this.expansionTitle,
    this.isButtonVisible = true,
    this.onButtonTap,
    this.trailingWidget,
    super.key,
  });

  final String? expansionTitle;
  final List<MeasurementValueModel> measurements;
  final VoidCallback? onButtonTap;
  final bool isButtonVisible;
  final Widget? trailingWidget;
  @override
  Widget build(BuildContext context) => ExpansionTile(
      title: Text(
        expansionTitle ?? 'Customisation',
        style: TextStyle(
          fontSize: 14.sp,
          color: AppColors.grey600,
          fontStyle: FontStyle.italic,
        ),
      ),
      backgroundColor: AppColors.white,
      shape: Border.all(color: AppColors.white),
      children: [
        if (measurements.isNotEmpty)
          Padding(
            padding: (20, 10).padding,
            child: Column(
              children: measurements.map((e) => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Flexible(
                      child: Text(
                        e.name,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: AppColors.black,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                    const Text(':  '),
                    Flexible(
                      child: Text(
                        e.value,
                        textAlign: TextAlign.left,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                  ],
                )).toList(),
            ),
          ),
        if (isButtonVisible)
          TextButton.icon(
            onPressed: onButtonTap,
            label: Text(
              measurements.isEmpty ? 'Add' : 'Edit',
            ),
            icon: Icon(
              measurements.isEmpty ? Icons.add : Icons.edit,
            ),
          ),
        if (trailingWidget != null) trailingWidget!,
      ],
    );
}
