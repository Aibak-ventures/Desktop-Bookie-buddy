import 'package:bookie_buddy_web/utils/extensions/context_extensions.dart';
import 'package:bookie_buddy_web/core/models/date_filter_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AllBookingEmptyWidget extends StatelessWidget {
  final ValueNotifier<DateFilterModel> dateFilterNotifier;
  final VoidCallback onClearButtonPressed;
  const AllBookingEmptyWidget({
    super.key,
    required this.dateFilterNotifier,
    required this.onClearButtonPressed,
  });

  @override
  Widget build(BuildContext context) => ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        children: [
          SizedBox(height: context.screenHeight * 0.3),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.calendar_today_outlined,
                size: 64,
                color: Colors.grey.shade400,
              ),
              const SizedBox(height: 16),
              Text(
                dateFilterNotifier.value.hasActiveFilter
                    ? 'No bookings found for selected dates'
                    : 'No bookings',
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
                  onPressed: onClearButtonPressed,
                  child: const Text('Clear filter to see all bookings'),
                ),
              ],
            ],
          ),
        ],
      );
}
