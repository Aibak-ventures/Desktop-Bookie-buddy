import 'package:bookie_buddy_web/utils/extensions/widget_extensions.dart';
import 'package:bookie_buddy_web/core/common/widgets/custom_textfield.dart';
import 'package:bookie_buddy_web/features/booking/presentation/edit_booking/controller/edit_booking_form_state_controller.dart';
import 'package:bookie_buddy_web/features/booking/presentation/edit_booking/widgets/edit_booking_section_column.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EditBookingDateSection extends StatelessWidget {
  const EditBookingDateSection({
    super.key,
    required EditBookingFormStateController formController,
  }) : _formController = formController;

  final EditBookingFormStateController _formController;

  @override
  Widget build(BuildContext context) => EditBookingSectionColumn(
        title: 'Dates',
        child: Column(
          spacing: 15.w,
          children: [
            CustomTextField(
              ignorePointers: true,
              controller: _formController.pickUpdDateController,
              keyboardType: TextInputType.datetime,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please select a pickup date';
                }
                return null;
              },
              hintText: 'Select Pickup Date',
              label: 'Pickup Date',
            ).onTap(
              () => _formController.selectPickupDate(
                context: context,
                // setState: setState,
              ),
            ),
            CustomTextField(
              ignorePointers: true,
              controller: _formController.returnDateController,
              keyboardType: TextInputType.datetime,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please select a return date';
                }
                return null;
              },
              hintText: 'Select Return Date',
              label: 'Return Date',
            ).onTap(
              () => _formController.selectReturnDate(
                context: context,
                // setState: setState,
              ),
            ),
            CustomTextField(
              ignorePointers: true,
              controller: _formController.coolingPeriodDateController,
              keyboardType: TextInputType.datetime,
              validator: (value) => null,
              hintText: 'Select Cooling Period Date',
              label: 'Cooling Period Date',
            ).onTap(() => _formController.selectCoolingPeriodDate(context)),
          ],
        ),
      );
}
