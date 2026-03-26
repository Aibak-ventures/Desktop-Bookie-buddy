import 'package:bookie_buddy_web/core/constants/enums/service_type_enums.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:bookie_buddy_web/core/common/widgets/custom_textfield.dart';
import 'package:bookie_buddy_web/utils/app_input_validators.dart';
import 'package:flutter/material.dart';

/// Dynamic form fields for [AddEditProductDialog], tailored to the selected
/// [mainServiceType] (dress, jewellery, material, vehicle, gadgets, etc.).
class ProductDynamicFields extends StatelessWidget {
  final MainServiceType mainServiceType;
  final TextEditingController nameController;
  final TextEditingController stockController;
  final TextEditingController colorController;
  final TextEditingController modelController;
  final TextEditingController categoryController;
  final TextEditingController purchaseAmountController;
  final TextEditingController priceController;
  final TextEditingController salePriceController;
  final TextEditingController descriptionController;
  final TextEditingController lengthController;
  final TextEditingController fabricTypeController;
  final TextEditingController registrationNumberController;
  final TextEditingController pollutionExpiryController;
  final TextEditingController insuranceExpiryController;
  final TextEditingController fitnessExpiryController;

  const ProductDynamicFields({
    super.key,
    required this.mainServiceType,
    required this.nameController,
    required this.stockController,
    required this.colorController,
    required this.modelController,
    required this.categoryController,
    required this.purchaseAmountController,
    required this.priceController,
    required this.salePriceController,
    required this.descriptionController,
    required this.lengthController,
    required this.fabricTypeController,
    required this.registrationNumberController,
    required this.pollutionExpiryController,
    required this.insuranceExpiryController,
    required this.fitnessExpiryController,
  });

  @override
  Widget build(BuildContext context) {
    final commonFields = <Widget>[
      // Product Name
      SizedBox(
        width: 280,
        child: CustomTextField(
          label:
              '${mainServiceType.isVehicle ? 'Vehicle' : mainServiceType.isMaterial ? 'Material' : 'Product'} Name *',
          controller: nameController,
          validator: AppInputValidators.productName,
        ),
      ),
    ];

    if (mainServiceType.isDress || mainServiceType.isCostume) {
      commonFields.addAll([
        SizedBox(
          width: 280,
          child: CustomTextField(
            label: 'Purchase Amount (Optional)',
            controller: purchaseAmountController,
            keyboardType: TextInputType.number,
            validator: (value) => AppInputValidators.isEmpty(value)
                ? null
                : AppInputValidators.amount(value, allowZero: true),
          ),
        ),
        SizedBox(
          width: 280,
          child: CustomTextField(
            label: 'Rent Price (Optional)',
            controller: priceController,
            keyboardType: TextInputType.number,
            validator: (value) => AppInputValidators.isEmpty(value)
                ? null
                : AppInputValidators.amount(value, allowZero: true),
          ),
        ),
        SizedBox(
          width: 280,
          child: CustomTextField(
            label: 'Sale Price (Optional)',
            controller: salePriceController,
            keyboardType: TextInputType.number,
            validator: (value) => AppInputValidators.isEmpty(value)
                ? null
                : AppInputValidators.amount(value, allowZero: true),
          ),
        ),
        SizedBox(
          width: 280,
          child: CustomTextField(
            label: 'Category (Optional)',
            controller: categoryController,
            validator: (value) => AppInputValidators.isEmpty(value)
                ? null
                : AppInputValidators.category(
                    value,
                    fieldName: 'Category',
                    isRequired: false,
                  ),
          ),
        ),
        SizedBox(
          width: 280,
          child: CustomTextField(
            label: 'Color (Optional)',
            controller: colorController,
            validator: (value) => AppInputValidators.isEmpty(value)
                ? null
                : AppInputValidators.color(value),
          ),
        ),
        SizedBox(
          width: 280,
          child: CustomTextField(
            label: 'Model (Optional)',
            controller: modelController,
            validator: (value) => AppInputValidators.isEmpty(value)
                ? null
                : AppInputValidators.model(value),
          ),
        ),
        SizedBox(
          width: 280,
          child: CustomTextField(
            label: 'Description (Optional)',
            maxLines: 2,
            controller: descriptionController,
            validator: (value) => AppInputValidators.isEmpty(value)
                ? null
                : AppInputValidators.description(value),
          ),
        ),
      ]);
    } else if (mainServiceType.isJewellery) {
      commonFields.addAll([
        SizedBox(
          width: 280,
          child: CustomTextField(
            label: 'Quantity',
            controller: stockController,
            keyboardType: TextInputType.number,
            validator: (value) =>
                AppInputValidators.quantity(value, allowZero: true),
          ),
        ),
        SizedBox(
          width: 280,
          child: CustomTextField(
            label: 'Purchase Price (Optional)',
            controller: purchaseAmountController,
            keyboardType: TextInputType.number,
            validator: (value) => AppInputValidators.isEmpty(value)
                ? null
                : AppInputValidators.amount(value, allowZero: true),
          ),
        ),
        SizedBox(
          width: 280,
          child: CustomTextField(
            label: 'Rent Price (Optional)',
            controller: priceController,
            keyboardType: TextInputType.number,
            validator: (value) => AppInputValidators.isEmpty(value)
                ? null
                : AppInputValidators.amount(value, allowZero: true),
          ),
        ),
        SizedBox(
          width: 280,
          child: CustomTextField(
            label: 'Sale Price (Optional)',
            controller: salePriceController,
            keyboardType: TextInputType.number,
            validator: (value) => AppInputValidators.isEmpty(value)
                ? null
                : AppInputValidators.amount(value, allowZero: true),
          ),
        ),
        SizedBox(
          width: 280,
          child: CustomTextField(
            label: 'Category (Optional)',
            controller: categoryController,
            validator: (value) => AppInputValidators.isEmpty(value)
                ? null
                : AppInputValidators.category(
                    value,
                    fieldName: 'Category',
                    isRequired: false,
                  ),
          ),
        ),
        SizedBox(
          width: 280,
          child: CustomTextField(
            label: 'Color (Optional)',
            controller: colorController,
            validator: (value) => AppInputValidators.isEmpty(value)
                ? null
                : AppInputValidators.color(value),
          ),
        ),
        SizedBox(
          width: 280,
          child: CustomTextField(
            label: 'Model (Optional)',
            controller: modelController,
            validator: (value) => AppInputValidators.isEmpty(value)
                ? null
                : AppInputValidators.model(value),
          ),
        ),
        SizedBox(
          width: 280,
          child: CustomTextField(
            label: 'Description (Optional)',
            maxLines: 2,
            controller: descriptionController,
            validator: (value) => AppInputValidators.isEmpty(value)
                ? null
                : AppInputValidators.description(value),
          ),
        ),
      ]);
    } else if (mainServiceType.isMaterial) {
      commonFields.addAll([
        SizedBox(
          width: 280,
          child: CustomTextField(
            label: 'Length',
            controller: lengthController,
            keyboardType: TextInputType.number,
            validator: (value) => AppInputValidators.onEmpty(value, 'Length'),
          ),
        ),
        SizedBox(
          width: 280,
          child: CustomTextField(
            label: 'Purchase Price (Optional)',
            controller: purchaseAmountController,
            keyboardType: TextInputType.number,
            validator: (value) => AppInputValidators.isEmpty(value)
                ? null
                : AppInputValidators.amount(value, allowZero: true),
          ),
        ),
        SizedBox(
          width: 280,
          child: CustomTextField(
            label: 'Rent Price (Optional)',
            controller: priceController,
            keyboardType: TextInputType.number,
            validator: (value) => AppInputValidators.isEmpty(value)
                ? null
                : AppInputValidators.amount(value, allowZero: true),
          ),
        ),
        SizedBox(
          width: 280,
          child: CustomTextField(
            label: 'Sale Price (Optional)',
            controller: salePriceController,
            keyboardType: TextInputType.number,
            validator: (value) => AppInputValidators.isEmpty(value)
                ? null
                : AppInputValidators.amount(value, allowZero: true),
          ),
        ),
        SizedBox(
          width: 280,
          child: CustomTextField(
            label: 'Fabric Type',
            controller: fabricTypeController,
            validator: (value) =>
                AppInputValidators.onEmpty(value, 'Fabric Type'),
          ),
        ),
        SizedBox(
          width: 280,
          child: CustomTextField(
            label: 'Color (Optional)',
            controller: colorController,
            validator: (value) => AppInputValidators.isEmpty(value)
                ? null
                : AppInputValidators.color(value),
          ),
        ),
        SizedBox(
          width: 280,
          child: CustomTextField(
            label: 'Model (Optional)',
            controller: modelController,
            validator: (value) => AppInputValidators.isEmpty(value)
                ? null
                : AppInputValidators.model(value),
          ),
        ),
        SizedBox(
          width: 280,
          child: CustomTextField(
            label: 'Description (Optional)',
            maxLines: 2,
            controller: descriptionController,
            validator: (value) => AppInputValidators.isEmpty(value)
                ? null
                : AppInputValidators.description(value),
          ),
        ),
      ]);
    } else {
      // DEFAULT (Vehicles, Gadgets, Equipment, etc.)
      commonFields.addAll([
        SizedBox(
          width: 280,
          child: CustomTextField(
            label: mainServiceType.isVehicle ? 'Unit' : 'Quantity',
            controller: stockController,
            keyboardType: TextInputType.number,
            validator: (value) =>
                AppInputValidators.quantity(value, allowZero: true),
          ),
        ),
        SizedBox(
          width: 280,
          child: CustomTextField(
            label: 'Purchase Amount (Optional)',
            controller: purchaseAmountController,
            keyboardType: TextInputType.number,
            validator: (value) => AppInputValidators.isEmpty(value)
                ? null
                : AppInputValidators.amount(value, allowZero: true),
          ),
        ),
        SizedBox(
          width: 280,
          child: CustomTextField(
            label: 'Rent Price (Optional)',
            controller: priceController,
            keyboardType: TextInputType.number,
            validator: (value) => AppInputValidators.isEmpty(value)
                ? null
                : AppInputValidators.amount(value, allowZero: true),
          ),
        ),
        SizedBox(
          width: 280,
          child: CustomTextField(
            label: 'Sale Price (Optional)',
            controller: salePriceController,
            keyboardType: TextInputType.number,
            validator: (value) => AppInputValidators.isEmpty(value)
                ? null
                : AppInputValidators.amount(value, allowZero: true),
          ),
        ),
        SizedBox(
          width: 280,
          child: CustomTextField(
            label:
                '${mainServiceType.isVehicle ? 'Brand' : 'Category'} (Optional)',
            controller: categoryController,
            validator: (value) => AppInputValidators.isEmpty(value)
                ? null
                : AppInputValidators.category(
                    value,
                    fieldName:
                        mainServiceType.isVehicle ? 'Brand' : 'Category',
                    isRequired: false,
                  ),
          ),
        ),
        SizedBox(
          width: 280,
          child: CustomTextField(
            label: 'Color (Optional)',
            controller: colorController,
            validator: (value) => AppInputValidators.isEmpty(value)
                ? null
                : AppInputValidators.color(value),
          ),
        ),
        SizedBox(
          width: 280,
          child: CustomTextField(
            label: 'Model (Optional)',
            controller: modelController,
            validator: (value) => AppInputValidators.isEmpty(value)
                ? null
                : AppInputValidators.model(value),
          ),
        ),
      ]);

      // Vehicle-specific fields
      if (mainServiceType.isVehicle) {
        commonFields.addAll([
          SizedBox(
            width: 280,
            child: CustomTextField(
              label: 'Registration Number (Optional)',
              controller: registrationNumberController,
              validator: null,
            ),
          ),
          SizedBox(
            width: 280,
            child: ProductDatePickerField(
              label: 'Pollution Expiry (Optional)',
              controller: pollutionExpiryController,
            ),
          ),
          SizedBox(
            width: 280,
            child: ProductDatePickerField(
              label: 'Insurance Expiry (Optional)',
              controller: insuranceExpiryController,
            ),
          ),
          SizedBox(
            width: 280,
            child: ProductDatePickerField(
              label: 'Permit Expiry (Optional)',
              controller: fitnessExpiryController,
            ),
          ),
        ]);
      }

      // Description at the end
      commonFields.add(
        SizedBox(
          width: 280,
          child: CustomTextField(
            label: 'Description (Optional)',
            maxLines: 2,
            controller: descriptionController,
            validator: (value) => AppInputValidators.isEmpty(value)
                ? null
                : AppInputValidators.description(value),
          ),
        ),
      );
    }

    return Wrap(runSpacing: 16, spacing: 16, children: commonFields);
  }
}

/// A read-only TextFormField that opens a [showDatePicker] on tap and formats
/// the selected date as DD/MM/YYYY into [controller].
class ProductDatePickerField extends StatelessWidget {
  final String label;
  final TextEditingController controller;

  const ProductDatePickerField({
    super.key,
    required this.label,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      readOnly: true,
      decoration: InputDecoration(
        labelText: label,
        hintText: 'Select date',
        suffixIcon: const Icon(Icons.calendar_today, size: 20),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.purple, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
      ),
      onTap: () async {
        final DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: controller.text.isNotEmpty
              ? _parseDate(controller.text) ?? DateTime.now()
              : DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2100),
          builder: (context, child) {
            return Theme(
              data: Theme.of(context).copyWith(
                colorScheme: const ColorScheme.light(
                  primary: AppColors.purple,
                  onPrimary: Colors.white,
                  onSurface: Colors.black,
                ),
              ),
              child: child!,
            );
          },
        );

        if (pickedDate != null) {
          controller.text =
              '${pickedDate.day.toString().padLeft(2, '0')}/${pickedDate.month.toString().padLeft(2, '0')}/${pickedDate.year}';
        }
      },
    );
  }
}

/// Parses a date string in DD/MM/YYYY format.
DateTime? _parseDate(String dateStr) {
  try {
    final parts = dateStr.split('/');
    if (parts.length == 3) {
      final day = int.parse(parts[0]);
      final month = int.parse(parts[1]);
      final year = int.parse(parts[2]);
      return DateTime(year, month, day);
    }
  } catch (_) {
    // Invalid date format
  }
  return null;
}
