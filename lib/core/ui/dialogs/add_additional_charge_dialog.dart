import 'package:bookie_buddy_web/core/app_input_validators.dart';
import 'package:bookie_buddy_web/core/extensions/context_extensions.dart';
import 'package:bookie_buddy_web/core/extensions/number_extensions.dart';
import 'package:bookie_buddy_web/core/extensions/string_extensions.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:bookie_buddy_web/core/ui/widgets/custom_textfield.dart';
import 'package:bookie_buddy_web/features/add_booking/models/additional_charges_model/additional_charges_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void showAddAdditionalChargeDialog({
  required BuildContext context,
  required ValueNotifier<List<AdditionalChargesModel>>
      additionalChargesNotifier,
  AdditionalChargesModel? existingCharge,
}) {
  showDialog(
    context: context,
    builder: (BuildContext context) => AddAdditionalChargeDialog(
      additionalChargesNotifier: additionalChargesNotifier,
      existingCharge: existingCharge,
    ),
  );
}

class AddAdditionalChargeDialog extends StatefulWidget {
  const AddAdditionalChargeDialog({
    super.key,
    required this.additionalChargesNotifier,
    this.existingCharge,
  });

  final ValueNotifier<List<AdditionalChargesModel>> additionalChargesNotifier;
  final AdditionalChargesModel? existingCharge;

  @override
  State<AddAdditionalChargeDialog> createState() =>
      _AddAdditionalChargeDialogState();
}

class _AddAdditionalChargeDialogState extends State<AddAdditionalChargeDialog> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController titleController;
  late final TextEditingController amountController;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(
      text: widget.existingCharge?.name ?? '',
    );
    amountController = TextEditingController(
      text: widget.existingCharge?.amount?.toString() ?? '',
    );
  }

  @override
  void dispose() {
    super.dispose();
    titleController.dispose();
    amountController.dispose();
  }

  void _submit([bool closeAfterAdd = true]) {
    if (_formKey.currentState?.validate() != true) return;
    final title = titleController.text.trim();
    final amount = amountController.text.trim().toIntOrNull() ?? 0;
    if (title.isEmpty || amount <= 0) {
      // Show error
      return;
    }
    if (widget.existingCharge != null) {
      widget.additionalChargesNotifier.value = widget
          .additionalChargesNotifier.value
          .map(
            (e) => e.id == widget.existingCharge?.id
                ? widget.existingCharge!.copyWith(name: title, amount: amount)
                : e,
          )
          .toList();
    } else {
      widget.additionalChargesNotifier.value = [
        AdditionalChargesModel(name: title, amount: amount),
        ...widget.additionalChargesNotifier.value,
      ];
    }
    if (closeAfterAdd) {
      context.pop(); // Close the dialog
    } else {
      titleController.clear();
      amountController.clear();
    }
  }

  @override
  Widget build(BuildContext context) => AlertDialog(
        title: const Text('Add Additional Charge'),
        content: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomTextField(
                controller: titleController,
                validator: (value) =>
                    AppInputValidators.basicText(value, fieldName: 'Name'),
                label: 'Service name',
                textInputAction: TextInputAction.next,
                autofocus: true,
              ),
              10.height,
              CustomTextField(
                controller: amountController,
                validator: (value) => AppInputValidators.amount(value),
                keyboardType: TextInputType.number,
                textInputFormatter: [
                  FilteringTextInputFormatter.digitsOnly, // Only allow digits
                ],
                label: 'Amount',
                onFieldSubmit: (value) {
                  _submit();
                },
                textInputAction: TextInputAction.done,
              ),
            ],
          ),
        ),
        scrollable: true,
        actions: [
          if (widget.existingCharge == null)
            TextButton(
              onPressed: () => _submit(false),
              child: const Text('Add more',
                  style: TextStyle(color: AppColors.white)),
            )
          else
            TextButton(
              child: const Text('Cancel',
                  style: TextStyle(color: AppColors.black)),
              onPressed: () {
                context.pop(); // Close the dialog
              },
            ),
          ElevatedButton(
            onPressed: () => _submit(),
            child: Text(
              widget.existingCharge != null ? 'Save' : 'Done',
              style: const TextStyle(color: AppColors.white),
            ),
          ),
        ],
      );
}
