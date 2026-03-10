import 'package:bookie_buddy_web/utils/app_input_validators.dart';
import 'package:bookie_buddy_web/utils/extensions/context_extensions.dart';
import 'package:bookie_buddy_web/utils/extensions/number_extensions.dart';
import 'package:bookie_buddy_web/utils/extensions/string_extensions.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:bookie_buddy_web/core/ui/widgets/custom_textfield.dart';
import 'package:bookie_buddy_web/features/add_booking/models/measurement_value_model/measurement_value_model.dart';
import 'package:flutter/material.dart';

Future<MeasurementValueModel?> showVehicleCustomizationDialog(
  BuildContext context,
  MeasurementValueModel? initialValue,
) {
  final controller = TextEditingController(
      text: initialValue?.value.replaceAll('Km', '').trim());
  return showDialog<MeasurementValueModel>(
    context: context,
    builder: (dialogCtx) => AlertDialog(
      title: const Text('Add Details'),
      content: SizedBox(
        width: context.isMobile ? null : 0.5.widthR,
        child: Row(
          children: [
            Expanded(
              child: CustomTextField(
                controller: controller,
                hintText: 'Eg: 1000 or 2800',
                validator: AppInputValidators.numberOnly,
                keyboardType: TextInputType.number,
              ),
            ),
            16.width,
            const Text('Km'),
          ],
        ),
      ),
      actions: [
        TextButton(
          child: const Text(
            'Cancel',
          ),
          onPressed: () {
            dialogCtx.pop(); // Close the dialog
          },
        ),
        ElevatedButton(
          child: const Text(
            'Confirm',
            style: TextStyle(color: AppColors.white),
          ),
          onPressed: () {
            final km = controller.text.trim().toIntOrNull();
            if (km != null) {
              final result = MeasurementValueModel(
                name: 'Running Kilometers',
                key: 'km',
                value: '$km Km',
              );
              dialogCtx.pop(result); // Close the dialog
            }
          },
        ),
      ],
    ),
  );
}
