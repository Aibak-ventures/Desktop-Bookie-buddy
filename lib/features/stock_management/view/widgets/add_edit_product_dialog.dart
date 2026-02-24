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
  final _salePriceController = TextEditingController(); // Sale price
  final _descriptionController = TextEditingController();
  final _lengthController = TextEditingController(); // For materials
  final _fabricTypeController = TextEditingController(); // For materials
  
  // Vehicle-specific fields
  final _registrationNumberController = TextEditingController();
  final _pollutionExpiryController = TextEditingController();
  final _insuranceExpiryController = TextEditingController();
  final _fitnessExpiryController = TextEditingController();
  final _barcodeController = TextEditingController();
  
  final _imageNotifier = ValueNotifier<XFile?>(null);
  final variantsNotifier = ValueNotifier<List<ProductVariantModel>>([]);

  // Variant form controllers
  final _variantSizeController = TextEditingController();
  final _variantStockController = TextEditingController();
  final _variantBarcodeController = TextEditingController();
  final _variantQrCodeController = TextEditingController();
  final _isAddingVariant = ValueNotifier<bool>(false);
  ProductVariantModel? _editingVariant;

  MainServiceType? mainServiceType;
  int? selectedServiceId;
  bool _servicesLoaded = false;

  @override
  void initState() {
    super.initState();
    _initializeServices();
  }

  void _initializeServices() {
    // Force reload services to get latest services for current shop
    context
        .read<ServiceBloc>()
        .add(const ServiceEvent.loadServices(force: true));

    final product = widget.product;

    // Use addPostFrameCallback to ensure state is updated after build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final services = context.read<ServiceBloc>().getServices();
      if (services.isNotEmpty && !_servicesLoaded) {
        setState(() {
          // For edit mode, use product's service type
          selectedServiceId = product?.mainServiceType != null
              ? services
                  .firstWhere(
                    (s) =>
                        MainServiceType.fromString(s.mainServiceName) ==
                        product!.mainServiceType,
                    orElse: () => services.first,
                  )
                  .id
              : widget.serviceId;

          mainServiceType = MainServiceType.fromServiceList(
            services,
            selectedServiceId,
          );
          _servicesLoaded = true;

          // Initialize product fields after mainServiceType is set
          if (product != null) {
            _nameController.text = product.name;
            // Set stock/unit field based on service type
            if (mainServiceType != null && !mainServiceType!.isDress) {
              _stockController.text = product.variants.first.stock.toString();
            }
            _modelController.text = product.model ?? '';
            _categoryController.text = product.category ?? '';
            _colorController.text = product.color ?? '';
            _priceController.text = product.price?.toString() ?? '';
            _salePriceController.text = product.salePrice ?? '';
            _purchaseAmountController.text =
                product.purchaseAmount?.toString() ?? '';
            _descriptionController.text = product.description ?? '';

            // Vehicle-specific fields initialization (read from attributes if needed)
            _registrationNumberController.text =
                product.effectiveRegistrationNumber ?? '';
            _pollutionExpiryController.text = product.effectivePollutionExpiry ?? '';
            _insuranceExpiryController.text = product.effectiveInsuranceExpiry ?? '';
            _fitnessExpiryController.text = product.effectiveFitnessExpiry ?? '';
            _barcodeController.text = product.effectiveBarcode ?? '';

            // Load existing variants for edit mode
            if (mainServiceType!.isDress && product.variants.isNotEmpty) {
              variantsNotifier.value = List.from(product.variants);
            }
          }
        });
      }
    });
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
                BlocConsumer<ServiceBloc, ServiceState>(
                  listener: (context, state) {
                    state.maybeWhen(
                      loaded: (services) {
                        if (services.isNotEmpty && !_servicesLoaded) {
                          setState(() {
                            if (selectedServiceId == null) {
                              selectedServiceId = widget.serviceId;
                            }
                            mainServiceType = MainServiceType.fromServiceList(
                              services,
                              selectedServiceId,
                            );
                            _servicesLoaded = true;
                          });
                        }
                      },
                      orElse: () {},
                    );
                  },
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

          // Variants section (show for both add and edit mode)
          _buildVariantsSection(),

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
    // Return empty until mainServiceType is loaded
    if (mainServiceType == null) {
      return const Center(child: CircularProgressIndicator());
    }

    // Common fields for all types: Image, Product Name, Purchase Price, Rent Price, Sale Price
    final commonFields = <Widget>[
      // Product Name
      SizedBox(
        width: 280,
        child: CustomTextField(
          label:
              '${mainServiceType!.isVehicle ? 'Vehicle' : mainServiceType!.isMaterial ? 'Material' : 'Product'} Name *',
          controller: _nameController,
          validator: AppInputValidators.productName,
        ),
      ),
    ];

    // Service-specific fields
    if (mainServiceType!.isDress || mainServiceType!.isCostume) {
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
            label: 'Sale Price (Optional)',
            controller: _salePriceController,
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
    } else if (mainServiceType!.isJewellery) {
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
            label: 'Sale Price (Optional)',
            controller: _salePriceController,
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
    } else if (mainServiceType!.isMaterial) {
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
            label: 'Sale Price (Optional)',
            controller: _salePriceController,
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
            label: mainServiceType!.isVehicle ? 'Unit' : 'Quantity',
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
            label: 'Sale Price (Optional)',
            controller: _salePriceController,
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
                '${mainServiceType!.isVehicle ? 'Brand' : 'Category'} (Optional)',
            controller: _categoryController,
            validator: (value) => AppInputValidators.isEmpty(value)
                ? null
                : AppInputValidators.category(
                    value,
                    fieldName:
                        mainServiceType!.isVehicle ? 'Brand' : 'Category',
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
      ]);

      // Add vehicle-specific fields if the service type is Vehicle
      if (mainServiceType!.isVehicle) {
        commonFields.addAll([
          SizedBox(
            width: 280,
            child: CustomTextField(
              label: 'Registration Number (Optional)',
              controller: _registrationNumberController,
              validator: null,
            ),
          ),
          SizedBox(
            width: 280,
            child: CustomTextField(
              label: 'Pollution Expiry (Optional)',
              controller: _pollutionExpiryController,
              validator: null,
              hintText: 'DD/MM/YYYY',
            ),
          ),
          SizedBox(
            width: 280,
            child: CustomTextField(
              label: 'Insurance Expiry (Optional)',
              controller: _insuranceExpiryController,
              validator: null,
              hintText: 'DD/MM/YYYY',
            ),
          ),
          SizedBox(
            width: 280,
            child: CustomTextField(
              label: 'Permit Expiry (Optional)',
              controller: _fitnessExpiryController,
              validator: null,
              hintText: 'DD/MM/YYYY',
            ),
          ),
        ]);
      }

      // Add description field at the end
      commonFields.add(
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
      );
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
                          mainServiceType?.isDress == true
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
    _variantQrCodeController.text = variant.externalQrCode ?? '';
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
    _variantQrCodeController.clear();
    _editingVariant = null;
    _isAddingVariant.value = false;
  }

  void _saveVariant() {
    final isGadget = mainServiceType?.isGadget == true;

    if (isGadget) {
      // Gadget: validate serial number
      if (_variantQrCodeController.text.trim().isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please enter a serial number')),
        );
        return;
      }

      final serialNumber = _variantQrCodeController.text.trim();
      final barcode = _variantBarcodeController.text.trim();
      final updatedVariants =
          List<ProductVariantModel>.from(variantsNotifier.value);

      if (_editingVariant != null) {
        final index =
            updatedVariants.indexWhere((v) => v.id == _editingVariant!.id);
        if (index != -1) {
          updatedVariants[index] = ProductVariantModel(
            id: _editingVariant!.id,
            attribute: serialNumber,
            stock: 1,
            remainingStock: _editingVariant!.remainingStock,
            externalQrCode: barcode.isEmpty ? null : barcode,
          );
        }
      } else {
        updatedVariants.add(
          ProductVariantModel(
            id: DateTime.now().millisecondsSinceEpoch,
            attribute: serialNumber,
            stock: 1,
            remainingStock: 1,
            externalQrCode: barcode.isEmpty ? null : barcode,
          ),
        );
      }

      variantsNotifier.value = updatedVariants;
      _cancelVariantForm();
      return;
    }

    // Default (non-gadget) variant save
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

    final externalQrCode = _variantQrCodeController.text.trim();

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
          externalQrCode: externalQrCode.isEmpty ? null : externalQrCode,
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
          externalQrCode: externalQrCode.isEmpty ? null : externalQrCode,
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
          if (mainServiceType?.isGadget == true) ...[
            // Gadgets: only Serial Number + Barcode
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: CustomTextField(
                    controller: _variantQrCodeController,
                    label: 'Serial Number *',
                    validator: null,
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
          ] else ...[
            // Default: Size/Variant Name + Stock + External QR Code
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
                    controller: _variantQrCodeController,
                    label: 'External QR Code (Optional)',
                    validator: null,
                  ),
                ),
              ],
            ),
          ],
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
    print('\n🚀 === SUBMIT STARTED ===');
    print('🔍 Form valid: ${_formKey.currentState?.validate()}');
    print('🔍 Is edit mode: ${widget.product != null}');
    print('🔍 Image available: ${_imageNotifier.value != null}');
    print('🔍 Product has existing image: ${widget.product?.image != null}');

    if (_formKey.currentState!.validate()) {
      // Validate service selection for new products
      if (widget.product == null && selectedServiceId == null) {
        print('❌ No service selected');
        context.showSnackBar("Please select a service category", isError: true);
        return;
      }

      // Image is required for NEW products, optional for EDIT (can keep existing)
      if (widget.product == null && _imageNotifier.value == null) {
        print('❌ No image provided for new product');
        context.showSnackBar("Please select an image", isError: true);
        return;
      }

      print('✅ All validations passed');

      // For dress/costume, variants are required
      if (mainServiceType?.isDress == true &&
          variantsNotifier.value.isEmpty &&
          widget.product == null) {
        print('❌ No variants for dress');
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
        // Edit mode: update existing product
        // For edit, we need to create a variant from the stock field if it's not a dress type
        List<ProductVariantModel>? editVariants;
        if (mainServiceType?.isDress == true) {
          // Dress type: variants already loaded
          editVariants = variantList.isEmpty ? null : variantList;
        } else {
          // Other types: create variant from stock field
          if (_stockController.text.trim().isNotEmpty) {
            final existingVariant = widget.product!.variants.first;
            editVariants = [
              ProductVariantModel(
                id: existingVariant.id,
                attribute: _nameController.text.trim(),
                stock: _stockController.text.trim().toInt(),
                remainingStock: existingVariant.remainingStock,
              ),
            ];
          }
        }

        final product = ProductRequestModel(
          productId: widget.product!.id, // Use ! since we're in the null check
          name: _nameController.text.trim(),
          description: _descriptionController.text.trim(),
          color: _colorController.text.trim(),
          purchasePrice: _purchaseAmountController.text.trim().toIntOrNull(),
          price: _priceController.text.trim().toIntOrNull(),
          salePrice: _salePriceController.text.trim().toIntOrNull(),
          category: _categoryController.text.trim(),
          model: _modelController.text.trim(),
          // Vehicle-specific fields (will be null if not vehicle)
          registrationNumber: _registrationNumberController.text.trim().isEmpty
              ? null
              : _registrationNumberController.text.trim(),
          pollutionExpiry: _pollutionExpiryController.text.trim().isEmpty
              ? null
              : _pollutionExpiryController.text.trim(),
          insuranceExpiry: _insuranceExpiryController.text.trim().isEmpty
              ? null
              : _insuranceExpiryController.text.trim(),
          fitnessExpiry: _fitnessExpiryController.text.trim().isEmpty
              ? null
              : _fitnessExpiryController.text.trim(),
          barcode: _barcodeController.text.trim().isEmpty
              ? null
              : _barcodeController.text.trim(),
          variants: editVariants,
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
          salePrice: _salePriceController.text.trim().toIntOrNull(),
          category: _categoryController.text.trim(),
          model: _modelController.text.trim(),
          // Vehicle-specific fields (will be null if not vehicle)
          registrationNumber: _registrationNumberController.text.trim().isEmpty
              ? null
              : _registrationNumberController.text.trim(),
          pollutionExpiry: _pollutionExpiryController.text.trim().isEmpty
              ? null
              : _pollutionExpiryController.text.trim(),
          insuranceExpiry: _insuranceExpiryController.text.trim().isEmpty
              ? null
              : _insuranceExpiryController.text.trim(),
          fitnessExpiry: _fitnessExpiryController.text.trim().isEmpty
              ? null
              : _fitnessExpiryController.text.trim(),
          barcode: _barcodeController.text.trim().isEmpty
              ? null
              : _barcodeController.text.trim(),
          variants: variantList,
          image: _imageNotifier.value,
        );
        saveCubit.saveProduct(product: product);
      }
    }
  }

  Future<void> _pickProductImage() async {
    try {
      print('📷 Starting image picker...');
      final result = await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowMultiple: false,
        dialogTitle: 'Select Product Image',
        withData: true, // Get bytes for all platforms
      );

      if (result != null && result.files.isNotEmpty) {
        print('📷 File picked: ${result.files.first.name}');
        Uint8List? imageBytes;
        String fileName;

        // Get image bytes
        if (result.files.first.bytes != null) {
          imageBytes = result.files.first.bytes!;
          fileName = result.files.first.name;
          print('📷 Got image bytes from web: ${imageBytes.length} bytes');
        } else if (result.files.first.path != null) {
          imageBytes = await XFile(result.files.first.path!).readAsBytes();
          fileName = result.files.first.name;
          print('📷 Got image bytes from path: ${imageBytes.length} bytes');
        } else {
          print('❌ No bytes or path available');
          return;
        }

        // Use custom crop dialog for all platforms
        // (image_cropper doesn't support Windows/macOS/Linux)
        print('📷 Opening crop dialog...');
        final croppedBytes = await _showImageCropDialog(imageBytes, fileName);
        if (croppedBytes != null) {
          print('📷 Image cropped: ${croppedBytes.length} bytes');
          final processedBytes = await _compressImage(croppedBytes);
          if (processedBytes != null) {
            print('📷 Image compressed: ${processedBytes.length} bytes');

            // Ensure filename has .jpg extension (since we compress to JPEG)
            String finalFileName = fileName;
            if (!fileName.toLowerCase().endsWith('.jpg') &&
                !fileName.toLowerCase().endsWith('.jpeg')) {
              // Replace extension with .jpg
              final nameParts = fileName.split('.');
              if (nameParts.length > 1) {
                nameParts.removeLast();
                finalFileName = '${nameParts.join('.')}.jpg';
              } else {
                finalFileName = '$fileName.jpg';
              }
            }

            print('📷 Final filename: $finalFileName');
            _imageNotifier.value = XFile.fromData(
              processedBytes,
              name: finalFileName,
              mimeType: 'image/jpeg',
            );
            print(
                '✅ Image set successfully with name: ${_imageNotifier.value?.name}');
          } else {
            print('❌ Failed to compress image');
          }
        } else {
          print('⚠️ Crop cancelled');
        }
      } else {
        print('⚠️ No file selected');
      }
    } catch (e) {
      debugPrint('❌ Error picking image: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to select image: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  /// Show custom crop dialog (works on all platforms)
  Future<Uint8List?> _showImageCropDialog(
      Uint8List imageBytes, String fileName) async {
    final image = img.decodeImage(imageBytes);
    if (image == null) return null;

    return await showDialog<Uint8List>(
      context: context,
      builder: (context) => _ImageCropDialog(
        imageBytes: imageBytes,
        image: image,
      ),
    );
  }

  /// Compress image after cropping
  Future<Uint8List?> _compressImage(Uint8List imageBytes) async {
    try {
      // Decode the image
      img.Image? image = img.decodeImage(imageBytes);
      if (image == null) return null;

      // Resize if too large (max 1024x1024 for good quality)
      if (image.width > 1024 || image.height > 1024) {
        image = img.copyResize(image, width: 1024, height: 1024);
      }

      // Encode to JPEG with compression (flutter_image_compress doesn't work on Windows)
      final jpegBytes = img.encodeJpg(image, quality: 85);
      return Uint8List.fromList(jpegBytes);
    } catch (e) {
      debugPrint('Error compressing image: $e');
      return imageBytes; // Return original if compression fails
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
    _salePriceController.dispose();
    _descriptionController.dispose();
    _lengthController.dispose();
    _fabricTypeController.dispose();
    _registrationNumberController.dispose();
    _pollutionExpiryController.dispose();
    _insuranceExpiryController.dispose();
    _fitnessExpiryController.dispose();
    _barcodeController.dispose();
    _variantSizeController.dispose();
    _variantStockController.dispose();
    _variantBarcodeController.dispose();
    _variantQrCodeController.dispose();
    variantsNotifier.dispose();
    _imageNotifier.dispose();
    _isAddingVariant.dispose();
    super.dispose();
  }
}

/// Custom image crop dialog for web
class _ImageCropDialog extends StatefulWidget {
  final Uint8List imageBytes;
  final img.Image image;

  const _ImageCropDialog({
    required this.imageBytes,
    required this.image,
  });

  @override
  State<_ImageCropDialog> createState() => _ImageCropDialogState();
}

class _ImageCropDialogState extends State<_ImageCropDialog> {
  Rect? _cropRect;
  Offset _dragStart = Offset.zero;
  double _scale = 1.0;

  @override
  void initState() {
    super.initState();
    // Initialize with center square crop
    final size = widget.image.width < widget.image.height
        ? widget.image.width
        : widget.image.height;
    final left = (widget.image.width - size) / 2;
    final top = (widget.image.height - size) / 2;
    _cropRect = Rect.fromLTWH(left, top, size.toDouble(), size.toDouble());
  }

  void _cropAndReturn() async {
    if (_cropRect == null) return;

    final cropped = img.copyCrop(
      widget.image,
      x: _cropRect!.left.toInt(),
      y: _cropRect!.top.toInt(),
      width: _cropRect!.width.toInt(),
      height: _cropRect!.height.toInt(),
    );

    final jpegBytes = img.encodeJpg(cropped, quality: 90);
    Navigator.of(context).pop(Uint8List.fromList(jpegBytes));
  }

  void _onPanUpdate(DragUpdateDetails details, double displaySize) {
    if (_cropRect == null) return;

    setState(() {
      // Calculate scale to fit image in display
      final scaleX = displaySize / widget.image.width;
      final scaleY = displaySize / widget.image.height;
      final scale = scaleX < scaleY ? scaleX : scaleY;

      // Convert display delta to image coordinates
      final dx = details.delta.dx / scale;
      final dy = details.delta.dy / scale;

      // Calculate new position
      var newLeft = _cropRect!.left + dx;
      var newTop = _cropRect!.top + dy;

      // Keep crop rect within image bounds
      newLeft = newLeft.clamp(0.0, widget.image.width - _cropRect!.width);
      newTop = newTop.clamp(0.0, widget.image.height - _cropRect!.height);

      _cropRect = Rect.fromLTWH(
        newLeft,
        newTop,
        _cropRect!.width,
        _cropRect!.height,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    // Calculate max size that fits the screen (leave space for header, text, buttons)
    final reservedHeight = 300; // Space for header, text, buttons, padding
    final availableHeight = screenSize.height * 0.8 - reservedHeight;
    final availableWidth = screenSize.width * 0.7;

    // Use the smaller dimension to ensure it fits
    final maxDisplaySize =
        availableWidth < availableHeight ? availableWidth : availableHeight;

    // Ensure minimum size
    final displaySize = maxDisplaySize < 300 ? 300.0 : maxDisplaySize;

    return Dialog(
      child: Container(
        constraints: BoxConstraints(
          maxWidth: displaySize + 100,
          maxHeight: screenSize.height * 0.85,
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Crop Image (1:1)',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.purple,
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(Icons.close),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Text(
                  'Drag the purple square to adjust the crop area.',
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
                const SizedBox(height: 16),

                // Image with crop overlay
                MouseRegion(
                  cursor: SystemMouseCursors.move,
                  child: GestureDetector(
                    onPanUpdate: (details) =>
                        _onPanUpdate(details, displaySize),
                    child: Container(
                      width: displaySize,
                      height: displaySize,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Stack(
                          children: [
                            // Background image
                            Positioned.fill(
                              child: Image.memory(
                                widget.imageBytes,
                                fit: BoxFit.contain,
                              ),
                            ),
                            // Crop overlay
                            if (_cropRect != null)
                              CustomPaint(
                                size: Size(displaySize, displaySize),
                                painter: _CropOverlayPainter(
                                  cropRect: _cropRect!,
                                  imageSize: Size(
                                    widget.image.width.toDouble(),
                                    widget.image.height.toDouble(),
                                  ),
                                  displaySize: Size(displaySize, displaySize),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // Action buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('Cancel'),
                    ),
                    const SizedBox(width: 12),
                    ElevatedButton.icon(
                      onPressed: _cropAndReturn,
                      icon: const Icon(Icons.crop, size: 18),
                      label: const Text('Crop & Continue'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.purple,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Custom painter for crop overlay
class _CropOverlayPainter extends CustomPainter {
  final Rect cropRect;
  final Size imageSize;
  final Size displaySize;

  _CropOverlayPainter({
    required this.cropRect,
    required this.imageSize,
    required this.displaySize,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Calculate scale to fit image in display
    final scaleX = displaySize.width / imageSize.width;
    final scaleY = displaySize.height / imageSize.height;
    final scale = scaleX < scaleY ? scaleX : scaleY;

    // Calculate scaled image position
    final scaledWidth = imageSize.width * scale;
    final scaledHeight = imageSize.height * scale;
    final offsetX = (displaySize.width - scaledWidth) / 2;
    final offsetY = (displaySize.height - scaledHeight) / 2;

    // Scale crop rect to display size
    final displayCropRect = Rect.fromLTWH(
      cropRect.left * scale + offsetX,
      cropRect.top * scale + offsetY,
      cropRect.width * scale,
      cropRect.height * scale,
    );

    // Draw dark overlay outside crop area
    final overlayPaint = Paint()
      ..color = Colors.black.withOpacity(0.5)
      ..style = PaintingStyle.fill;

    // Top
    canvas.drawRect(
      Rect.fromLTWH(0, 0, displaySize.width, displayCropRect.top),
      overlayPaint,
    );
    // Bottom
    canvas.drawRect(
      Rect.fromLTWH(
        0,
        displayCropRect.bottom,
        displaySize.width,
        displaySize.height - displayCropRect.bottom,
      ),
      overlayPaint,
    );
    // Left
    canvas.drawRect(
      Rect.fromLTWH(
        0,
        displayCropRect.top,
        displayCropRect.left,
        displayCropRect.height,
      ),
      overlayPaint,
    );
    // Right
    canvas.drawRect(
      Rect.fromLTWH(
        displayCropRect.right,
        displayCropRect.top,
        displaySize.width - displayCropRect.right,
        displayCropRect.height,
      ),
      overlayPaint,
    );

    // Draw crop border
    final borderPaint = Paint()
      ..color = AppColors.purple
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;

    canvas.drawRect(displayCropRect, borderPaint);

    // Draw grid lines
    final gridPaint = Paint()
      ..color = Colors.white.withOpacity(0.5)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    // Vertical lines
    canvas.drawLine(
      Offset(displayCropRect.left + displayCropRect.width / 3,
          displayCropRect.top),
      Offset(displayCropRect.left + displayCropRect.width / 3,
          displayCropRect.bottom),
      gridPaint,
    );
    canvas.drawLine(
      Offset(displayCropRect.left + displayCropRect.width * 2 / 3,
          displayCropRect.top),
      Offset(displayCropRect.left + displayCropRect.width * 2 / 3,
          displayCropRect.bottom),
      gridPaint,
    );

    // Horizontal lines
    canvas.drawLine(
      Offset(displayCropRect.left,
          displayCropRect.top + displayCropRect.height / 3),
      Offset(displayCropRect.right,
          displayCropRect.top + displayCropRect.height / 3),
      gridPaint,
    );
    canvas.drawLine(
      Offset(displayCropRect.left,
          displayCropRect.top + displayCropRect.height * 2 / 3),
      Offset(displayCropRect.right,
          displayCropRect.top + displayCropRect.height * 2 / 3),
      gridPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
