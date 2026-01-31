import 'package:bookie_buddy_web/core/app_input_validators.dart';
import 'package:bookie_buddy_web/core/enums/gender_type_enums.dart';
import 'package:bookie_buddy_web/core/extensions/string_extensions.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:bookie_buddy_web/core/ui/widgets/custom_textfield.dart';
import 'package:bookie_buddy_web/features/add_booking/models/measurement_field_model.dart';
import 'package:bookie_buddy_web/features/add_booking/models/measurement_value_model/measurement_value_model.dart';
import 'package:bookie_buddy_web/features/select_product_booking/models/product_selected_model/product_selected_model.dart';
import 'package:flutter/material.dart';

class ProductCustomizationWidget extends StatefulWidget {
  const ProductCustomizationWidget({
    super.key,
    required this.onBack,
    required this.onSave,
    required this.selectedProducts,
    this.addedMeasurements = const [],
  });

  final VoidCallback onBack;
  final Function(List<MeasurementValueModel>) onSave;
  final List<ProductSelectedModel> selectedProducts;
  final List<MeasurementValueModel> addedMeasurements;

  @override
  State<ProductCustomizationWidget> createState() =>
      _ProductCustomizationWidgetState();
}

class _ProductCustomizationWidgetState
    extends State<ProductCustomizationWidget> {
  final ValueNotifier<List<MeasurementFieldModel>> measurementsNotifier =
      ValueNotifier([]);
  final customCustomizationController = TextEditingController();
  final genderNotifier = ValueNotifier<GenderType>(GenderType.male);
  final formKey = GlobalKey<FormState>();

  // Currently selected product for customization
  ProductSelectedModel? selectedProduct;

  @override
  void initState() {
    super.initState();
    // Auto-select first product if available
    if (widget.selectedProducts.isNotEmpty) {
      selectedProduct = widget.selectedProducts.first;
    }
    _initializeMeasurements();
  }

  void _initializeMeasurements() {
    if (widget.addedMeasurements.isNotEmpty) {
      final genders = widget.addedMeasurements.map((e) => e.gender).toSet();
      final filteredGenders =
          genders.where((g) => g != GenderType.unisex).toSet();

      if (filteredGenders.length == 1) {
        genderNotifier.value = filteredGenders.first ?? GenderType.unisex;
      } else {
        genderNotifier.value = GenderType.unisex;
      }
    }

    final baseMeasurements = _getMeasurements();

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
    measurementsNotifier.value
        .forEach((element) => element.controller.dispose());
    customCustomizationController.dispose();
    super.dispose();
  }

  void _saveMeasurements() {
    if (formKey.currentState?.validate() ?? false) {
      final filteredMeasurements = measurementsNotifier.value
          .where((field) => field.controller.text.trim().isNotEmpty)
          .map(
            (field) => MeasurementValueModel(
              name: field.name,
              key: field.key,
              value: field.controller.text.trim(),
              gender: field.gender,
            ),
          )
          .toList();
      widget.onSave(filteredMeasurements);
    }
  }

  void _addCustomMeasurement() {
    final newKey = customCustomizationController.text
        .trim()
        .toLowerCase()
        .replaceAll(' ', '_');

    final alreadyExists =
        measurementsNotifier.value.any((e) => e.key == newKey);

    if (alreadyExists) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('This measurement already exists'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    measurementsNotifier.value = [
      ...measurementsNotifier.value,
      MeasurementFieldModel(
        name: customCustomizationController.text.trim().capitalizeFirstLetter(),
        key: newKey,
        description: '',
        gender: GenderType.unisex,
      ),
    ];
    customCustomizationController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.white,
      child: Column(
        children: [
          // Header with back button
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                bottom: BorderSide(color: Colors.grey.shade200),
              ),
            ),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back, color: AppColors.primary),
                  onPressed: widget.onBack,
                  tooltip: 'Back to products',
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Add Customization',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        selectedProduct != null
                            ? 'Adding measurements for ${selectedProduct!.variant.name}'
                            : 'Select a product to add measurements',
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppColors.textTertiary,
                        ),
                      ),
                    ],
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: selectedProduct != null ? _saveMeasurements : null,
                  icon: const Icon(Icons.save, size: 16, color: Colors.white),
                  label: const Text(
                    'Save Measurements',
                    style: TextStyle(color: Colors.white, fontSize: 13),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: selectedProduct != null
                        ?  AppColors.greenSuccess
                        : Colors.grey,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12),
                    elevation: 0,
                  ),
                ),
              ],
            ),
          ),

          // Content - Split layout
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // LEFT: Selected products list
                SizedBox(
                  width: 350,
                  child: _buildProductsList(),
                ),

                // Divider
                Container(
                  width: 1,
                  color: Colors.grey.shade200,
                ),

                // RIGHT: Measurement fields
                Expanded(
                  flex: 3,
                  child: _buildMeasurementSection(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMeasurementSection() {
    return Form(
      key: formKey,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: ValueListenableBuilder(
          valueListenable: genderNotifier,
          builder: (context, selectedGender, child) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Gender selection
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: 
                   AppColors.backgroundLightest,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: Row(
                  children: [
                    const Text(
                      'Measurement for:',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        child: DropdownButton<GenderType>(
                          value: selectedGender,
                          isExpanded: true,
                          underline: const SizedBox(),
                          items: GenderType.values
                              .map(
                                (gender) => DropdownMenuItem(
                                  value: gender,
                                  child: Text(
                                    gender.name.capitalizeFirstLetter(),
                                    style: const TextStyle(fontSize: 13),
                                  ),
                                ),
                              )
                              .toList(),
                          onChanged: selectedProduct != null
                              ? (value) {
                                  if (value != null) {
                                    genderNotifier.value = value;
                                  }
                                }
                              : null,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Measurements
              const Text(
                'Measurements',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 12),

              ValueListenableBuilder(
                valueListenable: measurementsNotifier,
                builder: (context, measurements, child) {
                  final filteredMeasurements = measurements.where((element) {
                    if (selectedGender == GenderType.unisex) return true;
                    if (element.gender == GenderType.unisex) return true;
                    return element.gender == selectedGender;
                  }).toList();

                  return Column(
                    children: filteredMeasurements
                        .map(
                          (field) => Container(
                            margin: const EdgeInsets.only(bottom: 12),
                            padding: const EdgeInsets.all(14),
                            decoration: BoxDecoration(
                              color: selectedProduct != null
                                  ? Colors.white
                                  : Colors.grey.shade50,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.grey.shade200),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        field.name,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 13,
                                          color: AppColors.textSecondary,
                                        ),
                                      ),
                                      if (field.description.isNotEmpty)
                                        Text(
                                          field.description,
                                          style: TextStyle(
                                            fontSize: 11,
                                            color: Colors.grey.shade600,
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  flex: 3,
                                  child: IgnorePointer(
                                    ignoring: selectedProduct == null,
                                    child: Opacity(
                                      opacity:
                                          selectedProduct != null ? 1.0 : 0.5,
                                      child: CustomTextField(
                                        controller: field.controller,
                                        hintText: 'e.g., 32 inches',
                                        validator: (value) =>
                                            AppInputValidators.basicText(
                                          value,
                                          isRequired: false,
                                          fieldName: field.name,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                        .toList(),
                  );
                },
              ),

              const SizedBox(height: 24),

              // Add custom measurement
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color:  AppColors.backgroundLightest,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Add Custom Measurement',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: IgnorePointer(
                            ignoring: selectedProduct == null,
                            child: Opacity(
                              opacity: selectedProduct != null ? 1.0 : 0.5,
                              child: CustomTextField(
                                validator: (value) =>
                                    AppInputValidators.basicText(
                                  value,
                                  isRequired: false,
                                ),
                                controller: customCustomizationController,
                                hintText: 'e.g., Shoulder Width',
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        ElevatedButton.icon(
                          onPressed: selectedProduct != null
                              ? _addCustomMeasurement
                              : null,
                          icon: const Icon(Icons.add,
                              size: 16, color: Colors.white),
                          label: const Text('Add',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 13)),
                          style: ElevatedButton.styleFrom(
                            backgroundColor:  AppColors.primary,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 16),
                            elevation: 0,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProductsList() {
    return Container(
      color:  AppColors.backgroundLightest,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                bottom: BorderSide(color: Colors.grey.shade200),
              ),
            ),
            child: Row(
              children: [
                const Text(
                  'Items',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(width: 16),
                Text(
                  'Variants',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey.shade600,
                  ),
                ),
                const Spacer(),
                Text(
                  'Customisation',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),

          // Products list
          Expanded(
            child: widget.selectedProducts.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.inventory_2_outlined,
                            size: 48, color: Colors.grey.shade400),
                        const SizedBox(height: 12),
                        Text(
                          'No products selected',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(12),
                    itemCount: widget.selectedProducts.length,
                    itemBuilder: (context, index) {
                      final product = widget.selectedProducts[index];
                      final isSelected = selectedProduct == product;

                      return Container(
                        margin: const EdgeInsets.only(bottom: 8),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? AppColors.primaryLight
                              : Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: isSelected
                                ?  AppColors.primary
                                : Colors.grey.shade200,
                            width: isSelected ? 2 : 1,
                          ),
                        ),
                        child: Row(
                          children: [
                            // Product image
                            Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade100,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: product.variant.image != null &&
                                      product.variant.image!.isNotEmpty
                                  ? ClipRRect(
                                      borderRadius: BorderRadius.circular(6),
                                      child: Image.network(
                                        product.variant.image!,
                                        fit: BoxFit.cover,
                                        errorBuilder: (_, __, ___) => Icon(
                                          Icons.image,
                                          color: Colors.grey.shade400,
                                        ),
                                      ),
                                    )
                                  : Icon(Icons.image,
                                      color: Colors.grey.shade400),
                            ),
                            const SizedBox(width: 12),

                            // Product info
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    product.variant.name,
                                    style: const TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.textSecondary,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    [
                                      product.variant.color,
                                      product.variant.category
                                    ]
                                        .where((e) => e != null && e.isNotEmpty)
                                        .join(', '),
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey.shade600,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            // Add button
                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  selectedProduct = product;
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: isSelected
                                    ?  AppColors.primary
                                    :  AppColors.greenSuccess,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 8),
                                minimumSize: const Size(60, 32),
                                elevation: 0,
                              ),
                              child: Text(
                                isSelected ? 'Selected' : 'add',
                                style: const TextStyle(fontSize: 12),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  List<MeasurementFieldModel> _getMeasurements() => [
        // Female Measurements
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
          description: 'Garment shape',
          gender: GenderType.female,
        ),
        MeasurementFieldModel(
          name: 'Sleeve Length',
          key: 'sleeve_length',
          description: 'Shoulder to desired sleeve end',
          gender: GenderType.unisex,
        ),
        MeasurementFieldModel(
          name: 'Sleeve Arm',
          key: 'sleeve_arm',
          description: 'Around the upper arm',
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
        // Male Measurements
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
          description: 'Fullest part of the thigh',
          gender: GenderType.male,
        ),
      ];
}

