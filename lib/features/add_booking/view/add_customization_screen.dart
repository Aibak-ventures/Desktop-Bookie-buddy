import 'package:bookie_buddy_web/core/app_input_validators.dart';
import 'package:bookie_buddy_web/core/enums/gender_type_enums.dart';
import 'package:bookie_buddy_web/core/extensions/context_extensions.dart';
import 'package:bookie_buddy_web/core/extensions/number_extensions.dart';
import 'package:bookie_buddy_web/core/extensions/string_extensions.dart';
import 'package:bookie_buddy_web/core/extensions/widget_extensions.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:bookie_buddy_web/core/ui/widgets/custom_textfield.dart';
import 'package:bookie_buddy_web/features/add_booking/models/measurement_field_model.dart';
import 'package:bookie_buddy_web/features/add_booking/models/measurement_value_model/measurement_value_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddCustomizationScreen extends StatefulWidget {
  const AddCustomizationScreen({
    super.key,
    this.addedMeasurements = const [],
  });

  final List<MeasurementValueModel> addedMeasurements;

  @override
  State<AddCustomizationScreen> createState() => _AddCustomizationScreenState();
}

class _AddCustomizationScreenState extends State<AddCustomizationScreen> {
  final ValueNotifier<List<MeasurementFieldModel>> measurementsNotifier =
      ValueNotifier([]);

  final customCustomizationController = TextEditingController();

  final genderNotifier = ValueNotifier<GenderType>(GenderType.male);

  final formKey = GlobalKey<FormState>();
  final customizationFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    if (widget.addedMeasurements.isNotEmpty) {
      final genders = widget.addedMeasurements.map((e) => e.gender).toSet();

      // Remove unisex for better logic
      final filteredGenders =
          genders.where((g) => g != GenderType.unisex).toSet();

      if (filteredGenders.length == 1) {
        genderNotifier.value = filteredGenders.first ?? GenderType.unisex;
      } else {
        genderNotifier.value = GenderType.unisex;
      }
    }

    final baseMeasurements = getMeasurements();

    // Update existing fields with saved values
    final updatedMeasurements = baseMeasurements.map((field) {
      final existing = widget.addedMeasurements.firstWhere(
        (e) => e.key == field.key,
        orElse: () => MeasurementValueModel(
          name: field.name,
          key: field.key,
          value: '',
          gender: field.gender,
        ),
      );
      return field.copyWith(
        controller: TextEditingController(text: existing.value),
      );
    }).toList();

    // Now add custom measurements (not in base list)
    final customMeasurements = widget.addedMeasurements
        .where((e) => !baseMeasurements.any((f) => f.key == e.key))
        .map((e) => MeasurementFieldModel(
              name: e.name,
              key: e.key,
              description: '',
              gender: e.gender ?? GenderType.unisex,
              controller: TextEditingController(text: e.value),
            ))
        .toList();

    measurementsNotifier.value = [
      ...updatedMeasurements,
      ...customMeasurements,
    ];
  }

  @override
  void dispose() {
    genderNotifier.dispose();
    measurementsNotifier.value.forEach(
      (element) => element.controller.dispose(),
    );
    customCustomizationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Customisation'),
        actions: [
          ElevatedButton(
            onPressed: () {
              if (formKey.currentState?.validate() ?? false) {
                final filteredMeasurements = measurementsNotifier.value
                    .where(
                      (field) => field.controller.text.trim().isNotEmpty,
                    )
                    .map(
                      (field) => MeasurementValueModel(
                        name: field.name,
                        key: field.key,
                        value: field.controller.text.trim(),
                        gender: field.gender,
                      ),
                    )
                    .toList();
                context.pop(filteredMeasurements);
              } else {
                context.showSnackBar(
                  'Please fill the fields correctly',
                  isError: true,
                );
              }
            },
            child: const Text(
              'Save',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: context.isMobile ? 10.padding : (40, 16).padding,
        child: Form(
          key: formKey,
          child: ValueListenableBuilder(
              valueListenable: genderNotifier,
              builder: (context, selectedGender, child) {
                return ListView(
                  children: [
                    // --- Gender ---
                    Padding(
                      padding: 10.paddingVertical,
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Text(
                              'Measurement for :',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16.sp,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              alignment: Alignment.center,
                              // padding: 30.paddingHorizontal,
                              decoration: BoxDecoration(
                                color: AppColors.purpleLightShade,
                                borderRadius: 5.radiusBorder,
                              ),
                              child: DropdownButton(
                                value: selectedGender,
                                dropdownColor: AppColors.white,
                                borderRadius: 5.radiusBorder,
                                alignment: Alignment.center,
                                underline: const SizedBox(),
                                items: GenderType.values
                                    .map(
                                      (gender) => DropdownMenuItem(
                                        value: gender,
                                        child: Text(gender.name),
                                      ),
                                    )
                                    .toList(),
                                onChanged: (value) {
                                  if (value != null) {
                                    genderNotifier.value = value;
                                  }
                                },
                              ),
                            ),
                          ),
                          // const Spacer()
                        ],
                      ),
                    ),

                    // --- Measurements ---
                    ValueListenableBuilder(
                      valueListenable: measurementsNotifier,
                      builder: (context, value, child) {
                        return Column(
                          children: value.where(
                            (element) {
                              if (selectedGender == GenderType.unisex)
                                return true; // If unisex is selected, show all measurements
                              if (element.gender == GenderType.unisex)
                                return true; // show measurements of both genders always
                              return element.gender ==
                                  selectedGender; // show measurements of selected gender with unisex measurements
                            },
                          ).map((field) {
                            return Padding(
                              padding: 10.paddingVertical,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Tooltip(
                                      message: field.description,
                                      child: Text(
                                        field.name + ' :',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16.sp,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: CustomTextField(
                                      controller: field.controller,
                                      validator: (value) =>
                                          AppInputValidators.basicText(
                                        value,
                                        isRequired: false,
                                        fieldName: field.name,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            );
                          }).toList(),
                        );
                      },
                    ),

                    // --- Add Custom Measurements ---
                    Padding(
                      padding: 10.paddingVertical,
                      child: Text(
                        'Add Custom Measurements',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16.sp,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Form(
                            key: customizationFormKey,
                            child: CustomTextField(
                              controller: customCustomizationController,
                              // autovalidateMode:
                              //     AutovalidateMode.onUserInteraction,
                              validator: AppInputValidators.basicText,
                              hintText: 'Measurement name',
                            ),
                          ),
                        ),
                        5.width,
                        Container(
                          height: 56,
                          width: 56,
                          decoration: BoxDecoration(
                              color: AppColors.purpleLight,
                              borderRadius: 5.radiusBorder,
                              border: Border.all(
                                color: AppColors.purple,
                              )),
                          child: const Icon(
                            Icons.add,
                            color: AppColors.purple,
                          ),
                        ).onTap(
                          () {
                            if (customizationFormKey.currentState?.validate() ??
                                false) {
                              final newKey = customCustomizationController.text
                                  .trim()
                                  .toLowerCase()
                                  .replaceAll(' ', '_');

                              final alreadyExists = measurementsNotifier.value
                                  .any((e) => e.key == newKey);

                              if (alreadyExists) {
                                context.showSnackBar(
                                  'This measurement already exists',
                                  isError: true,
                                );
                                return;
                              }

                              measurementsNotifier.value = [
                                ...measurementsNotifier.value,
                             MeasurementFieldModel(
                          name: customCustomizationController.text
                              .trim()
                              .capitalizeFirstLetter(),
                          key: newKey,
                          description: '',
                          gender: GenderType.unisex,
                        ),
                              ];
                              customCustomizationController.clear();
                            }
                          },
                        )
                      ],
                    ),
                    10.height,
                  ],
                );
              }),
        ),
      ),
    );
  }
}

List<MeasurementFieldModel> getMeasurements() {
  return [
    // --- Female Measurements ---
    MeasurementFieldModel(
      name: "Top Round",
      key: "top_round",
      description: "Round measurement around top",
      gender: GenderType.female,
    ),
    MeasurementFieldModel(
      name: "Top Length",
      key: "top_length",
      description: "Vertical length of the top",
      gender: GenderType.female,
    ),

    MeasurementFieldModel(
      name: "Chest",
      key: "chest",
      description: "Fullest part of the chest",
      gender: GenderType.unisex,
    ),

    MeasurementFieldModel(
      name: "Shape",
      key: "shape",
      description: "Garment shape (fitted/flared/etc.)",
      gender: GenderType.female,
    ),

    MeasurementFieldModel(
      name: "Sleeve Length",
      key: "sleeve_length",
      description: "Shoulder to desired sleeve end",
      gender: GenderType.unisex,
      isOptional: true,
    ),

    MeasurementFieldModel(
      name: "Sleeve Arm",
      key: "sleeve_arm",
      description: "Around the upper arm",
      gender: GenderType.female,
    ),
    MeasurementFieldModel(
      name: "Sleeve Width",
      key: "sleeve_width",
      description: "Width at the end of sleeve",
      gender: GenderType.female,
    ),
    MeasurementFieldModel(
      name: "Regal",
      key: "regal",
      description: "Shoulder to bust line or relevant regal line",
      gender: GenderType.female,
    ),
    MeasurementFieldModel(
      name: "Front Neck",
      key: "front_neck",
      description: "Depth of the front neckline",
      gender: GenderType.female,
    ),
    MeasurementFieldModel(
      name: "Back Neck",
      key: "back_neck",
      description: "Depth of the back neckline",
      gender: GenderType.female,
    ),
    MeasurementFieldModel(
      name: "Elbow",
      key: "elbow",
      description: "Circumference around the elbow",
      gender: GenderType.female,
    ),

    // --- Male Measurements ---

    MeasurementFieldModel(
      name: "Neck Circumference",
      key: "neck_circumference",
      description: "Around the base of the neck",
      gender: GenderType.male,
    ),
    MeasurementFieldModel(
      name: "Shirt/Kurta Length",
      key: "shirt_length",
      description: "Shoulder to desired bottom length",
      gender: GenderType.male,
    ),
    MeasurementFieldModel(
      name: "Armhole",
      key: "armhole",
      description: "Around the arm socket",
      gender: GenderType.male,
    ),
    MeasurementFieldModel(
      name: "Upper Arm",
      key: "upper_arm",
      description: "Fullest part of the upper arm",
      gender: GenderType.male,
    ),
    MeasurementFieldModel(
      name: "Wrist",
      key: "wrist",
      description: "Circumference of the wrist",
      gender: GenderType.male,
    ),
    MeasurementFieldModel(
      name: "Pant Length",
      key: "pant_length",
      description: "Waist to ankle",
      gender: GenderType.male,
    ),
    MeasurementFieldModel(
      name: "Inseam",
      key: "inseam",
      description: "Crotch to ankle inside the leg",
      gender: GenderType.male,
    ),
    MeasurementFieldModel(
      name: "Thigh",
      key: "thigh",
      description: "Fullest part of the upper leg",
      gender: GenderType.male,
    ),

    // --- Measurements for both genders ---

    MeasurementFieldModel(
      name: "Waist",
      key: "waist",
      description: "Natural waistline",
      gender: GenderType.unisex,
    ),

    MeasurementFieldModel(
      name: "Shoulder Width",
      key: "shoulder_width",
      description: "Tip to tip across the back",
      gender: GenderType.unisex,
    ),

    MeasurementFieldModel(
      name: "Height",
      key: "height",
      description: "For total garment length",
      gender: GenderType.unisex,
    ),
  ];
}
