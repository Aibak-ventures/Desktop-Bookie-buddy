// ignore_for_file: library_private_types_in_public_api
import 'package:bookie_buddy_web/core/extensions/context_extensions.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:bookie_buddy_web/core/ui/widgets/custom_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalenderWidget extends StatefulWidget {
  final Function(DateTime selectedDate) onDateSelected;
  final DateTime? initialSelectedDate; // Single initial selected date

  const CalenderWidget({
    required this.onDateSelected,
    super.key,
    this.initialSelectedDate,
  });

  @override
  _CalenderWidgetState createState() => _CalenderWidgetState();
}

class _CalenderWidgetState extends State<CalenderWidget> {
  DateTime? selectedDate;
  DateTime? focusedDay;

  @override
  void initState() {
    super.initState();
    final DateTime currentDate = DateTime.now();
    final DateTime firstAvailableDay = DateTime(
      currentDate.year,
      currentDate.month,
      currentDate.day,
    );

    if (widget.initialSelectedDate != null) {
      selectedDate = widget.initialSelectedDate;
      focusedDay = selectedDate;
    } else {
      selectedDate = firstAvailableDay;
      focusedDay = firstAvailableDay;
    }
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    final DateTime today = DateTime.now();
    print('selected: ' + selectedDay.toString());
    if (selectedDay.isBefore(widget.initialSelectedDate ??
        DateTime(today.year, today.month, today.day))) {
      CustomSnackBar(message: 'You cannot select a past date');
      return; // Don't allow past dates
    }

    setState(() {
      selectedDate =
          DateTime(selectedDay.year, selectedDay.month, selectedDay.day);
      this.focusedDay = focusedDay;
    });

    widget.onDateSelected(selectedDate!);
  }

  @override
  Widget build(BuildContext context) {
    final DateTime currentDate = DateTime.now();

    return Scaffold(
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: AppColors.purple,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: TableCalendar(
            availableGestures: AvailableGestures.none,
            rowHeight: context.mediaQueryHeight(0.065),
            firstDay: widget.initialSelectedDate ?? DateTime.now(),
            lastDay: DateTime.utc(
              currentDate.year + 200,
              12,
              31,
            ),
            focusedDay: focusedDay ?? currentDate,
            calendarStyle: const CalendarStyle(
              todayTextStyle: TextStyle(
                color: AppColors.green,
              ),
              todayDecoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.fromBorderSide(
                  BorderSide(color: AppColors.green),
                ),
              ),
              selectedDecoration: BoxDecoration(
                color: AppColors.purple, // Wine color for selected date
                shape: BoxShape.circle,
              ),
              outsideDaysVisible: false,
            ),
            selectedDayPredicate: (day) {
              return selectedDate != null &&
                  selectedDate!.year == day.year &&
                  selectedDate!.month == day.month &&
                  selectedDate!.day == day.day;
            },
            onDaySelected: _onDaySelected,
            headerStyle: const HeaderStyle(
              formatButtonVisible: false,
            ),
          ),
        ),
      ),
    );
  }
}
