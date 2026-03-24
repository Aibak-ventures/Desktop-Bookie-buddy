import 'package:bookie_buddy_web/utils/app_input_validators.dart';
import 'package:bookie_buddy_web/core/constants/enums/gender_type_enums.dart';
import 'package:bookie_buddy_web/utils/extensions/context_extensions.dart';
import 'package:bookie_buddy_web/utils/extensions/number_extensions.dart';
import 'package:bookie_buddy_web/utils/extensions/string_extensions.dart';
import 'package:bookie_buddy_web/utils/extensions/widget_extensions.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:bookie_buddy_web/core/common/widgets/custom_textfield.dart';
import 'package:bookie_buddy_web/features/booking/data/models/measurement_field_model.dart';
import 'package:bookie_buddy_web/features/booking/domain/entities/measurement_value_entity/measurement_value_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddCustomizationScreen extends StatefulWidget {
  const AddCustomizationScreen({super.key, this.addedMeasurements = const []});

  final List<MeasurementValueEntity> addedMeasurements;

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
        orElse: () => MeasurementValueEntity(
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
        .map(
          (e) => MeasurementFieldModel(
            name: e.name,
            key: e.key,
            description: '',
            gender: e.gender ?? GenderType.unisex,
            controller: TextEditingController(text: e.value),
          ),
        )
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
    final isWeb = context.screenWidth > 768;

    return Scaffold(
      backgroundColor: isWeb ? const Color(0xFFF5F7FA) : null,
      appBar: AppBar(
        title: const Text('Add Customisation'),
        centerTitle: true,
        elevation: 0,
        actions: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ElevatedButton.icon(
              onPressed: () {
                if (formKey.currentState?.validate() ?? false) {
                  final filteredMeasurements = measurementsNotifier.value
                      .where((field) => field.controller.text.trim().isNotEmpty)
                      .map(
                        (field) => MeasurementValueEntity(
                          name: field.name,
                          key: field.key,
                          value: field.controller.text.trim(),
                          gender: field.gender,
                        ),
                      )
                      .toList();
                  NavigatorX(context).pop(filteredMeasurements);
                } else {
                  context.showSnackBar(
                    'Please fill the fields correctly',
                    isError: true,
                  );
                }
              },
              icon: const Icon(Icons.save, color: Colors.white),
              label: const Text('Save Measurements',
                  style: TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
            ),
          ),
        ],
      ),
      body: Container(
        width: double.infinity,
        child: SingleChildScrollView(
          child: Center(
            child: Container(
              constraints: BoxConstraints(
                maxWidth: isWeb ? 1200 : double.infinity,
              ),
              padding:
                  isWeb ? const EdgeInsets.all(40) : const EdgeInsets.all(16),
              child: Form(
                key: formKey,
                child: isWeb
                    ? _buildWebLayout(context)
                    : _buildMobileLayout(context),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildWebLayout(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: genderNotifier,
      builder: (context, selectedGender, child) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header section
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.purple.shade50, Colors.blue.shade50],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Measurement Customization',
                  style: TextStyle(
                    fontSize: 28.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.purple.shade800,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Add precise measurements and customization details for the perfect fit',
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: Colors.grey.shade700,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 40),

          // Gender selection and custom measurements in cards
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Left side - Gender selection and measurements
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    // Gender selection card
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade200,
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Measurement Category',
                            style: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 12),
                            decoration: BoxDecoration(
                              color: AppColors.purpleLightShade,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.purple.shade200),
                            ),
                            child: DropdownButton<GenderType>(
                              value: selectedGender,
                              dropdownColor: AppColors.white,
                              borderRadius: BorderRadius.circular(8),
                              underline: const SizedBox(),
                              isExpanded: true,
                              items: GenderType.values
                                  .map(
                                    (gender) => DropdownMenuItem(
                                      value: gender,
                                      child: Text(
                                        gender.name.capitalizeFirstLetter(),
                                        style: TextStyle(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
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
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Measurements card
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade200,
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: ValueListenableBuilder(
                        valueListenable: measurementsNotifier,
                        builder: (context, value, child) => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Standard Measurements',
                              style: TextStyle(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 20),
                            ...value
                                .where((element) {
                                  if (selectedGender == GenderType.unisex)
                                    return true;
                                  if (element.gender == GenderType.unisex)
                                    return true;
                                  return element.gender == selectedGender;
                                })
                                .map(
                                  (field) => Container(
                                    margin: const EdgeInsets.only(bottom: 16),
                                    padding: const EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade50,
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                          color: Colors.grey.shade200),
                                    ),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                field.name,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 14.sp,
                                                  color: Colors.black87,
                                                ),
                                              ),
                                              if (field.description.isNotEmpty)
                                                Text(
                                                  field.description,
                                                  style: TextStyle(
                                                    fontSize: 12.sp,
                                                    color: Colors.grey.shade600,
                                                  ),
                                                ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(width: 16),
                                        Expanded(
                                          flex: 1,
                                          child: CustomTextField(
                                            controller: field.controller,
                                            hintText:
                                                'Enter measurement value (e.g., 32 inches)',
                                            validator: (value) =>
                                                AppInputValidators.basicText(
                                              value,
                                              isRequired: false,
                                              fieldName: field.name,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                                .toList(),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 24),

              // Right side - Custom measurements
              Expanded(
                flex: 1,
                child: Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade200,
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Custom Measurements',
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'Add any additional measurements not covered in the standard list',
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Form(
                        key: customizationFormKey,
                        child: Column(
                          children: [
                            CustomTextField(
                              controller: customCustomizationController,
                              validator: AppInputValidators.basicText,
                              hintText:
                                  'Enter measurement name (e.g., Shoulder Width)',
                              prefixIcon: const Icon(Icons.straighten),
                            ),
                            const SizedBox(height: 16),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton.icon(
                                onPressed: () {
                                  if (customizationFormKey.currentState
                                          ?.validate() ??
                                      false) {
                                    final newKey = customCustomizationController
                                        .text
                                        .trim()
                                        .toLowerCase()
                                        .replaceAll(' ', '_');

                                    final alreadyExists =
                                        measurementsNotifier.value.any(
                                      (e) => e.key == newKey,
                                    );

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
                                icon:
                                    const Icon(Icons.add, color: Colors.white),
                                label: const Text('Add Measurement',
                                    style: TextStyle(color: Colors.white)),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.purple,
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 16),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: genderNotifier,
      builder: (context, selectedGender, child) => ListView(
        children: [
          // --- Gender ---
          Padding(
            padding: 10.paddingVertical,
            child: Row(
              children: [
                Expanded(
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
              ],
            ),
          ),

          // --- Measurements ---
          ValueListenableBuilder(
            valueListenable: measurementsNotifier,
            builder: (context, value, child) => Column(
              children: value
                  .where((element) {
                    if (selectedGender == GenderType.unisex) return true;
                    if (element.gender == GenderType.unisex) return true;
                    return element.gender == selectedGender;
                  })
                  .map(
                    (field) => Padding(
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
                          ),
                        ],
                      ),
                    ),
                  )
                  .toList(),
            ),
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
                  border: Border.all(color: AppColors.purple),
                ),
                child: const Icon(Icons.add, color: AppColors.purple),
              ).onTap(() {
                if (customizationFormKey.currentState?.validate() ?? false) {
                  final newKey = customCustomizationController.text
                      .trim()
                      .toLowerCase()
                      .replaceAll(' ', '_');

                  final alreadyExists = measurementsNotifier.value.any(
                    (e) => e.key == newKey,
                  );

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
              }),
            ],
          ),
          10.height,
        ],
      ),
    );
  }
}

List<MeasurementFieldModel> getMeasurements() => [
      // --- Female Measurements ---
      MeasurementFieldModel(
        name: 'Top Round',
        key: 'top_round',
        description: 'Round measurement around top',
        gender: GenderType.female,
      ),
      MeasurementFieldModel(
        name: 'Top Length',
        key: 'top_length',
        description: 'Vertical length of the top',
        gender: GenderType.female,
      ),

      MeasurementFieldModel(
        name: 'Chest',
        key: 'chest',
        description: 'Fullest part of the chest',
        gender: GenderType.unisex,
      ),

      MeasurementFieldModel(
        name: 'Shape',
        key: 'shape',
        description: 'Garment shape (fitted/flared/etc.)',
        gender: GenderType.female,
      ),

      MeasurementFieldModel(
        name: 'Sleeve Length',
        key: 'sleeve_length',
        description: 'Shoulder to desired sleeve end',
        gender: GenderType.unisex,
        isOptional: true,
      ),

      MeasurementFieldModel(
        name: 'Sleeve Arm',
        key: 'sleeve_arm',
        description: 'Around the upper arm',
        gender: GenderType.female,
      ),
      MeasurementFieldModel(
        name: 'Sleeve Width',
        key: 'sleeve_width',
        description: 'Width at the end of sleeve',
        gender: GenderType.female,
      ),
      MeasurementFieldModel(
        name: 'Regal',
        key: 'regal',
        description: 'Shoulder to bust line or relevant regal line',
        gender: GenderType.female,
      ),
      MeasurementFieldModel(
        name: 'Front Neck',
        key: 'front_neck',
        description: 'Depth of the front neckline',
        gender: GenderType.female,
      ),
      MeasurementFieldModel(
        name: 'Back Neck',
        key: 'back_neck',
        description: 'Depth of the back neckline',
        gender: GenderType.female,
      ),
      MeasurementFieldModel(
        name: 'Elbow',
        key: 'elbow',
        description: 'Circumference around the elbow',
        gender: GenderType.female,
      ),

      // --- Male Measurements ---
      MeasurementFieldModel(
        name: 'Neck Circumference',
        key: 'neck_circumference',
        description: 'Around the base of the neck',
        gender: GenderType.male,
      ),
      MeasurementFieldModel(
        name: 'Shirt/Kurta Length',
        key: 'shirt_length',
        description: 'Shoulder to desired bottom length',
        gender: GenderType.male,
      ),
      MeasurementFieldModel(
        name: 'Armhole',
        key: 'armhole',
        description: 'Around the arm socket',
        gender: GenderType.male,
      ),
      MeasurementFieldModel(
        name: 'Upper Arm',
        key: 'upper_arm',
        description: 'Fullest part of the upper arm',
        gender: GenderType.male,
      ),
      MeasurementFieldModel(
        name: 'Wrist',
        key: 'wrist',
        description: 'Circumference of the wrist',
        gender: GenderType.male,
      ),
      MeasurementFieldModel(
        name: 'Pant Length',
        key: 'pant_length',
        description: 'Waist to ankle',
        gender: GenderType.male,
      ),
      MeasurementFieldModel(
        name: 'Inseam',
        key: 'inseam',
        description: 'Crotch to ankle inside the leg',
        gender: GenderType.male,
      ),
      MeasurementFieldModel(
        name: 'Thigh',
        key: 'thigh',
        description: 'Fullest part of the upper leg',
        gender: GenderType.male,
      ),

      // --- Measurements for both genders ---
      MeasurementFieldModel(
        name: 'Waist',
        key: 'waist',
        description: 'Natural waistline',
        gender: GenderType.unisex,
      ),

      MeasurementFieldModel(
        name: 'Shoulder Width',
        key: 'shoulder_width',
        description: 'Tip to tip across the back',
        gender: GenderType.unisex,
      ),

      MeasurementFieldModel(
        name: 'Height',
        key: 'height',
        description: 'For total garment length',
        gender: GenderType.unisex,
      ),
    ];
