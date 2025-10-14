import 'dart:io';

import 'package:bookie_buddy_web/core/app_input_validators.dart';
import 'package:bookie_buddy_web/core/enums/enums.dart';
import 'package:bookie_buddy_web/core/enums/service_type_enums.dart';
import 'package:bookie_buddy_web/core/extensions/context_extensions.dart';
import 'package:bookie_buddy_web/core/extensions/number_extensions.dart';
import 'package:bookie_buddy_web/core/extensions/string_extensions.dart';
import 'package:bookie_buddy_web/core/extensions/widget_extensions.dart';
import 'package:bookie_buddy_web/core/models/product_model/product_model.dart';
import 'package:bookie_buddy_web/core/models/product_model/product_variant_model.dart';
import 'package:bookie_buddy_web/core/ui/widgets/custom_network_image.dart';
import 'package:bookie_buddy_web/core/ui/widgets/custom_snack_bar.dart';
import 'package:bookie_buddy_web/core/view_model/bloc_service/service_bloc.dart';
import 'package:bookie_buddy_web/features/product/models/product_request_model/product_request_model.dart';
import 'package:bookie_buddy_web/features/product/view/widgets/variants_widget.dart';
import 'package:bookie_buddy_web/features/product/view_model/cubit_save_product/save_product_cubit.dart';
import 'package:bookie_buddy_web/utils/pick_and_compress_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/ui/widgets/custom_button.dart';
import '../../../core/ui/widgets/custom_textfield.dart';

class AddOrEditProductScreen extends StatefulWidget {
  final int serviceId;
  final ProductModel? product;

  AddOrEditProductScreen({
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
    print(product);
    if (product != null) {
      _nameController.text = product.name;
      if (!mainServiceType.isDress) {
        _stockController.text = product.variants.first.stock.toString();
      } else {
        // variantsNotifier.value = product.variants;
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
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            isEditMode ? 'Edit Product' : 'Add Product',
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: context.isMobile ? 24.padding : (60, 40).padding,
            child: Column(
              children: [
                ValueListenableBuilder(
                  valueListenable: _imageNotifier,
                  builder: (context, image, child) {
                    return AspectRatio(
                      aspectRatio: 1,
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: 10.radiusBorder,
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 10,
                              color: AppColors.grey300,
                              spreadRadius: 2,
                            )
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: 10.radiusBorder,
                          child: image != null
                              ? Image.file(image, fit: BoxFit.cover)
                              : widget.product?.image != null
                                  ? CustomNetworkImage(
                                      imageUrl: widget.product!.image!)
                                  : const Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.add_photo_alternate_rounded,
                                          size: 50,
                                          color: AppColors.purpleLight,
                                        ),
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
                        ),
                      ).onTap(
                        () async {
                          await showImageBottomSheet(context);
                        },
                      ),
                    );
                  },
                ),
                const SizedBox(height: 40),
                Form(
                  key: _formKey,
                  child: Column(
                    spacing: 16,
                    children: [
                      //name
                      CustomTextField(
                        label:
                            '${mainServiceType.isVehicle ? 'Vehicle' : 'Product'} name',
                        controller: _nameController,
                        validator: AppInputValidators.productName,
                      ),

                      if (mainServiceType.isDress && widget.product == null)
                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Add variants',
                                  style: TextStyle(
                                    fontSize: 18.sp,
                                  ),
                                ),
                              ],
                            ),

                            //Variants
                            VariantsWidget(
                              variantsNotifier: variantsNotifier,
                            ),
                          ],
                        ),

                      // quantity
                      if (!mainServiceType.isDress)
                        CustomTextField(
                          label:
                              mainServiceType.isVehicle ? 'Unit' : 'Quantity',
                          controller: _stockController,
                          keyboardType: TextInputType.number,
                          validator: (value) => mainServiceType.isDress
                              ? null
                              : AppInputValidators.quantity(
                                  value,
                                  allowZero: true,
                                ),
                        ),

                      CustomTextField(
                        label: 'Purchase amount (Optional)',
                        controller: _purchaseAmountController,
                        keyboardType: TextInputType.number,
                        validator: (value) => AppInputValidators.isEmpty(value)
                            ? null
                            : AppInputValidators.amount(
                                value,
                                allowZero: true,
                              ),
                      ),
                      CustomTextField(
                        label: 'Selling Price (Optional)',
                        controller: _priceController,
                        keyboardType: TextInputType.number,
                        validator: (value) => AppInputValidators.isEmpty(value)
                            ? null
                            : AppInputValidators.amount(
                                value,
                                allowZero: true,
                              ),
                      ),
                      CustomTextField(
                        label:
                            '${mainServiceType.isVehicle ? 'Brand' : 'Category'} (Optional)',
                        controller: _categoryController,
                        validator: (value) => AppInputValidators.isEmpty(value)
                            ? null
                            : AppInputValidators.category(
                                value,
                                mainServiceType.isVehicle
                                    ? 'Brand'
                                    : 'Category',
                              ),
                      ),

                      CustomTextField(
                        label: 'Color (Optional)',
                        controller: _colorController,
                        validator: (value) => AppInputValidators.isEmpty(value)
                            ? null
                            : AppInputValidators.color(value),
                      ),

                      CustomTextField(
                        label: 'Model (Optional)',
                        controller: _modelController,
                        validator: (value) => AppInputValidators.isEmpty(value)
                            ? null
                            : AppInputValidators.model(value),
                      ),

                      CustomTextField(
                        label: 'Description (Optional)',
                        maxLines: 10,
                        minLines: 2,
                        controller: _descriptionController,
                        validator: (value) => AppInputValidators.isEmpty(value)
                            ? null
                            : AppInputValidators.description(value),
                      ),

                      1.height,

                      // save button
                      BlocConsumer<SaveProductCubit, SaveProductState>(
                        listener: (context, state) {
                          state.maybeWhen(
                            orElse: () {},
                            error: (error) => context.showSnackBar(
                              error,
                              isError: true,
                            ),
                            success: () {
                              context.pop(
                                isEditMode ? true : _nameController.text.trim(),
                              );
                              context.showSnackBar(
                                widget.product?.id == null
                                    ? "Product added successfully"
                                    : "Product updated successfully",
                                isError: false,
                              );
                            },
                          );
                        },
                        builder: (context, state) {
                          final isLoading = state.maybeWhen(
                            orElse: () => false,
                            submitted: () => true,
                          );
                          return CustomElevatedButton(
                            onPressed: _submit, // submit function
                            loadingText: 'Saving...',
                            isLoading: isLoading,
                            text: isEditMode ? 'Update Product' : 'Add Product',
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
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
        // Non-dress → Single variant only
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

      if (widget.product != null) {
        // Editing Existing Product

        // Check changed fields
        final bool isNameChanged =
            !isStringEquals(widget.product?.name, _nameController.text);
        final bool isPriceChanged = widget.product!.price
            .toString()
            .hasNumberChangedComparedTo(_priceController.text);

        final isActualPriceChanged = widget.product!.purchaseAmount
            .toString()
            .hasNumberChangedComparedTo(_purchaseAmountController.text);

        final bool isDescriptionChanged = !isStringEquals(
          widget.product?.description,
          _descriptionController.text,
        );
        final bool isModelChanged =
            !isStringEquals(widget.product?.model, _modelController.text);
        final bool isCategoryChanged =
            !isStringEquals(widget.product?.category, _categoryController.text);
        final bool isColorChanged =
            !isStringEquals(widget.product?.color, _colorController.text);
        final isStockChanged = !isStringEquals(
          widget.product?.variants.first.stock.toString(),
          _stockController.text.trim(),
        );
        final bool isImageChanged = _imageNotifier.value != null;
        // Check variant changes
        // final diffVariants = variantsNotifier.value
        //     .where(
        //       (newVariant) => !widget.product!.variants.any(
        //         (oldVariant) =>
        //             oldVariant.attribute == newVariant.attribute &&
        //             oldVariant.stock == newVariant.stock,
        //       ),
        //     )
        //     .toList();

        // If no changes → show message and return
        if (!isNameChanged &&
            !isModelChanged &&
            !isCategoryChanged &&
            !isColorChanged &&
            !isImageChanged &&
            !isPriceChanged &&
            !isActualPriceChanged &&
            !isDescriptionChanged &&
            !isStockChanged) {
          context.pop();
          context.showSnackBar(
            "No changes made to product",
          );
          return;
        }

        final product = ProductRequestModel(
          productId: widget.product?.id,
          name: isNameChanged ? _nameController.text.trim() : null,
          description:
              isDescriptionChanged ? _descriptionController.text.trim() : null,
          color: isColorChanged ? _colorController.text.trim() : null,
          purchasePrice: isActualPriceChanged
              ? _purchaseAmountController.text.trim().toIntOrNull()
              : null,
          price: isPriceChanged
              ? _priceController.text.trim().toIntOrNull()
              : null,
          category: isCategoryChanged ? _categoryController.text.trim() : null,
          model: isModelChanged ? _modelController.text.trim() : null,
          variants: variantList.isEmpty ? null : variantList,
          image: isImageChanged ? _imageNotifier.value : null,
        );

        // Prepare request only with changed fields
        context.read<SaveProductCubit>().saveProduct(
              product: product,
            );
      } else {
        // Add New Product

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
          productId: widget.product?.id,
        );

        context.read<SaveProductCubit>().saveProduct(
              product: product,
            );
      }
    }
  }

  bool isStringEquals(String? a, String? b) {
    if (a == null || b == null) return false;
    return a.trim() == b.trim();
  }

  Future<void> showImageBottomSheet(BuildContext context) async {
    return showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        return Padding(
          padding: 20.padding,
          child: Wrap(
            alignment: WrapAlignment.center,
            children: [
              Text("Select Image",
                  style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 15),
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text("Camera"),
                onTap: () async {
                  context.pop();
                  final image = await pickAndCompressImage(
                    context: context,
                    source: ImageSource.camera,
                  );
                  if (image != null) _imageNotifier.value = image;
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text("Gallery"),
                onTap: () async {
                  context.pop();
                  final image = await pickAndCompressImage(
                    context: context,
                    source: ImageSource.gallery,
                  );
                  if (image != null) _imageNotifier.value = image;
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    // controllers
    _nameController.dispose();
    _stockController.dispose();
    _colorController.dispose();
    _modelController.dispose();
    _categoryController.dispose();
    _purchaseAmountController.dispose();
    _priceController.dispose();
    _descriptionController.dispose();

    // notifiers
    variantsNotifier.dispose();
    _imageNotifier.dispose();

    super.dispose();
  }

  void _onPopInvokedWithResult(bool didPop, Object? result) async {
    if (didPop) return; // Pop already handled → do nothing

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
            child: const Text(
              'Discard',
              style: TextStyle(
                color: AppColors.white,
              ),
            ),
          ),
        ],
      ),
    );

    if (discard == true) {
      Navigator.of(context).pop();
    }
  }
}
