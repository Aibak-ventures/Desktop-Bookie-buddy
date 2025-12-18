import 'package:bookie_buddy_web/core/extensions/context_extensions.dart';
import 'package:bookie_buddy_web/core/models/date_filter_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomEmptyFilterStateWidget extends StatelessWidget {
  const CustomEmptyFilterStateWidget({
    super.key,
    required this.dataText,
    required this.dateFilterNotifier,
    required this.onClearFilter,
    this.heightR = 0.3,
  });

  final String dataText;
  final ValueNotifier<DateFilterModel> dateFilterNotifier;
  final void Function(BuildContext ctx) onClearFilter;
  final double heightR;
  @override
  Widget build(BuildContext context) => ListView(
    physics: const AlwaysScrollableScrollPhysics(),
    children: [
      SizedBox(height: context.screenHeight * heightR),
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.task_alt_outlined, size: 64, color: Colors.grey.shade400),
          const SizedBox(height: 16),
          Text(
            dateFilterNotifier.value.hasActiveFilter
                ? 'No $dataText found for selected dates'
                : 'No $dataText found',
            style: TextStyle(
              fontSize: 16.sp,
              color: Colors.grey.shade600,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
          if (dateFilterNotifier.value.hasActiveFilter) ...[
            const SizedBox(height: 8),
            TextButton(
              onPressed: () => onClearFilter(context),
              child: Text('Clear filter to see all $dataText'),
            ),
          ],
        ],
      ),
    ],
  );
}
