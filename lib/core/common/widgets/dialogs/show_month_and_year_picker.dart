import 'package:bookie_buddy_web/core/constants/enums/enums.dart';
import 'package:bookie_buddy_web/utils/extensions/context_extensions.dart';
import 'package:bookie_buddy_web/utils/extensions/number_extensions.dart';
import 'package:bookie_buddy_web/core/common/widgets/custom_normal_elevated_button.dart';
import 'package:flutter/material.dart';

Future<void> showMonthAndYearPicker({
  required BuildContext context,
  required Function(int selectedMonth, int selectedYear) onDateSelected,
  DateTime? initialDate,
}) async {
  initialDate ??= DateTime.now();
  var selectedMonth = initialDate.month;
  var selectedYear = initialDate.year;
  await showDialog(
    context: context,

    // fullscreenDialog: true,
    builder: (context) => AlertDialog(
      insetPadding: const EdgeInsets.all(10),
      title: const Text('Select Month and Year'),
      // contentPadding: 0.padding,
      content: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          DropdownMenu(
            dropdownMenuEntries: Month.values
                .map(
                  (month) => DropdownMenuEntry(
                    value: month.number,
                    label: month.value,
                  ),
                )
                .toList(),
            initialSelection: selectedMonth,
            onSelected: (month) {
              if (month != null) selectedMonth = month;
            },
          ),
          5.width,
          DropdownMenu(
            dropdownMenuEntries: List.generate(20, (index) => 2010 + index)
                .map(
                  (year) =>
                      DropdownMenuEntry(value: year, label: year.toString()),
                )
                .toList(),
            initialSelection: selectedYear,
            onSelected: (year) {
              if (year != null) selectedYear = year;
            },
          ),
        ],
      ),
      actions: [
        TextButton(onPressed: () => context.pop(), child: const Text('Cancel')),
        CustomNormalElevatedButton(
          text: 'Select',
          onPressed: () {
            context.pop();
            onDateSelected(selectedMonth, selectedYear);
          },
        ),
      ],
    ),
  );
}
