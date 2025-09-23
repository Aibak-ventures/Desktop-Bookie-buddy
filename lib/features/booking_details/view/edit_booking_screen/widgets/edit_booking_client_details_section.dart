import 'package:bookie_buddy_web/core/app_input_validators.dart';
import 'package:bookie_buddy_web/core/ui/widgets/custom_textfield.dart';
import 'package:bookie_buddy_web/features/booking_details/view/edit_booking_screen/widgets/edit_booking_section_column.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EditBookingClientDetailsSection extends StatelessWidget {
  const EditBookingClientDetailsSection({
    super.key,
    required this.clientNameController,
    required this.clientPhone1Controller,
    required this.clientPhone2Controller,
    required this.clientAddressController,
  });

  final TextEditingController clientNameController;
  final TextEditingController clientPhone1Controller;
  final TextEditingController clientPhone2Controller;
  final TextEditingController clientAddressController;

  @override
  Widget build(BuildContext context) {
    return EditBookingSectionColumn(
      title: 'Client Details',
      child: Column(
        spacing: 15.w,
        children: [
          CustomTextField(
            controller: clientNameController,
            validator: AppInputValidators.name,
            label: 'Name',
          ),
          CustomTextField(
            controller: clientPhone1Controller,
            maxLengths: 10,
            validator: AppInputValidators.phoneNumber,
            label: 'Phone number 1',
            keyboardType: TextInputType.phone,
          ),
          CustomTextField(
            controller: clientPhone2Controller,
            maxLengths: 10,
            validator: (value) => AppInputValidators.isEmpty(value)
                ? null
                : AppInputValidators.phoneNumber(value),
            label: 'Phone number 2',
            keyboardType: TextInputType.phone,
          ),
          CustomTextField(
            controller: clientAddressController,
            validator: AppInputValidators.address,
            label: 'Place',
          ),
        ],
      ),
    );
  }
}
