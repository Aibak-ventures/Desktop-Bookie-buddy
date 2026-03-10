import 'package:bookie_buddy_web/core/app_input_validators.dart';
import 'package:bookie_buddy_web/utils/extensions/date_time_extensions.dart';
import 'package:bookie_buddy_web/utils/extensions/number_extensions.dart';
import 'package:bookie_buddy_web/utils/extensions/string_extensions.dart';
import 'package:bookie_buddy_web/utils/extensions/widget_extensions.dart';
import 'package:bookie_buddy_web/core/ui/widgets/custom_textfield.dart';
import 'package:bookie_buddy_web/features/add_old_booking/view/widgets/add_old_booking_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddOldBookingDatesSection extends StatelessWidget {
  const AddOldBookingDatesSection({
    super.key,
    required this.bookedDateController,
    required this.pickUpDateController,
    required this.returnDateController,
  });

  final TextEditingController bookedDateController;
  final TextEditingController pickUpDateController;
  final TextEditingController returnDateController;

// booked date function
  Future<void> selectBookedDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: bookedDateController.text.isEmpty
          ? DateTime.now()
          : bookedDateController.text.parseToDateTime(),
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      bookedDateController.text = picked.format();
    }
  }

// pickup date function
  Future<void> selectPickupDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: pickUpDateController.text.isEmpty
          ? DateTime.now()
          : pickUpDateController.text.parseToDateTime(),
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      pickUpDateController.text = picked.format();
      if (returnDateController.text.isNotEmpty &&
          returnDateController.text.parseToDateTime().isBefore(picked)) {
        returnDateController.text = picked.add(1.days()).format();
      }
    }
  }

  // return date function
  Future<void> selectReturnDate(BuildContext context) async {
    final firstDate = pickUpDateController.text.isEmpty
        ? DateTime.now()
        : pickUpDateController.text.parseToDateTime();
    final initialDate = returnDateController.text.isEmpty
        ? DateTime.now()
        : returnDateController.text.parseToDateTime();
    final DateTime? picked = await showDatePicker(
      context: context,
      firstDate: firstDate,
      initialDate: firstDate.isAfter(initialDate) ? firstDate : initialDate,
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );

    if (picked != null) {
      returnDateController.text = picked.format();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AddOldBookingSection(
      title: 'Dates',
      child: Column(
        spacing: 15.w,
        children: [
          Stack(
            alignment: Alignment.centerRight,
            children: [
              CustomTextField(
                ignorePointers: true,
                controller: bookedDateController,
                keyboardType: TextInputType.datetime,
                validator: (value) => null,
                hintText: 'Select Booked Date',
                label: "Booked Date (Optional)",
              ).onTap(() => selectBookedDate(context)),
              ValueListenableBuilder(
                  valueListenable: bookedDateController,
                  builder: (context, value, child) {
                    return Visibility(
                      visible: bookedDateController.text.isNotEmpty,
                      child: IconButton(
                        icon: const Icon(Icons.clear, color: Colors.grey),
                        onPressed: bookedDateController.clear,
                      ),
                    );
                  }),
            ],
          ),
          CustomTextField(
            ignorePointers: true,
            controller: pickUpDateController,
            keyboardType: TextInputType.datetime,
            validator: (value) => AppInputValidators.isEmpty(value)
                ? 'Please select a pickup date'
                : null,
            hintText: 'Select Pickup Date',
            label: "Pickup Date",
          ).onTap(
            () => selectPickupDate(context),
          ),
          CustomTextField(
            ignorePointers: true,
            controller: returnDateController,
            keyboardType: TextInputType.datetime,
            validator: (value) => AppInputValidators.isEmpty(value)
                ? 'Please select a return date'
                : null,
            hintText: 'Select Return Date',
            label: "Return Date",
          ).onTap(
            () => selectReturnDate(context),
          ),
        ],
      ),
    );
  }
}
