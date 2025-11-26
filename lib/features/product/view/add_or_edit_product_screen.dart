import 'dart:io';
import 'package:bookie_buddy_web/core/app_input_validators.dart';
import 'package:bookie_buddy_web/core/enums/service_type_enums.dart';
import 'package:bookie_buddy_web/core/extensions/context_extensions.dart';
import 'package:bookie_buddy_web/core/extensions/string_extensions.dart';
import 'package:bookie_buddy_web/core/models/product_model/product_model.dart';
import 'package:bookie_buddy_web/core/models/product_model/product_variant_model.dart';
import 'package:bookie_buddy_web/core/ui/widgets/custom_network_image.dart';
import 'package:bookie_buddy_web/core/ui/widgets/custom_snack_bar.dart';
import 'package:bookie_buddy_web/core/view_model/bloc_service/service_bloc.dart';
import 'package:bookie_buddy_web/features/product/models/product_request_model/product_request_model.dart';
import 'package:bookie_buddy_web/features/product/view/widgets/variants_widget.dart';
import 'package:bookie_buddy_web/features/product/view_model/cubit_save_product/save_product_cubit.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/ui/widgets/custom_button.dart';
import '../../../core/ui/widgets/custom_textfield.dart';

class AddOrEditProductScreen extends StatefulWidget {
  final int serviceId;
  final ProductModel? product;

  const AddOrEditProductScreen({
    required this.serviceId,
    this.product,
    super.key,
  });

  @override
  _AddOrEditProductScreenState createState() => _AddOrEditProductScreenState();
}

class _AddOrEditProductScreenState extends State<AddOrEditProductScreen> {
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

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: _onPopInvokedWithResult,
      child: Scaffold(
        backgroundColor: const Color(0xFFF5F7FA),
        appBar: AppBar(
          title: Text(isEditMode ? 'Edit Product' : 'Add Product'),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black87,
        ),
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
            child: Container(
              constraints: const BoxConstraints(maxWidth: 1400),
              padding: const EdgeInsets.all(40),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade300.withOpacity(0.4),
                    blurRadius: 10,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: _buildForm(context, isEditMode),
            ),
          ),
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
          _buildImagePicker(context),
          const SizedBox(height: 40),
          Text(
            '${isEditMode ? "Edit" : "Add"} Product Details',
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 30),

          // Main form fields
          Wrap(
            runSpacing: 20,
            spacing: 20,
            children: [
              SizedBox(
                width: 420,
                child: CustomTextField(
                  label:
                      '${mainServiceType.isVehicle ? 'Vehicle' : 'Product'} name',
                  controller: _nameController,
                  validator: AppInputValidators.productName,
                ),
              ),
              if (!mainServiceType.isDress)
                SizedBox(
                  width: 420,
                  child: CustomTextField(
                    label: mainServiceType.isVehicle ? 'Unit' : 'Quantity',
                    controller: _stockController,
                    keyboardType: TextInputType.number,
                    validator: (value) => mainServiceType.isDress
                        ? null
                        : AppInputValidators.quantity(value, allowZero: true),
                  ),
                ),
              SizedBox(
                width: 420,
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
                width: 420,
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
                width: 420,
                child: CustomTextField(
                  label:
                      '${mainServiceType.isVehicle ? 'Brand' : 'Category'} (Optional)',
                  controller: _categoryController,
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
                width: 420,
                child: CustomTextField(
                  label: 'Color (Optional)',
                  controller: _colorController,
                  validator: (value) => AppInputValidators.isEmpty(value)
                      ? null
                      : AppInputValidators.color(value),
                ),
              ),
              SizedBox(
                width: 420,
                child: CustomTextField(
                  label: 'Model (Optional)',
                  controller: _modelController,
                  validator: (value) => AppInputValidators.isEmpty(value)
                      ? null
                      : AppInputValidators.model(value),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          if (mainServiceType.isDress && widget.product == null)
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(10),
              ),
              child: VariantsWidget(
                variantsNotifier: variantsNotifier,
              ),
            ),

          const SizedBox(height: 30),
          CustomTextField(
            label: 'Description (Optional)',
            maxLines: 5,
            minLines: 3,
            controller: _descriptionController,
            validator: (value) => AppInputValidators.isEmpty(value)
                ? null
                : AppInputValidators.description(value),
          ),
          const SizedBox(height: 40),

          // Save Button
          BlocConsumer<SaveProductCubit, SaveProductState>(
            listener: (context, state) {
              state.maybeWhen(
                orElse: () {},
                error: (error) => context.showSnackBar(error, isError: true),
                success: () {
                  context.pop(isEditMode ? true : _nameController.text.trim());
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
              return SizedBox(
                width: double.infinity,
                child: CustomElevatedButton(
                  onPressed: _submit,
                  text: isEditMode ? 'Update Product' : 'Add Product',
                  isLoading: isLoading,
                  loadingText: 'Saving...',
                ),
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
                            size: 50, color: AppColors.purpleLight),
                        SizedBox(height: 8),
                        Text(
                          "Click to add image",
                          style: TextStyle(
                            color: AppColors.purpleLight,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  );

        return GestureDetector(
          onTap: () async => await _pickProductImage(),
          child: Center(
            child: AspectRatio(
              aspectRatio: 1.0,
              child: Container(
                constraints: const BoxConstraints(maxWidth: 400),
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
            ),
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

  void _onPopInvokedWithResult(bool didPop, Object? result) async {
    if (didPop) return;

    final product = widget.product;
    bool hasChanges = false;

    if (product == null) {
      hasChanges = _nameController.text.trim().isNotEmpty ||
          _stockController.text.trim().isNotEmpty ||
          _colorController.text.trim().isNotEmpty ||
          _modelController.text.trim().isNotEmpty ||
          _categoryController.text.trim().isNotEmpty ||
          _purchaseAmountController.text.trim().isNotEmpty ||
          _priceController.text.trim().isNotEmpty ||
          _descriptionController.text.trim().isNotEmpty ||
          variantsNotifier.value.isNotEmpty ||
          _imageNotifier.value != null;
    } else {
      hasChanges = !isStringEquals(product.name, _nameController.text) ||
          !isStringEquals(product.model, _modelController.text) ||
          !isStringEquals(product.category, _categoryController.text) ||
          !isStringEquals(product.color, _colorController.text) ||
          !isStringEquals(product.description, _descriptionController.text) ||
          product.price
              .toString()
              .hasNumberChangedComparedTo(_priceController.text) ||
          product.purchaseAmount
              .toString()
              .hasNumberChangedComparedTo(_purchaseAmountController.text) ||
          (!mainServiceType.isDress &&
              product.variants.first.stock.toString() !=
                  _stockController.text.trim()) ||
          _imageNotifier.value != null;
    }

    if (!hasChanges) {
      Navigator.of(context).pop();
      return;
    }

    final discard = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Discard changes?'),
        content: const Text(
          'You have unsaved changes. Are you sure you want to go back?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            child: const Text(
              'Discard',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );

    if (discard == true) {
      Navigator.of(context).pop();
    }
  }

  bool isStringEquals(String? a, String? b) {
    if (a == null || b == null) return false;
    return a.trim() == b.trim();
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
