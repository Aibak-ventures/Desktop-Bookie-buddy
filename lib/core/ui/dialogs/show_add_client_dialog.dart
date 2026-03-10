import 'package:bookie_buddy_web/core/app_input_validators.dart';
import 'package:bookie_buddy_web/utils/extensions/context_extensions.dart';
import 'package:bookie_buddy_web/utils/extensions/number_extensions.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:bookie_buddy_web/core/ui/widgets/custom_textfield.dart';
import 'package:bookie_buddy_web/features/add_booking/models/client_model/client_model.dart';
import 'package:flutter/material.dart';

Future<ClientModel?> showAddClientDialog({
  required BuildContext context,
  required void Function(
    BuildContext dialogContext,
    String name,
    String phone1,
    String phone2,
  ) onPressed,
  ClientModel? client,
}) async {
  final nameController = TextEditingController(text: client?.name ?? '');
  final phone1Controller =
      TextEditingController(text: client?.phone1.toString() ?? '');
  final phone2Controller =
      TextEditingController(text: client?.phone2?.toString() ?? '');
  final _formKey = GlobalKey<FormState>();
  return showDialog<ClientModel>(
    context: context,
    builder: (dialogContext) => AlertDialog(
      title: const Text('Add Client'),
      content: SizedBox(
        width: context.isMobile ? null : 0.5.widthR,
        child: Form(
          key: _formKey,
          child: Column(
            spacing: 15,
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomTextField(
                controller: nameController,
                label: 'Client Name',
                validator: AppInputValidators.name,
              ),
              CustomTextField(
                validator: (value) => AppInputValidators.isEmpty(value)
                    ? 'Please enter a phone number'
                    : null,
                controller: phone1Controller,
                label: 'Phone Number 1',
              ),
              CustomTextField(
                validator: (value) =>
                    AppInputValidators.isEmpty(value) ? null : null,
                controller: phone2Controller,
                label: 'Phone Number 2',
              )
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => dialogContext.pop(),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          child: Text(
            client != null ? 'Save' : 'Add',
            style: const TextStyle(
              color: AppColors.white,
            ),
          ),
          onPressed: () {
            if (!_formKey.currentState!.validate()) {
              return;
            }
            onPressed(
              dialogContext,
              nameController.text.trim(),
              phone1Controller.text.trim(),
              phone2Controller.text.trim(),
            );
          },
        ),
      ],
    ),
  );
}
