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
    required this.onSaveForProduct,
    required this.selectedProducts,
  });

  final VoidCallback onBack;
  final Function(ProductSelectedModel product,
      List<MeasurementValueModel> measurements) onSaveForProduct;
  final List<ProductSelectedModel> selectedProducts;

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
  int? selectedProductIndex;

  @override
  void initState() {
    super.initState();
    // Auto-select first product without measurements
    _selectFirstProductWithoutMeasurements();
  }

  void _selectFirstProductWithoutMeasurements() {
    for (int i = 0; i < widget.selectedProducts.length; i++) {
      if (widget.selectedProducts[i].measurements.isEmpty) {
        setState(() {
          selectedProduct = widget.selectedProducts[i];
          selectedProductIndex = i;
        });
        _initializeMeasurements();
        return;
      }
    }
    // If all products have measurements, select the first one
    if (widget.selectedProducts.isNotEmpty) {
      setState(() {
        selectedProduct = widget.selectedProducts.first;
        selectedProductIndex = 0;
      });
      _initializeMeasurements();
    }
  }

  void _initializeMeasurements() {
    // Dispose old controllers
    for (var field in measurementsNotifier.value) {
      field.controller.dispose();
    }

    if (selectedProduct == null) {
      measurementsNotifier.value = [];
      return;
    }

    final productMeasurements = selectedProduct!.measurements;

    if (productMeasurements.isNotEmpty) {
      final genders = productMeasurements.map((e) => e.gender).toSet();
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
      final existing = productMeasurements.firstWhere(
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

    final customMeasurements = productMeasurements
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

  void _saveMeasurements({bool moveToNext = false}) {
    if (selectedProduct == null) return;

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

      widget.onSaveForProduct(selectedProduct!, filteredMeasurements);

      if (moveToNext) {
        _moveToNextProduct();
      }
    }
  }

  void _moveToNextProduct() {
    if (selectedProductIndex == null) return;

    // Find next product
    final nextIndex = selectedProductIndex! + 1;
    if (nextIndex < widget.selectedProducts.length) {
      setState(() {
        selectedProductIndex = nextIndex;
        selectedProduct = widget.selectedProducts[nextIndex];
      });
      _initializeMeasurements();
    } else {
      // All products done
      widget.onBack();
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
                  icon: const Icon(Icons.arrow_back, color: Color(0xFF6C5CE7)),
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
                          color: Color(0xFF2D3436),
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        selectedProduct != null
                            ? 'Adding measurements for ${selectedProduct!.variant.name}'
                            : 'Select a product to add measurements',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color(0xFF636E72),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ElevatedButton.icon(
                      onPressed: selectedProduct != null
                          ? () => _saveMeasurements()
                          : null,
                      icon:
                          const Icon(Icons.save, size: 16, color: Colors.white),
                      label: const Text(
                        'Save',
                        style: TextStyle(color: Colors.white, fontSize: 13),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: selectedProduct != null
                            ? const Color(0xFF27AE60)
                            : Colors.grey,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 12),
                        elevation: 0,
                      ),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton.icon(
                      onPressed: selectedProduct != null
                          ? () => _saveMeasurements(moveToNext: true)
                          : null,
                      icon: const Icon(Icons.skip_next,
                          size: 16, color: Colors.white),
                      label: const Text(
                        'Save & Next',
                        style: TextStyle(color: Colors.white, fontSize: 13),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: selectedProduct != null
                            ? const Color(0xFF6C5CE7)
                            : Colors.grey,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 12),
                        elevation: 0,
                      ),
                    ),
                  ],
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
              // Customisation header - moved from product list
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFF8F9FA),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: const Color(0xFF6C5CE7).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Icon(
                        Icons.design_services,
                        color: Color(0xFF6C5CE7),
                        size: 18,
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Text(
                      'Customisation',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF2D3436),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Gender selection
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFF8F9FA),
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
                        color: Color(0xFF2D3436),
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
                  color: Color(0xFF2D3436),
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
                                          color: Color(0xFF2D3436),
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
                  color: const Color(0xFFF8F9FA),
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
                        color: Color(0xFF2D3436),
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
                            backgroundColor: const Color(0xFF6C5CE7),
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
      color: const Color(0xFFF8F9FA),
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
                    color: Color(0xFF2D3436),
                  ),
                ),
                const Spacer(),
                Text(
                  'Status',
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
                              ? const Color(0xFFE8E4FF)
                              : Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: isSelected
                                ? const Color(0xFF6C5CE7)
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
                                      color: Color(0xFF2D3436),
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 6),
                                  // Variant details in chips
                                  Wrap(
                                    spacing: 6,
                                    runSpacing: 4,
                                    children: [
                                      if (product.variant.variantAttribute !=
                                              null &&
                                          product.variant.variantAttribute!
                                              .isNotEmpty)
                                        _buildVariantChip(
                                            product.variant.variantAttribute!,
                                            Icons.label),
                                      if (product.variant.color != null &&
                                          product.variant.color!.isNotEmpty)
                                        _buildVariantChip(
                                            product.variant.color!,
                                            Icons.palette),
                                      if (product.variant.model != null &&
                                          product.variant.model!.isNotEmpty)
                                        _buildVariantChip(
                                            product.variant.model!,
                                            Icons.style),
                                      if (product.variant.category != null &&
                                          product.variant.category!.isNotEmpty)
                                        _buildVariantChip(
                                            product.variant.category!,
                                            Icons.category),
                                    ],
                                  ),
                                ],
                              ),
                            ),

                            // Status and action
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                if (product.measurements.isNotEmpty)
                                  Container(
                                    margin: const EdgeInsets.only(right: 8),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF27AE60),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Icon(
                                          Icons.check_circle,
                                          size: 14,
                                          color: Colors.white,
                                        ),
                                        const SizedBox(width: 4),
                                        Text(
                                          '${product.measurements.length}',
                                          style: const TextStyle(
                                            fontSize: 11,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      selectedProduct = product;
                                      selectedProductIndex = index;
                                    });
                                    _initializeMeasurements();
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: isSelected
                                        ? const Color(0xFF6C5CE7)
                                        : product.measurements.isNotEmpty
                                            ? const Color(0xFF6C5CE7)
                                                .withOpacity(0.7)
                                            : const Color(0xFF636E72),
                                    foregroundColor: Colors.white,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 8),
                                    minimumSize: const Size(50, 32),
                                    elevation: 0,
                                  ),
                                  child: Text(
                                    isSelected
                                        ? 'Active'
                                        : product.measurements.isNotEmpty
                                            ? 'Edit'
                                            : 'Add',
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                ),
                              ],
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

  // Helper method to build variant chips
  Widget _buildVariantChip(String label, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
      decoration: BoxDecoration(
        color: const Color(0xFFF0F0F0),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: Colors.grey.shade300, width: 0.5),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 10, color: Colors.grey.shade600),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              color: Colors.grey.shade700,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
