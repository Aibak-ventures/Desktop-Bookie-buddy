// ignore_for_file: library_private_types_in_public_api
import 'package:bookie_buddy_web/core/extensions/context_extensions.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalenderWidget extends StatefulWidget {
  final Function(DateTime startDate, DateTime endDate) onDateRangeSelected;
  final DateTime? firstDate;

  const CalenderWidget({
    super.key,
    required this.onDateRangeSelected,
    this.firstDate,
  });

  @override
  _CalenderWidgetState createState() => _CalenderWidgetState();
}

class _CalenderWidgetState extends State<CalenderWidget> {
  DateTime? rangeStart;
  DateTime? rangeEnd;
  DateTime focusedDay = DateTime.now();

  @override
  void initState() {
    super.initState();
    rangeStart = widget.firstDate ?? DateTime.now();
    focusedDay = rangeStart!;
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: AppColors.purple, width: 2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: SizedBox(
        width: context.mediaQueryWidth(0.23),
        height: context.mediaQueryHeight(0.32),
        child: TableCalendar(
          rangeSelectionMode: RangeSelectionMode.enforced,
          rangeStartDay: rangeStart,
          rangeEndDay: rangeEnd,
          availableGestures: AvailableGestures.none,
          rowHeight: context.mediaQueryHeight(0.045),
          firstDay: widget.firstDate ?? DateTime.now(),
          lastDay: DateTime.utc(DateTime.now().year + 5, 12, 31),
          focusedDay: focusedDay,
          onRangeSelected: (start, end, focused) {
            if (start != null && end != null) {
              setState(() {
                rangeStart = start;
                rangeEnd = end;
                focusedDay = focused;
              });
              widget.onDateRangeSelected(start, end);
            }
          },
          calendarStyle: const CalendarStyle(
            outsideDaysVisible: false,
            todayTextStyle: TextStyle(color: AppColors.green, fontSize: 11),
            rangeStartDecoration: BoxDecoration(color: AppColors.purple, shape: BoxShape.circle),
            rangeEndDecoration: BoxDecoration(color: AppColors.purple, shape: BoxShape.circle),
            withinRangeDecoration: BoxDecoration(color: AppColors.purpleLight, shape: BoxShape.circle),
          ),
          headerStyle: const HeaderStyle(
            formatButtonVisible: false,
            titleCentered: true,
            titleTextStyle: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
          ),
          daysOfWeekStyle: const DaysOfWeekStyle(
            weekdayStyle: TextStyle(fontSize: 10),
            weekendStyle: TextStyle(fontSize: 10),
          ),
        ),
      ),
    );
  }
}
