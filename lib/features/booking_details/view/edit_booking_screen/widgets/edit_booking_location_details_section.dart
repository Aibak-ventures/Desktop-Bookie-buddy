import 'package:bookie_buddy_web/core/app_input_validators.dart';
import 'package:bookie_buddy_web/core/ui/widgets/custom_textfield.dart';
import 'package:bookie_buddy_web/features/booking_details/view/edit_booking_screen/widgets/edit_booking_section_column.dart';
import 'package:flutter/material.dart';

class EditBookingLocationDetailsSection extends StatelessWidget {
  const EditBookingLocationDetailsSection({
    super.key,
    required this.locationStartController,
    required this.locationFromController,
    required this.locationToController,
  });

  final TextEditingController locationStartController;
  final TextEditingController locationFromController;
  final TextEditingController locationToController;

  @override
  Widget build(BuildContext context) => EditBookingSectionColumn(
        title: 'Location Details',
        child: Column(
          spacing: 15,
          children: [
            CustomTextField(
              controller: locationStartController,
              validator: (value) => AppInputValidators.basicText(
                value,
                isRequired: false,
                fieldName: 'Start Location',
              ),
              label: 'Start Location',
              hintText: 'Location',
            ),
            CustomTextField(
              controller: locationFromController,
              validator: (value) => AppInputValidators.basicText(
                value,
                isRequired: false,
                fieldName: 'Pickup Location',
              ),
              label: 'Pickup Location',
              hintText: 'Location',
            ),
            CustomTextField(
              controller: locationToController,
              validator: (value) => AppInputValidators.basicText(
                value,
                isRequired: false,
                fieldName: 'Destination',
              ),
              label: 'Destination',
              hintText: 'Location',
            ),
          ],
        ),
      );
}
