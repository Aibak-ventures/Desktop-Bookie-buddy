import 'package:bookie_buddy_web/utils/extensions/number_extensions.dart';
import 'package:bookie_buddy_web/utils/extensions/string_extensions.dart';
import 'package:bookie_buddy_web/utils/extensions/widget_extensions.dart';
import 'package:bookie_buddy_web/core/common/widgets/dialogs/show_month_and_year_picker.dart';
import 'package:bookie_buddy_web/features/all_shop_summary/view_models/cubit_all_shop_summary/all_shop_summary_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class AllShopSummaryAppBarDateChangeButton extends StatelessWidget {
  const AllShopSummaryAppBarDateChangeButton({
    super.key,
    required this.selectedDate,
    this.canDateChange = true,
  });
  final String selectedDate;
  final bool canDateChange;

  @override
  Widget build(BuildContext context) {
    final date = DateFormat('MMM yyyy').format(selectedDate.parseToDateTime());
    return Container(
      padding: (12, 6).padding,
      decoration: BoxDecoration(
        borderRadius: 16.radiusBorder,
        border: Border.all(color: Colors.grey, width: 0.4),
      ),
      child: Row(
        children: [
          Icon(Icons.calendar_month_outlined, size: 17.sp),
          8.width,
          Text(
            date,
            style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
          ),
          if (canDateChange) ...[
            4.width,
            Icon(Icons.keyboard_arrow_down, size: 20.sp),
          ],
        ],
      ),
    ).onTap(() {
      if (!canDateChange) return;
      final cubit = context.read<AllShopSummaryCubit>();
      showMonthAndYearPicker(
        context: context,
        initialDate: cubit.selectedDate,
        // lastDate: DateTime.now(),
        onDateSelected: (selectedMonth, selectedYear) {
          cubit
            ..updateSelectedDate(DateTime(selectedYear, selectedMonth))
            ..fetchAllShopSummary(year: selectedYear, month: selectedMonth);
        },
      );
    });
  }
}
