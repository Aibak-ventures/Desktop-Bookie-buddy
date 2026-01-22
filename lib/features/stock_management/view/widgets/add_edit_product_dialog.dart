import 'dart:io';
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
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
  final _imageNotifier = ValueNotifier<File?>(null);
  final variantsNotifier = ValueNotifier<List<ProductVariantModel>>([]);
  late final MainServiceType mainServiceType;

  @override
  void initState() {
    super.initState();
    final services = context.read<ServiceBloc>().getServices();
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
    final dialogHeight = screenHeight * 0.65;

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
                padding: const EdgeInsets.fromLTRB(32, 20, 32, 24),
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
          // Two-column layout: Image on left, form fields on right
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Left column - Image picker (smaller)
              _buildImagePicker(context),
              const SizedBox(width: 24),

              // Right column - Form fields
              Expanded(
                child: Wrap(
                  runSpacing: 16,
                  spacing: 16,
                  children: [
                    SizedBox(
                      width: 280,
                      child: CustomTextField(
                        label:
                            '${mainServiceType.isVehicle ? 'Vehicle' : 'Product'} name',
                        controller: _nameController,
                        validator: AppInputValidators.productName,
                      ),
                    ),
                    if (!mainServiceType.isDress)
                      SizedBox(
                        width: 280,
                        child: CustomTextField(
                          label:
                              mainServiceType.isVehicle ? 'Unit' : 'Quantity',
                          controller: _stockController,
                          keyboardType: TextInputType.number,
                          validator: (value) => mainServiceType.isDress
                              ? null
                              : AppInputValidators.quantity(value,
                                  allowZero: true),
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
                                fieldName: mainServiceType.isVehicle
                                    ? 'Brand'
                                    : 'Category',
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
              // minLines: 2,
              controller: _descriptionController,
              validator: (value) => AppInputValidators.isEmpty(value)
                  ? null
                  : AppInputValidators.description(value),
            ),
          ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Description field - full width but smaller
        
          const SizedBox(height: 20),

          // Variants section (for dress type)
          if (mainServiceType.isDress && widget.product == null)
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(10),
              ),
              child: VariantsWidget(
                variantsNotifier: variantsNotifier,
              ),
            ),

          if (mainServiceType.isDress && widget.product == null)
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
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed:
                          isLoading ? null : () => Navigator.of(context).pop(),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'Cancel',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    flex: 2,
                    child: CustomElevatedButton(
                      onPressed: _submit,
                      text: isEditMode ? 'Update Product' : 'Add Product',
                      isLoading: isLoading,
                      loadingText: 'Saving...',
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildImagePicker(BuildContext context) {
    return ValueListenableBuilder<File?>(
      valueListenable: _imageNotifier,
      builder: (context, image, child) {
        final imageWidget = image != null
            ? Image.file(image, fit: BoxFit.cover)
            : widget.product?.image != null
                ? CustomNetworkImage(imageUrl: widget.product!.image!)
                : const Center(
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
      if (widget.product?.image == null && _imageNotifier.value == null) {
        CustomSnackBar(message: "Please select an image");
        return;
      }

      if (mainServiceType.isDress &&
          variantsNotifier.value.isEmpty &&
          widget.product == null) {
        CustomSnackBar(message: "Please add at least one variant");
        return;
      }

      final variantList =
          List<ProductVariantModel>.from(variantsNotifier.value);

      if (!mainServiceType.isDress) {
        variantList.clear();
        variantList.add(
          ProductVariantModel(
            id: widget.product?.variants.firstOrNull?.id ?? 0,
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
          serviceId: widget.serviceId,
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
      }
    }
  }

  Future<void> _pickProductImage() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowMultiple: false,
        dialogTitle: 'Select Product Image',
      );

      if (result != null && result.files.single.path != null) {
        _imageNotifier.value = File(result.files.single.path!);
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
    variantsNotifier.dispose();
    _imageNotifier.dispose();
    super.dispose();
  }
}
