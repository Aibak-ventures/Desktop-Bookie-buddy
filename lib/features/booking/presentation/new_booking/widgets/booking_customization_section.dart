import 'package:bookie_buddy_web/core/constants/enums/gender_type_enums.dart';
import 'package:bookie_buddy_web/utils/extensions/string_extensions.dart';
import 'package:bookie_buddy_web/features/booking/domain/models/measurement_field_model.dart';
import 'package:bookie_buddy_web/features/booking/domain/models/measurement_value_model/measurement_value_model.dart';
import 'package:bookie_buddy_web/features/booking/presentation/common/widgets/add_customization_screen.dart'; // For getMeasurements
import 'package:bookie_buddy_web/features/select_product_booking/domain/models/product_selected_model/product_selected_model.dart';
import 'package:flutter/material.dart';

class BookingCustomizationSection extends StatefulWidget {
  final List<ProductSelectedModel> selectedProducts;
  final Function(ProductSelectedModel, List<MeasurementValueModel>)
      onUpdateMeasurements;
  final VoidCallback onBack;

  const BookingCustomizationSection({
    super.key,
    required this.selectedProducts,
    required this.onUpdateMeasurements,
    required this.onBack,
  });

  @override
  State<BookingCustomizationSection> createState() =>
      _BookingCustomizationSectionState();
}

class _BookingCustomizationSectionState
    extends State<BookingCustomizationSection> {
  // Currently selected product for customization
  ProductSelectedModel? _selectedProduct;

  // Controllers for the right panel
  final ValueNotifier<List<MeasurementFieldModel>> _measurementsNotifier =
      ValueNotifier([]);
  final ValueNotifier<GenderType> _genderNotifier =
      ValueNotifier(GenderType.female);
  final TextEditingController _customMeasurementController =
      TextEditingController();
  // final GlobalKey<FormState> _customMeasurementFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    if (widget.selectedProducts.isNotEmpty) {
      _selectProduct(widget.selectedProducts.first);
    }
  }

  @override
  void dispose() {
    _disposeControllers();
    _customMeasurementController.dispose();
    _genderNotifier.dispose();
    _measurementsNotifier.dispose();
    super.dispose();
  }

  void _disposeControllers() {
    for (var field in _measurementsNotifier.value) {
      field.controller.dispose();
    }
  }

  void _selectProduct(ProductSelectedModel product) {
    setState(() {
      _selectedProduct = product;
    });
    _loadMeasurementsForProduct(product);
  }

  void _loadMeasurementsForProduct(ProductSelectedModel product) {
    // 1. Determine Gender
    // Try to infer gender from existing measurements or default to Female/Unisex
    if (product.measurements.isNotEmpty) {
      final genders = product.measurements.map((e) => e.gender).toSet();
      final filteredGenders =
          genders.where((g) => g != GenderType.unisex).toSet();

      if (filteredGenders.length == 1) {
        _genderNotifier.value = filteredGenders.first ?? GenderType.female;
      } else {
        // Default or keep previous? Let's default to female as per screenshot
        _genderNotifier.value = GenderType.female;
      }
    } else {
      _genderNotifier.value = GenderType.female; // Default
    }

    // 2. Prepare Fields
    final baseMeasurements = getMeasurements(); // From AddCustomizationScreen
    final savedMeasurements = product.measurements;

    // Dispose old controllers first?
    _disposeControllers();

    final updatedMeasurements = baseMeasurements.map((field) {
      // Find saved value if any
      final existing = savedMeasurements.firstWhere(
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

    // Add custom measurements
    final customMeasurements = savedMeasurements
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

    _measurementsNotifier.value = [
      ...updatedMeasurements,
      ...customMeasurements,
    ];
  }

  void _saveMeasurements() {
    if (_selectedProduct == null) return;

    final filteredMeasurements = _measurementsNotifier.value
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

    widget.onUpdateMeasurements(_selectedProduct!, filteredMeasurements);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Measurements saved successfully'),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFF5F6FA),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left Side: Product List
          Expanded(
            flex: 5,
            child: _buildProductList(),
          ),
          const SizedBox(width: 16),
          // Right Side: Customization Form
          SizedBox(
            width: 350, // Fixed width as per design roughly
            child: _buildCustomizationPanel(),
          ),
        ],
      ),
    );
  }

  Widget _buildProductList() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        children: [
          // Table Header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
            child: Row(
              children: [
                const Expanded(
                  flex: 3,
                  child: Text(
                    'items',
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                  ),
                ),
                const Expanded(
                  flex: 1,
                  child: Center(
                    child: Text(
                      'Variants',
                      style:
                          TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    alignment: Alignment.center,
                    // decoration: BoxDecoration(
                    //   color: Colors.grey.shade200,
                    //   borderRadius: BorderRadius.circular(4),
                    // ),
                    child: const Text(
                      'Customization',
                      style:
                          TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // List Items
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(0),
              itemCount: widget.selectedProducts.length,
              separatorBuilder: (_, __) =>
                  Divider(height: 1, color: Colors.grey.shade200),
              itemBuilder: (context, index) {
                final product = widget.selectedProducts[index];
                final isSelected = _selectedProduct == product;
                return _buildProductRow(product, isSelected);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductRow(ProductSelectedModel product, bool isSelected) {
    return Container(
      color: isSelected ? const Color(0xFFEBE4FF) : Colors.white, // Highlight
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: Container(
                    width: 48,
                    height: 48,
                    color: Colors.grey.shade100,
                    child: product.variant.image != null
                        ? Image.network(
                            product.variant.image!,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) =>
                                const Icon(Icons.image, size: 24),
                          )
                        : const Icon(Icons.image, size: 24),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.variant.name,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        '${product.variant.color ?? ''}, ${product.variant.model ?? ''}',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade600,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: Text(
                product.variant.variantAttribute ?? 'Standard',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: SizedBox(
                height: 30,
                child: ElevatedButton(
                  onPressed: () => _selectProduct(product),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isSelected
                        ? const Color(0xFF6132E4).withOpacity(0.2)
                        : const Color(0xFFE5FFEA),
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  child: Text(
                    isSelected ? 'Edit' : 'Add',
                    style: TextStyle(
                      color:
                          isSelected ? const Color(0xFF6132E4) : Colors.green,
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCustomizationPanel() {
    if (_selectedProduct == null) {
      return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: const Center(child: Text("Select a product to customize")),
      );
    }

    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5), // Light grey background as in image
        borderRadius: BorderRadius.circular(10),
        // border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: const Center(
              child: Text(
                'Customization',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
            ),
          ),
          const Divider(height: 1, color: Colors.grey),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildGenderSelector(),
                  const SizedBox(height: 20),
                  _buildMeasurementsFields(),
                  const SizedBox(height: 30),
                  // Add Custom Measurements
                  const Text(
                    'Add custom measurements',
                    style: TextStyle(fontSize: 13, color: Colors.black87),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 40,
                          decoration: BoxDecoration(
                            color: const Color(0xFFEBE4FF).withOpacity(0.5),
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(color: Colors.grey.shade300),
                          ),
                          child: TextField(
                            controller: _customMeasurementController,
                            style: const TextStyle(fontSize: 13),
                            decoration: const InputDecoration(
                              hintText: 'Eg: Neck, Sleeve',
                              hintStyle: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 13), // Fixed font size
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 12), // Adjusted
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      InkWell(
                        onTap: () {
                          if (_customMeasurementController.text
                              .trim()
                              .isNotEmpty) {
                            final name =
                                _customMeasurementController.text.trim();
                            // Add logic to add controller
                            final newKey =
                                name.toLowerCase().trim().replaceAll(' ', '_');
                            setState(() {
                              _measurementsNotifier.value = [
                                ..._measurementsNotifier.value,
                                MeasurementFieldModel(
                                  name: name.capitalizeFirstLetter(),
                                  key: newKey,
                                  description: '',
                                  gender: GenderType.unisex,
                                  controller: TextEditingController(),
                                )
                              ];
                            });
                            _customMeasurementController.clear();
                          }
                        },
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            color: const Color(0xFFEBE4FF).withOpacity(0.5),
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(color: Colors.grey.shade300),
                          ),
                          child: const Icon(Icons.add, color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  // Save Button
                  SizedBox(
                    width: double.infinity,
                    height: 45,
                    child: ElevatedButton(
                      onPressed: _saveMeasurements,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFF5F5F5),
                        foregroundColor: const Color(0xFF6132E4),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                          side: const BorderSide(color: Color(0xFF6132E4)),
                        ),
                      ),
                      child: const Text(
                        'Save measurements',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Back Button (Optional, since we have save)
                  // Center(
                  //   child: TextButton(
                  //     onPressed: widget.onBack,
                  //     child: const Text('Back to items'),
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGenderSelector() {
    return ValueListenableBuilder<GenderType>(
      valueListenable: _genderNotifier,
      builder: (context, gender, _) {
        return Row(
          children: [
            const SizedBox(
              width: 110,
              child: Text(
                'Measurement for :',
                style: TextStyle(fontSize: 13, color: Colors.black87),
              ),
            ),
            const Text(" : ",
                style: TextStyle(fontSize: 13, color: Colors.black87)),
            const SizedBox(width: 10),
            SizedBox(
              width: 140,
              child: Container(
                height: 36,
                padding: const EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 237, 237, 237),
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<GenderType>(
                    value: gender,
                    isExpanded: true,
                    icon: const Icon(Icons.keyboard_arrow_down, size: 18),
                    items: GenderType.values
                        .map((g) => DropdownMenuItem(
                              value: g,
                              child: Text(g.name.toUpperCase(),
                                  style: const TextStyle(fontSize: 12)),
                            ))
                        .toList(),
                    onChanged: (val) {
                      if (val != null) _genderNotifier.value = val;
                    },
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildMeasurementsFields() {
    return ValueListenableBuilder(
      valueListenable: _measurementsNotifier,
      builder: (context, fields, _) {
        final gender = _genderNotifier.value;
        final relevantFields = fields.where((f) {
          if (gender == GenderType.unisex) return true;
          if (f.gender == GenderType.unisex) return true;
          return f.gender == gender;
        }).toList();

        return Column(
          children: relevantFields.map((field) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                children: [
                  SizedBox(
                    width: 110,
                    child: Text(
                      field.name,
                      style:
                          const TextStyle(fontSize: 13, color: Colors.black87),
                    ),
                  ),
                  const Text(" : ",
                      style: TextStyle(fontSize: 13, color: Colors.black87)),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 237, 237, 237),
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: TextField(
                        controller: field.controller,
                        style: const TextStyle(fontSize: 13),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 12), // Adjusted
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        );
      },
    );
  }
}
