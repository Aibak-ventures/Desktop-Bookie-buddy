import 'package:bookie_buddy_web/utils/extensions/context_extensions.dart';
import 'package:bookie_buddy_web/utils/extensions/date_time_extensions.dart';
import 'package:bookie_buddy_web/utils/extensions/string_extensions.dart';
import 'package:bookie_buddy_web/utils/extensions/widget_extensions.dart';
import 'package:bookie_buddy_web/core/ui/widgets/custom_textfield.dart';
import 'package:bookie_buddy_web/features/booking_details/view/edit_booking_screen/controller/edit_booking_form_state_controller.dart';
import 'package:bookie_buddy_web/features/booking_details/view/edit_booking_screen/widgets/edit_booking_section_column.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EditBookingTimeSection extends StatelessWidget {
  const EditBookingTimeSection({
    super.key,
    required EditBookingFormStateController formController,
  }) : _formController = formController;

  final EditBookingFormStateController _formController;

  @override
  Widget build(BuildContext context) => EditBookingSectionColumn(
        title: 'Times',
        child: Column(
          spacing: 15.w,
          children: [
            CustomTextField(
              controller: _formController.pickupTimeController,
              label: 'Pickup Time',
              hintText: 'Select Pickup Time',
              ignorePointers: true,
              prefixIcon: const Icon(Icons.access_time),
              validator: null,
            ).onTap(() async {
              // if (_formController.isPickupDateBeforeCurrentDate) {
              //   return;
              // }

              final picked = await showTimePicker(
                context: context,
                initialTime: _formController.pickupTime,
                builder: (context, child) => MediaQuery(
                  data: MediaQuery.of(
                    context,
                  ).copyWith(alwaysUse24HourFormat: false),
                  child: child!,
                ),
              );
              if (picked != null) {
                // If pickup date is today, ensure pickup time is after current time
                if (_formController.pickUpdDateController.text
                        .parseToDateTime()
                        .isSameDay(DateTime.now()) &&
                    picked.isBefore(TimeOfDay.now())) {
                  context.showSnackBar(
                    'Pickup time must be after current time',
                    title: 'Time Error',
                    isError: true,
                  );
                  return;
                }
                if (_formController.isReturnAndPickupSameDay(
                      _formController.pickUpdDateController.text
                          .parseToDateTime(),
                      _formController.returnDateController.text
                          .parseToDateTime(),
                    ) &&
                    // Disallow equal or after
                    !picked.isBefore(_formController.returnTime)) {
                  // Invalid pickup time
                  context.showSnackBar(
                    'Pickup time must be before return time',
                    title: 'Time Error',
                    isError: true,
                  );
                  return;
                }
                _formController.pickupTime = picked;
                _formController.pickupTimeController.text =
                    picked.formatTime12Hour();
              }
            }),
            CustomTextField(
              controller: _formController.returnTimeController,
              label: 'Return Time',
              hintText: 'Select Return Time',
              ignorePointers: true,
              prefixIcon: const Icon(Icons.access_time),
              validator: null,
            ).onTap(() async {
              final picked = await showTimePicker(
                context: context,
                initialTime: _formController.returnTime,
                builder: (context, child) => MediaQuery(
                  data: MediaQuery.of(
                    context,
                  ).copyWith(alwaysUse24HourFormat: false),
                  child: child!,
                ),
              );
              if (picked != null) {
                // If return date is today, ensure return time is after current time
                if (_formController.returnDateController.text
                        .parseToDateTime()
                        .isSameDay(DateTime.now()) &&
                    picked.isBefore(TimeOfDay.now())) {
                  context.showSnackBar(
                    'Return time must be after current time',
                    title: 'Time Error',
                    isError: true,
                  );
                  return;
                }
                if (_formController.isReturnAndPickupSameDay(
                      _formController.pickUpdDateController.text
                          .parseToDateTime(),
                      _formController.returnDateController.text
                          .parseToDateTime(),
                    ) &&
                    // Disallow equal or before
                    !picked.isAfter(_formController.pickupTime)) {
                  context.showSnackBar(
                    'Return time must be after pickup time',
                    title: 'Time Error',
                    isError: true,
                  );
                  return;
                }
                _formController.returnTime = picked;
                _formController.returnTimeController.text =
                    picked.formatTime12Hour();
              }
            }),
          ],
        ),
      );
}
