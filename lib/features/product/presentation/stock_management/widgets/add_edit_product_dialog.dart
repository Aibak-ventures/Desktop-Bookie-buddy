import 'package:bookie_buddy_web/features/product/presentation/stock_management/bloc/save_product_cubit/save_product_cubit.dart';
import 'package:bookie_buddy_web/core/constants/enums/service_type_enums.dart';
import 'package:bookie_buddy_web/utils/extensions/context_extensions.dart';
import 'package:bookie_buddy_web/utils/extensions/string_extensions.dart';
import 'package:bookie_buddy_web/features/product/domain/entities/product_entity/product_entity.dart';
import 'package:bookie_buddy_web/features/product/domain/entities/product_variant_entity/product_variant_entity.dart';
import 'package:bookie_buddy_web/features/shop/domain/entities/service_entity/service_entity.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:bookie_buddy_web/core/common/widgets/custom_button.dart';
import 'package:bookie_buddy_web/features/shop/presentation/bloc/service_bloc/service_bloc.dart';
import 'package:bookie_buddy_web/features/product/domain/entities/product_request_entity/product_request_entity.dart';
import 'package:bookie_buddy_web/features/product/presentation/stock_management/widgets/product_dynamic_fields.dart';
import 'package:bookie_buddy_web/features/product/presentation/stock_management/widgets/product_image_crop_dialog.dart';
import 'package:bookie_buddy_web/features/product/presentation/stock_management/widgets/product_image_picker_section.dart';
import 'package:bookie_buddy_web/features/product/presentation/stock_management/widgets/product_variants_section.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';

/// Modal dialog for adding or editing products.
/// This is a web-optimized modal version of the AddOrEditProductScreen.
class AddEditProductDialog extends StatefulWidget {
  final int? serviceId;
  final ProductEntity? product;

  const AddEditProductDialog({this.serviceId, this.product, super.key});

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
  final _salePriceController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _lengthController = TextEditingController();
  final _fabricTypeController = TextEditingController();

  // Vehicle-specific fields
  final _registrationNumberController = TextEditingController();
  final _pollutionExpiryController = TextEditingController();
  final _insuranceExpiryController = TextEditingController();
  final _fitnessExpiryController = TextEditingController();
  final _barcodeController = TextEditingController();

  final _imageNotifier = ValueNotifier<XFile?>(null);
  final variantsNotifier = ValueNotifier<List<ProductVariantEntity>>([]);

  MainServiceType? mainServiceType;
  int? selectedServiceId;
  bool _servicesLoaded = false;

  @override
  void initState() {
    super.initState();
    _initializeServices();
  }

  List<ServiceEntity> _uniqueServices(List<ServiceEntity> services) {
    final Map<int, ServiceEntity> uniqueById = <int, ServiceEntity>{};
    for (final service in services) {
      uniqueById.putIfAbsent(service.id, () => service);
    }
    return uniqueById.values.toList();
  }

  void _initializeServices() {
    context.read<ServiceBloc>().add(
      const ServiceEvent.loadServices(force: true),
    );

    final product = widget.product;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final services = _uniqueServices(context.read<ServiceBloc>().getServices());
      if (services.isNotEmpty && !_servicesLoaded) {
        setState(() {
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

          if (product != null) {
            _nameController.text = product.name;
            if (mainServiceType != null &&
                !mainServiceType!.needsVariantsSection) {
              _stockController.text = product.variants.isNotEmpty
                  ? product.variants.first.stock.toString()
                  : '';
            }
            _modelController.text = product.model ?? '';
            _categoryController.text = product.category ?? '';
            _colorController.text = product.color ?? '';
            _priceController.text = product.price?.toString() ?? '';
            _salePriceController.text = product.salePrice ?? '';
            _purchaseAmountController.text =
                product.purchaseAmount?.toString() ?? '';
            _descriptionController.text = product.description ?? '';
            _registrationNumberController.text =
                product.effectiveRegistrationNumber ?? '';
            _pollutionExpiryController.text =
                product.effectivePollutionExpiry ?? '';
            _insuranceExpiryController.text =
                product.effectiveInsuranceExpiry ?? '';
            _fitnessExpiryController.text =
                product.effectiveFitnessExpiry ?? '';
            _barcodeController.text = product.effectiveBarcode ?? '';

            if (mainServiceType!.needsVariantsSection &&
                product.variants.isNotEmpty) {
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
    final dialogHeight = screenHeight * 0.80;

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
              color: Colors.black.withValues(alpha: 0.2),
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
                color: AppColors.purple.withValues(alpha: 0.05),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
                border:
                    Border(bottom: BorderSide(color: Colors.grey.shade200)),
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
                        final uniqueServices = _uniqueServices(services);
                        if (services.isNotEmpty && !_servicesLoaded) {
                          setState(() {
                            if (selectedServiceId == null) {
                              selectedServiceId = widget.serviceId;
                            }
                            mainServiceType = MainServiceType.fromServiceList(
                              uniqueServices,
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
                        final uniqueServices = _uniqueServices(services);
                        final validServiceId =
                            selectedServiceId != null &&
                                uniqueServices.any(
                                  (s) => s.id == selectedServiceId,
                                )
                            ? selectedServiceId
                            : null;

                        return Container(
                          padding:
                              const EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade300),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<int>(
                              isExpanded: true,
                              value: validServiceId,
                              hint: const Text('Choose a service category'),
                              items: uniqueServices.map((service) {
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
                                          uniqueServices,
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
              ProductImagePickerSection(
                imageNotifier: _imageNotifier,
                existingImageUrl: widget.product?.image,
                onPickImage: _pickProductImage,
              ),
              const SizedBox(width: 24),
              Expanded(
                child: mainServiceType == null
                    ? const Center(child: CircularProgressIndicator())
                    : ProductDynamicFields(
                        mainServiceType: mainServiceType!,
                        nameController: _nameController,
                        stockController: _stockController,
                        colorController: _colorController,
                        modelController: _modelController,
                        categoryController: _categoryController,
                        purchaseAmountController: _purchaseAmountController,
                        priceController: _priceController,
                        salePriceController: _salePriceController,
                        descriptionController: _descriptionController,
                        lengthController: _lengthController,
                        fabricTypeController: _fabricTypeController,
                        registrationNumberController:
                            _registrationNumberController,
                        pollutionExpiryController: _pollutionExpiryController,
                        insuranceExpiryController: _insuranceExpiryController,
                        fitnessExpiryController: _fitnessExpiryController,
                      ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Variants section
          if (mainServiceType != null)
            ProductVariantsSection(
              mainServiceType: mainServiceType!,
              variantsNotifier: variantsNotifier,
            ),

          const SizedBox(height: 20),

          // Action buttons
          BlocConsumer<SaveProductCubit, SaveProductState>(
            listener: (context, state) {
              state.maybeWhen(
                orElse: () {},
                error: (error) => context.showSnackBar(error, isError: true),
                success: () {
                  Navigator.of(context).pop(true);
                  context.showSnackBar(
                    isEditMode
                        ? 'Product updated successfully'
                        : 'Product added successfully',
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
                    onPressed: isLoading
                        ? () {}
                        : () => Navigator.of(context).pop(),
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

  void _submit() async {
    print('\n🚀 === SUBMIT STARTED ===');
    print('🔍 Form valid: ${_formKey.currentState?.validate()}');
    print('🔍 Is edit mode: ${widget.product != null}');
    print('🔍 Image available: ${_imageNotifier.value != null}');
    print('🔍 Product has existing image: ${widget.product?.image != null}');

    if (_formKey.currentState!.validate()) {
      if (widget.product == null && selectedServiceId == null) {
        print('❌ No service selected');
        context.showSnackBar('Please select a service category', isError: true);
        return;
      }

      if (widget.product == null && _imageNotifier.value == null) {
        print('❌ No image provided for new product');
        context.showSnackBar('Please select an image', isError: true);
        return;
      }

      print('✅ All validations passed');

      if (mainServiceType?.isDress == true &&
          variantsNotifier.value.isEmpty &&
          widget.product == null) {
        print('❌ No variants for dress');
        context.showSnackBar(
          'Please add at least one size variant for this dress',
          isError: true,
        );
        return;
      }

      final variantList = List<ProductVariantEntity>.from(
        variantsNotifier.value,
      );

      if (variantList.isEmpty && widget.product == null) {
        if (_stockController.text.trim().isEmpty) {
          context.showSnackBar(
            'Please enter stock quantity or add variants',
            isError: true,
          );
          return;
        }
        variantList.add(
          ProductVariantEntity(
            id: DateTime.now().millisecondsSinceEpoch,
            attribute: _nameController.text.trim(),
            stock: _stockController.text.trim().toInt(),
            remainingStock: _stockController.text.trim().toInt(),
          ),
        );
      }

      final saveCubit = context.read<SaveProductCubit>();

      if (widget.product != null) {
        List<ProductVariantEntity>? editVariants;
        if (mainServiceType?.needsVariantsSection == true) {
          editVariants = variantList.isEmpty ? null : variantList;
        } else {
          if (_stockController.text.trim().isNotEmpty) {
            final existingVariant = widget.product!.variants.first;
            editVariants = [
              ProductVariantEntity(
                id: existingVariant.id,
                attribute: _nameController.text.trim(),
                stock: _stockController.text.trim().toInt(),
                remainingStock: existingVariant.remainingStock,
              ),
            ];
          }
        }

        final product = ProductRequestEntity(
          productId: widget.product!.id,
          name: _nameController.text.trim(),
          description: _descriptionController.text.trim(),
          color: _colorController.text.trim(),
          purchasePrice: _purchaseAmountController.text.trim().toIntOrNull(),
          price: _priceController.text.trim().toIntOrNull(),
          salePrice: _salePriceController.text.trim().toIntOrNull(),
          category: _categoryController.text.trim(),
          model: _modelController.text.trim(),
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
        final product = ProductRequestEntity(
          serviceId: selectedServiceId,
          name: _nameController.text.trim(),
          description: _descriptionController.text.trim(),
          color: _colorController.text.trim(),
          purchasePrice: _purchaseAmountController.text.trim().toIntOrNull(),
          price: _priceController.text.trim().toIntOrNull(),
          salePrice: _salePriceController.text.trim().toIntOrNull(),
          category: _categoryController.text.trim(),
          model: _modelController.text.trim(),
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
        withData: true,
      );

      if (result != null && result.files.isNotEmpty) {
        print('📷 File picked: ${result.files.first.name}');
        Uint8List? imageBytes;
        String fileName;

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

        print('📷 Opening crop dialog...');
        final croppedBytes = await _showImageCropDialog(imageBytes, fileName);
        if (croppedBytes != null) {
          print('📷 Image cropped: ${croppedBytes.length} bytes');
          final processedBytes = await _compressImage(croppedBytes);
          if (processedBytes != null) {
            print('📷 Image compressed: ${processedBytes.length} bytes');

            String finalFileName = fileName;
            if (!fileName.toLowerCase().endsWith('.jpg') &&
                !fileName.toLowerCase().endsWith('.jpeg')) {
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
              '✅ Image set successfully with name: ${_imageNotifier.value?.name}',
            );
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

  Future<Uint8List?> _showImageCropDialog(
    Uint8List imageBytes,
    String fileName,
  ) async {
    final image = img.decodeImage(imageBytes);
    if (image == null) return null;

    return await showDialog<Uint8List>(
      context: context,
      builder: (context) =>
          ImageCropDialog(imageBytes: imageBytes, image: image),
    );
  }

  Future<Uint8List?> _compressImage(Uint8List imageBytes) async {
    try {
      img.Image? image = img.decodeImage(imageBytes);
      if (image == null) return null;

      if (image.width > 1024 || image.height > 1024) {
        image = img.copyResize(image, width: 1024, height: 1024);
      }

      final jpegBytes = img.encodeJpg(image, quality: 85);
      return Uint8List.fromList(jpegBytes);
    } catch (e) {
      debugPrint('Error compressing image: $e');
      return imageBytes;
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
    variantsNotifier.dispose();
    _imageNotifier.dispose();
    super.dispose();
  }
}
