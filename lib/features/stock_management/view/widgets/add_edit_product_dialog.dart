import 'dart:typed_data';

import 'package:bookie_buddy_web/core/app_input_validators.dart';
import 'package:bookie_buddy_web/core/enums/service_type_enums.dart';
import 'package:bookie_buddy_web/core/extensions/context_extensions.dart';
import 'package:bookie_buddy_web/core/extensions/string_extensions.dart';
import 'package:bookie_buddy_web/core/models/product_model/product_model.dart';
import 'package:bookie_buddy_web/core/models/product_model/product_variant_model.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:bookie_buddy_web/core/ui/widgets/custom_button.dart';
import 'package:bookie_buddy_web/core/ui/widgets/custom_network_image.dart';
import 'package:bookie_buddy_web/core/ui/widgets/custom_snack_bar.dart';
import 'package:bookie_buddy_web/core/ui/widgets/custom_textfield.dart';
import 'package:bookie_buddy_web/core/view_model/bloc_service/service_bloc.dart';
import 'package:bookie_buddy_web/features/product/models/product_request_model/product_request_model.dart';
import 'package:bookie_buddy_web/features/product/view/widgets/variants_widget.dart';
import 'package:bookie_buddy_web/features/product/view_model/cubit_save_product/save_product_cubit.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';

/// Modal dialog for adding or editing products
/// This is a web-optimized modal version of the AddOrEditProductScreen
class AddEditProductDialog extends StatefulWidget {
  final int? serviceId;
  final ProductModel? product;

  const AddEditProductDialog({
    this.serviceId,
    this.product,
    super.key,
  });

  @override
  State<AddEditProductDialog> createState() => _AddEditProductDialogState();
}

class _AddEditProductDialogState extends State<AddEditProductDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _stockController = TextEditingController();
  final _colorController = TextEditingController();
  final _modelController = TextEditingController();
  final _categoryController = TextEditingController();
  final _purchaseAmountController = TextEditingController();
  final _priceController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _lengthController = TextEditingController(); // For materials
  final _fabricTypeController = TextEditingController(); // For materials
  final _imageNotifier = ValueNotifier<XFile?>(null);
  final variantsNotifier = ValueNotifier<List<ProductVariantModel>>([]);

  // Variant form controllers
  final _variantSizeController = TextEditingController();
  final _variantStockController = TextEditingController();
  final _variantBarcodeController = TextEditingController();
  final _isAddingVariant = ValueNotifier<bool>(false);
  ProductVariantModel? _editingVariant;

  late MainServiceType mainServiceType;
  int? selectedServiceId;

  @override
  void initState() {
    super.initState();
    // Force reload services to get latest services for current shop
    context
        .read<ServiceBloc>()
        .add(const ServiceEvent.loadServices(force: true));

    final services = context.read<ServiceBloc>().getServices();
    selectedServiceId = widget.serviceId;
    mainServiceType = MainServiceType.fromServiceList(
      services,
      widget.serviceId,
    );

    final product = widget.product;
    if (product != null) {
      _nameController.text = product.name;
      if (!mainServiceType.isDress) {
        _stockController.text = product.variants.first.stock.toString();
      }
      _modelController.text = product.model ?? '';
      _categoryController.text = product.category ?? '';
      _colorController.text = product.color ?? '';
      _priceController.text = product.price?.toString() ?? '';
      _purchaseAmountController.text = product.purchaseAmount?.toString() ?? '';
      _descriptionController.text = product.description ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isEditMode = widget.product?.id != null;
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final dialogWidth = screenWidth > 1200 ? 1100.0 : screenWidth * 0.9;
    final dialogHeight = screenHeight * 0.80; // Increased for variants section

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
      child: Container(
        width: dialogWidth,
        height: dialogHeight,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              decoration: BoxDecoration(
                color: AppColors.purple.withOpacity(0.05),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
                border: Border(
                  bottom: BorderSide(color: Colors.grey.shade200),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    isEditMode ? Icons.edit : Icons.add_box,
                    color: AppColors.purple,
                    size: 28,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    isEditMode ? 'Edit Product' : 'Add New Product',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Colors.black87,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.close),
                    tooltip: 'Close',
                  ),
                ],
              ),
            ),
            // Body
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(24, 20, 24, 24),
                child: _buildForm(context, isEditMode),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildForm(BuildContext context, bool isEditMode) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Service Type Dropdown (only for new products)
          if (!isEditMode)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Select Service Category *',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 8),
                BlocBuilder<ServiceBloc, ServiceState>(
                  builder: (context, state) {
                    return state.maybeWhen(
                      loaded: (services) {
                        // Ensure selectedServiceId is valid or null
                        final validServiceId = selectedServiceId != null &&
                                services.any((s) => s.id == selectedServiceId)
                            ? selectedServiceId
                            : null;

                        return Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade300),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<int>(
                              isExpanded: true,
                              value: validServiceId,
                              hint: const Text('Choose a service category'),
                              items: services.map((service) {
                                return DropdownMenuItem<int>(
                                  value: service.id,
                                  child: Text(service.name),
                                );
                              }).toList(),
                              onChanged: (value) {
                                if (value != null) {
                                  setState(() {
                                    selectedServiceId = value;
                                    mainServiceType =
                                        MainServiceType.fromServiceList(
                                      services,
                                      value,
                                    );
                                  });
                                }
                              },
                            ),
                          ),
                        );
                      },
                      orElse: () => const CircularProgressIndicator(),
                    );
                  },
                ),
                const SizedBox(height: 20),
              ],
            ),

          // Two-column layout: Image on left, form fields on right
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Left column - Image picker (smaller)
              _buildImagePicker(context),
              const SizedBox(width: 24),

              // Right column - Dynamic form fields based on service type
              Expanded(
                child: _buildDynamicFields(),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Variants section (for all service types when adding new product)
          if (widget.product == null) _buildVariantsSection(),

          const SizedBox(height: 20),

          // Action buttons
          BlocConsumer<SaveProductCubit, SaveProductState>(
            listener: (context, state) {
              state.maybeWhen(
                orElse: () {},
                error: (error) => context.showSnackBar(error, isError: true),
                success: () {
                  Navigator.of(context)
                      .pop(true); // Return true to refresh list
                  context.showSnackBar(
                    isEditMode
                        ? "Product updated successfully"
                        : "Product added successfully",
                    isError: false,
                  );
                },
              );
            },
            builder: (context, state) {
              final isLoading = state.maybeWhen(
                submitted: () => true,
                orElse: () => false,
              );
              return Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CustomElevatedButton(
                    text: 'Cancel',
                    onPressed:
                        isLoading ? () {} : () => Navigator.of(context).pop(),
                    width: 140,
                    height: 45,
                    backgroundColor: Colors.grey.shade300,
                    textColor: Colors.black87,
                  ),
                  const SizedBox(width: 12),
                  CustomElevatedButton(
                    text: isEditMode ? 'Update Product' : 'Add Product',
                    onPressed: isLoading ? () {} : _submit,
                    width: 160,
                    height: 45,
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  /// Build dynamic fields based on selected service type
  Widget _buildDynamicFields() {
    // Common fields for all types: Image, Product Name, Purchase Price, Rent Price, Sale Price
    final commonFields = <Widget>[
      // Product Name
      SizedBox(
        width: 280,
        child: CustomTextField(
          label:
              '${mainServiceType.isVehicle ? 'Vehicle' : mainServiceType.isMaterial ? 'Material' : 'Product'} Name *',
          controller: _nameController,
          validator: AppInputValidators.productName,
        ),
      ),
    ];

    // Service-specific fields
    if (mainServiceType.isDress || mainServiceType.isCostume) {
      // DRESSES/COSTUME: Size (via variants), Purchase, Rent, Sale, Category, Color, Model, Description
      commonFields.addAll([
        SizedBox(
          width: 280,
          child: CustomTextField(
            label: 'Purchase Amount (Optional)',
            controller: _purchaseAmountController,
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
            controller: _priceController,
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
            controller: _categoryController,
            validator: (value) => AppInputValidators.isEmpty(value)
                ? null
                : AppInputValidators.category(value,
                    fieldName: 'Category', isRequired: false),
          ),
        ),
        SizedBox(
          width: 280,
          child: CustomTextField(
            label: 'Color (Optional)',
            controller: _colorController,
            validator: (value) => AppInputValidators.isEmpty(value)
                ? null
                : AppInputValidators.color(value),
          ),
        ),
        SizedBox(
          width: 280,
          child: CustomTextField(
            label: 'Model (Optional)',
            controller: _modelController,
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
            controller: _descriptionController,
            validator: (value) => AppInputValidators.isEmpty(value)
                ? null
                : AppInputValidators.description(value),
          ),
        ),
      ]);
    } else if (mainServiceType.isJewellery) {
      // JEWELLERY: Quantity, Purchase Price, Rent Price, Sale, Category, Color, Model, Description
      commonFields.addAll([
        SizedBox(
          width: 280,
          child: CustomTextField(
            label: 'Quantity',
            controller: _stockController,
            keyboardType: TextInputType.number,
            validator: (value) =>
                AppInputValidators.quantity(value, allowZero: true),
          ),
        ),
        SizedBox(
          width: 280,
          child: CustomTextField(
            label: 'Purchase Price (Optional)',
            controller: _purchaseAmountController,
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
            controller: _priceController,
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
            controller: _categoryController,
            validator: (value) => AppInputValidators.isEmpty(value)
                ? null
                : AppInputValidators.category(value,
                    fieldName: 'Category', isRequired: false),
          ),
        ),
        SizedBox(
          width: 280,
          child: CustomTextField(
            label: 'Color (Optional)',
            controller: _colorController,
            validator: (value) => AppInputValidators.isEmpty(value)
                ? null
                : AppInputValidators.color(value),
          ),
        ),
        SizedBox(
          width: 280,
          child: CustomTextField(
            label: 'Model (Optional)',
            controller: _modelController,
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
            controller: _descriptionController,
            validator: (value) => AppInputValidators.isEmpty(value)
                ? null
                : AppInputValidators.description(value),
          ),
        ),
      ]);
    } else if (mainServiceType.isMaterial) {
      // MATERIAL: Length, Purchase Price, Rent Price, Sale, Fabric Type, Color, Model (Optional), Description (Optional)
      commonFields.addAll([
        SizedBox(
          width: 280,
          child: CustomTextField(
            label: 'Length',
            controller: _lengthController,
            keyboardType: TextInputType.number,
            validator: (value) => AppInputValidators.onEmpty(value, 'Length'),
          ),
        ),
        SizedBox(
          width: 280,
          child: CustomTextField(
            label: 'Purchase Price (Optional)',
            controller: _purchaseAmountController,
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
            controller: _priceController,
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
            controller: _fabricTypeController,
            validator: (value) =>
                AppInputValidators.onEmpty(value, 'Fabric Type'),
          ),
        ),
        SizedBox(
          width: 280,
          child: CustomTextField(
            label: 'Color (Optional)',
            controller: _colorController,
            validator: (value) => AppInputValidators.isEmpty(value)
                ? null
                : AppInputValidators.color(value),
          ),
        ),
        SizedBox(
          width: 280,
          child: CustomTextField(
            label: 'Model (Optional)',
            controller: _modelController,
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
            controller: _descriptionController,
            validator: (value) => AppInputValidators.isEmpty(value)
                ? null
                : AppInputValidators.description(value),
          ),
        ),
      ]);
    } else {
      // DEFAULT (Vehicles, Gadgets, Equipment, etc.): Quantity/Unit, Purchase, Rent, Sale, Brand/Category, Color, Model, Description
      commonFields.addAll([
        SizedBox(
          width: 280,
          child: CustomTextField(
            label: mainServiceType.isVehicle ? 'Unit' : 'Quantity',
            controller: _stockController,
            keyboardType: TextInputType.number,
            validator: (value) =>
                AppInputValidators.quantity(value, allowZero: true),
          ),
        ),
        SizedBox(
          width: 280,
          child: CustomTextField(
            label: 'Purchase Amount (Optional)',
            controller: _purchaseAmountController,
            keyboardType: TextInputType.number,
            validator: (value) => AppInputValidators.isEmpty(value)
                ? null
                : AppInputValidators.amount(value, allowZero: true),
          ),
        ),
        SizedBox(
          width: 280,
          child: CustomTextField(
            label: 'Selling Price (Optional)',
            controller: _priceController,
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
            controller: _categoryController,
            validator: (value) => AppInputValidators.isEmpty(value)
                ? null
                : AppInputValidators.category(
                    value,
                    fieldName: mainServiceType.isVehicle ? 'Brand' : 'Category',
                    isRequired: false,
                  ),
          ),
        ),
        SizedBox(
          width: 280,
          child: CustomTextField(
            label: 'Color (Optional)',
            controller: _colorController,
            validator: (value) => AppInputValidators.isEmpty(value)
                ? null
                : AppInputValidators.color(value),
          ),
        ),
        SizedBox(
          width: 280,
          child: CustomTextField(
            label: 'Model (Optional)',
            controller: _modelController,
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
            controller: _descriptionController,
            validator: (value) => AppInputValidators.isEmpty(value)
                ? null
                : AppInputValidators.description(value),
          ),
        ),
      ]);
    }

    return Wrap(
      runSpacing: 16,
      spacing: 16,
      children: commonFields,
    );
  }

  /// Build variants section for managing product variants
  Widget _buildVariantsSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Product Variants',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              ValueListenableBuilder<bool>(
                valueListenable: _isAddingVariant,
                builder: (context, isAdding, child) {
                  return ElevatedButton.icon(
                    onPressed: isAdding ? null : () => _startAddingVariant(),
                    icon: const Icon(Icons.add, size: 18),
                    label: const Text('Add Variant'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.purple,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Inline variant form
          ValueListenableBuilder<bool>(
            valueListenable: _isAddingVariant,
            builder: (context, isAdding, child) {
              if (!isAdding) return const SizedBox.shrink();
              return _buildVariantForm();
            },
          ),

          // Variants list
          ValueListenableBuilder<List<ProductVariantModel>>(
            valueListenable: variantsNotifier,
            builder: (context, variants, child) {
              if (variants.isEmpty) {
                return Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey.shade200),
                  ),
                  child: Center(
                    child: Column(
                      children: [
                        Icon(Icons.inventory_2_outlined,
                            size: 48, color: Colors.grey.shade400),
                        const SizedBox(height: 12),
                        Text(
                          mainServiceType.isDress
                              ? 'No variants added yet. Add sizes for this dress.'
                              : 'No variants added. Product will use default quantity.',
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }

              return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: Column(
                  children: [
                    // Header row
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(8),
                        ),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Text(
                              'Size/Variant',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.grey.shade700,
                                fontSize: 13,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              'Stock',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.grey.shade700,
                                fontSize: 13,
                              ),
                            ),
                          ),
                          const SizedBox(width: 80),
                        ],
                      ),
                    ),

                    // Variant rows
                    ...variants.asMap().entries.map((entry) {
                      final index = entry.key;
                      final variant = entry.value;
                      final isLast = index == variants.length - 1;

                      return Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: isLast
                                ? BorderSide.none
                                : BorderSide(color: Colors.grey.shade200),
                          ),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Text(
                                variant.attribute,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                variant.stock.toString(),
                                style: const TextStyle(fontSize: 14),
                              ),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  onPressed: () =>
                                      _startEditingVariant(variant),
                                  icon:
                                      const Icon(Icons.edit_outlined, size: 18),
                                  tooltip: 'Edit',
                                  color: AppColors.purple,
                                ),
                                IconButton(
                                  onPressed: () => _deleteVariant(variant.id),
                                  icon: const Icon(Icons.delete_outline,
                                      size: 18),
                                  tooltip: 'Delete',
                                  color: Colors.red,
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  void _startAddingVariant() {
    _variantSizeController.clear();
    _variantStockController.clear();
    _variantBarcodeController.clear();
    _editingVariant = null;
    _isAddingVariant.value = true;
  }

  void _startEditingVariant(ProductVariantModel variant) {
    _variantSizeController.text = variant.attribute;
    _variantStockController.text = variant.stock.toString();
    _variantBarcodeController.clear();
    _editingVariant = variant;
    _isAddingVariant.value = true;

    // Scroll to the form
    Future.delayed(const Duration(milliseconds: 100), () {
      Scrollable.ensureVisible(
        context,
        alignment: 0.0,
        duration: const Duration(milliseconds: 300),
      );
    });
  }

  void _cancelVariantForm() {
    _variantSizeController.clear();
    _variantStockController.clear();
    _variantBarcodeController.clear();
    _editingVariant = null;
    _isAddingVariant.value = false;
  }

  void _saveVariant() {
    if (_variantSizeController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter variant name/size')),
      );
      return;
    }

    if (_variantStockController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter stock quantity')),
      );
      return;
    }

    final stock = int.tryParse(_variantStockController.text.trim());
    if (stock == null || stock < 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid stock quantity')),
      );
      return;
    }

    final updatedVariants =
        List<ProductVariantModel>.from(variantsNotifier.value);

    if (_editingVariant != null) {
      // Update existing variant
      final index =
          updatedVariants.indexWhere((v) => v.id == _editingVariant!.id);
      if (index != -1) {
        updatedVariants[index] = ProductVariantModel(
          id: _editingVariant!.id,
          attribute: _variantSizeController.text.trim(),
          stock: stock,
          remainingStock: _editingVariant!.remainingStock,
        );
      }
    } else {
      // Add new variant
      updatedVariants.add(
        ProductVariantModel(
          id: DateTime.now().millisecondsSinceEpoch,
          attribute: _variantSizeController.text.trim(),
          stock: stock,
          remainingStock: stock,
        ),
      );
    }

    variantsNotifier.value = updatedVariants;
    _cancelVariantForm();
  }

  Widget _buildVariantForm() {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.purple.withOpacity(0.3), width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                _editingVariant != null ? Icons.edit : Icons.add_circle_outline,
                color: AppColors.purple,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                _editingVariant != null ? 'Edit Variant' : 'Add New Variant',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.purple,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: CustomTextField(
                  controller: _variantSizeController,
                  label: 'Size / Variant Name *',
                  validator: (value) =>
                      AppInputValidators.onEmpty(value, 'Size'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: CustomTextField(
                  controller: _variantStockController,
                  label: 'Stock Quantity *',
                  keyboardType: TextInputType.number,
                  validator: (value) =>
                      AppInputValidators.quantity(value, allowZero: false),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                flex: 2,
                child: CustomTextField(
                  controller: _variantBarcodeController,
                  label: 'Barcode (Optional)',
                  validator: null,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: _cancelVariantForm,
                child: const Text('Cancel'),
              ),
              const SizedBox(width: 8),
              ElevatedButton.icon(
                onPressed: _saveVariant,
                icon: Icon(
                  _editingVariant != null ? Icons.check : Icons.add,
                  size: 18,
                ),
                label: Text(_editingVariant != null ? 'Update' : 'Add'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.purple,
                  foregroundColor: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _deleteVariant(int variantId) {
    variantsNotifier.value =
        variantsNotifier.value.where((v) => v.id != variantId).toList();
  }

  Widget _buildImagePicker(BuildContext context) {
    return ValueListenableBuilder<XFile?>(
      valueListenable: _imageNotifier,
      builder: (context, image, child) {
        Widget imageWidget;
        if (image != null) {
          // Use FutureBuilder to read bytes for both Web and Mobile to avoid dart:io dependency
          // This is safe everywhere.
          imageWidget = FutureBuilder<Uint8List>(
            future: image.readAsBytes(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Image.memory(snapshot.data!, fit: BoxFit.cover);
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          );
        } else if (widget.product?.image != null) {
          imageWidget = CustomNetworkImage(imageUrl: widget.product!.image!);
        } else {
          imageWidget = const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.add_photo_alternate_rounded,
                    size: 32, color: AppColors.purpleLight),
                SizedBox(height: 6),
                Text(
                  "Add image",
                  style: TextStyle(
                    color: AppColors.purpleLight,
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          );
        }

        return GestureDetector(
          onTap: () async => await _pickProductImage(),
          child: Container(
            width: 250,
            height: 250,
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade300),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade200,
                  blurRadius: 6,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            clipBehavior: Clip.antiAlias,
            child: imageWidget,
          ),
        );
      },
    );
  }

  void _submit() async {
    if (_formKey.currentState!.validate()) {
      // Validate service selection for new products
      if (widget.product == null && selectedServiceId == null) {
        context.showSnackBar("Please select a service category", isError: true);
        return;
      }

      if (widget.product?.image == null && _imageNotifier.value == null) {
        context.showSnackBar("Please select an image", isError: true);
        return;
      }

      // For dress/costume, variants are required
      if (mainServiceType.isDress &&
          variantsNotifier.value.isEmpty &&
          widget.product == null) {
        context.showSnackBar(
            "Please add at least one size variant for this dress",
            isError: true);
        return;
      }

      // For new products: use variants if added, otherwise create default variant from stock
      final variantList =
          List<ProductVariantModel>.from(variantsNotifier.value);

      if (variantList.isEmpty && widget.product == null) {
        // If no variants added, create a default variant using stock quantity
        if (_stockController.text.trim().isEmpty) {
          context.showSnackBar("Please enter stock quantity or add variants",
              isError: true);
          return;
        }
        variantList.add(
          ProductVariantModel(
            id: DateTime.now().millisecondsSinceEpoch,
            attribute: _nameController.text.trim(),
            stock: _stockController.text.trim().toInt(),
            remainingStock: _stockController.text.trim().toInt(),
          ),
        );
      }

      final saveCubit = context.read<SaveProductCubit>();

      if (widget.product != null) {
        final product = ProductRequestModel(
          productId: widget.product?.id,
          name: _nameController.text.trim(),
          description: _descriptionController.text.trim(),
          color: _colorController.text.trim(),
          purchasePrice: _purchaseAmountController.text.trim().toIntOrNull(),
          price: _priceController.text.trim().toIntOrNull(),
          category: _categoryController.text.trim(),
          model: _modelController.text.trim(),
          variants: variantList.isEmpty ? null : variantList,
          image: _imageNotifier.value,
        );
        saveCubit.saveProduct(product: product);
      } else {
        final product = ProductRequestModel(
          serviceId: selectedServiceId,
          name: _nameController.text.trim(),
          description: _descriptionController.text.trim(),
          color: _colorController.text.trim(),
          purchasePrice: _purchaseAmountController.text.trim().toIntOrNull(),
          price: _priceController.text.trim().toIntOrNull(),
          category: _categoryController.text.trim(),
          model: _modelController.text.trim(),
          variants: variantList,
          image: _imageNotifier.value,
        );
        saveCubit.saveProduct(product: product);
      }
    }
  }

  Future<void> _pickProductImage() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowMultiple: false,
        dialogTitle: 'Select Product Image',
        withData: true, // Crucial for Web to get bytes
      );

      if (result != null && result.files.isNotEmpty) {
        Uint8List? imageBytes;
        String fileName;

        if (kIsWeb) {
          if (result.files.first.bytes != null) {
            imageBytes = result.files.first.bytes!;
            fileName = result.files.first.name;
          } else {
            return;
          }
        } else {
          if (result.files.single.path != null) {
            final file = result.files.single;
            imageBytes = await XFile(file.path!).readAsBytes();
            fileName = file.name;
          } else {
            return;
          }
        }

        if (imageBytes != null) {
          // Process image: crop to 1:1 and compress
          final processedBytes = await _processImage(imageBytes);
          if (processedBytes != null) {
            _imageNotifier.value = XFile.fromData(
              processedBytes,
              name: fileName,
            );
          }
        }
      }
    } catch (e) {
      debugPrint('Error picking image: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to select image. Please try again.'),
          ),
        );
      }
    }
  }

  /// Process image: crop to 1:1 aspect ratio and compress
  Future<Uint8List?> _processImage(Uint8List imageBytes) async {
    try {
      // Decode the image
      img.Image? image = img.decodeImage(imageBytes);
      if (image == null) return null;

      // Crop to 1:1 (square) aspect ratio
      final size = image.width < image.height ? image.width : image.height;
      final xOffset = (image.width - size) ~/ 2;
      final yOffset = (image.height - size) ~/ 2;

      img.Image cropped = img.copyCrop(
        image,
        x: xOffset,
        y: yOffset,
        width: size,
        height: size,
      );

      // Resize if too large (max 1024x1024 for good quality)
      if (cropped.width > 1024) {
        cropped = img.copyResize(cropped, width: 1024, height: 1024);
      }

      // Encode to JPEG with compression
      final jpegBytes = img.encodeJpg(cropped, quality: 85);

      // Further compress using flutter_image_compress
      final compressedBytes = await FlutterImageCompress.compressWithList(
        Uint8List.fromList(jpegBytes),
        minWidth: 1024,
        minHeight: 1024,
        quality: 85,
        format: CompressFormat.jpeg,
      );

      return compressedBytes;
    } catch (e) {
      debugPrint('Error processing image: $e');
      return imageBytes; // Return original if processing fails
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _stockController.dispose();
    _colorController.dispose();
    _modelController.dispose();
    _categoryController.dispose();
    _purchaseAmountController.dispose();
    _priceController.dispose();
    _descriptionController.dispose();
    _lengthController.dispose();
    _fabricTypeController.dispose();
    _variantSizeController.dispose();
    _variantStockController.dispose();
    _variantBarcodeController.dispose();
    variantsNotifier.dispose();
    _imageNotifier.dispose();
    _isAddingVariant.dispose();
    super.dispose();
  }
}
