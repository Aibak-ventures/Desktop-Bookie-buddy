import 'package:bookie_buddy_web/core/di/app_dependencies.dart';
import 'package:bookie_buddy_web/features/product/presentation/stock_management/bloc/save_product_cubit/save_product_cubit.dart';
import 'package:bookie_buddy_web/features/product/presentation/stock_management/bloc/stock_management_cubit/stock_management_cubit.dart';
import 'package:bookie_buddy_web/utils/app_input_validators.dart';
import 'package:bookie_buddy_web/core/constants/enums/enums.dart';
import 'package:bookie_buddy_web/core/constants/enums/service_type_enums.dart';
import 'package:bookie_buddy_web/utils/extensions/context_extensions.dart';
import 'package:bookie_buddy_web/features/product/domain/entities/product_entity/product_entity.dart';
import 'package:bookie_buddy_web/features/product/domain/entities/product_variant_entity/product_variant_entity.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:bookie_buddy_web/core/common/widgets/dialogs/perform_secure_action_dialog.dart';
import 'package:bookie_buddy_web/features/shop/presentation/bloc/service_bloc/service_bloc.dart';
import 'package:bookie_buddy_web/features/product/presentation/common/widgets/variant_size_type_text_field.dart';
import 'package:bookie_buddy_web/features/product/presentation/product_details/bloc/product_details_cubit/product_details_cubit.dart';
import 'package:bookie_buddy_web/features/product/presentation/product_details/bloc/product_details_cubit/product_details_state.dart';
import 'package:bookie_buddy_web/features/booking/presentation/all_booking/widgets/booking_details_drawer.dart';
import 'package:bookie_buddy_web/features/booking/presentation/all_booking/bloc/booking_details_drawer_cubit/booking_details_drawer_cubit.dart';
import 'package:bookie_buddy_web/features/booking/presentation/booking_details/bloc/booking_details_bloc/booking_details_bloc.dart';
import 'package:bookie_buddy_web/features/product/presentation/stock_management/widgets/add_edit_product_dialog.dart';
import 'package:bookie_buddy_web/features/product/presentation/product_details/widgets/product_details_header.dart';
import 'package:bookie_buddy_web/features/product/presentation/product_details/widgets/product_details_left_panel.dart';
import 'package:bookie_buddy_web/features/product/presentation/product_details/widgets/product_details_right_panel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetailsScreen extends StatefulWidget {
  final int productId;
  final int? serviceId;
  final MainServiceType? mainServiceType;
  final ProductEntity? productForEdit;

  const ProductDetailsScreen({
    super.key,
    required this.productId,
    this.serviceId,
    this.mainServiceType,
    this.productForEdit,
  });

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String _currentBookingStatus = 'upcoming';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        final newStatus = _tabController.index == 0 ? 'upcoming' : 'completed';
        if (newStatus != _currentBookingStatus) {
          _currentBookingStatus = newStatus;
          context.read<ProductDetailsCubit>().reloadBookingsWithStatus(
            widget.productId,
            _currentBookingStatus,
          );
        }
      }
    });

    context.read<ProductDetailsCubit>().loadProductDetails(
      widget.productId,
      bookingStatus: _currentBookingStatus,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => BookingDetailsDrawerCubit()),
      ],
      child: BlocListener<BookingDetailsDrawerCubit, BookingDetailsDrawerState>(
        listener: (context, drawerState) {
          if (drawerState.isOpen && drawerState.selectedBookingId != null) {
            context.read<BookingDetailsBloc>().add(
              BookingDetailsEvent.fetchBookingDetails(
                drawerState.selectedBookingId!,
              ),
            );
          }
        },
        child: Scaffold(
          backgroundColor: const Color(0xFFF5F7FA),
          body: Stack(
            children: [
              BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
                builder: (context, state) {
                  return state.when(
                    initial: () => const Center(child: Text('Initializing...')),
                    loading: () => const Center(
                      child: CircularProgressIndicator(color: AppColors.purple),
                    ),
                    loaded: (
                      product,
                      bookings,
                      monthlySummary,
                      nextPageUrl,
                      isPaginatingBookings,
                    ) =>
                        _buildContent(
                          context,
                          product,
                          bookings,
                          monthlySummary,
                        ),
                    error: (message) => Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.error_outline,
                            size: 64,
                            color: Colors.red.shade300,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            message,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.red.shade600,
                            ),
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: () {
                              context
                                  .read<ProductDetailsCubit>()
                                  .loadProductDetails(
                                    widget.productId,
                                    bookingStatus: _currentBookingStatus,
                                  );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.purple,
                              foregroundColor: Colors.white,
                            ),
                            child: const Text('Retry'),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              const BookingDetailsDrawer(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    ProductEntity product,
    bookings,
    monthlySummary,
  ) {
    return Padding(
      padding: const EdgeInsets.all(3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ProductDetailsHeader(
            product: product,
            onBack: () => context.read<StockManagementCubit>().hideProductDetails(),
            onDelete: () => _showDeleteProductDialog(product),
            onEdit: () => performSecureActionDialog(
              context,
              SecretPasswordLocations.productEdit,
              onSuccess: () => _showAddEditProductDialog(
                context,
                product: widget.productForEdit,
              ),
            ),
          ),
          const SizedBox(height: 24),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: ProductDetailsLeftPanel(
                    product: product,
                    onEditVariant: (variant) => performSecureActionDialog(
                      context,
                      SecretPasswordLocations.productEdit,
                      onSuccess: () => _showEditVariantDialog(variant),
                    ),
                    onAddVariant: () => _showAddVariantDialog(context),
                  ),
                ),
                const SizedBox(width: 24),
                Expanded(
                  flex: 3,
                  child: ProductDetailsRightPanel(
                    product: product,
                    bookings: bookings,
                    monthlySummary: monthlySummary,
                    tabController: _tabController,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showDeleteProductDialog(ProductEntity product) {
    performSecureActionDialog(
      context,
      SecretPasswordLocations.productDeletion,
      onSuccess: () async {
        try {
          await context.read<ProductDetailsCubit>().deleteProduct(product.id);
          if (mounted) {
            context.read<StockManagementCubit>().hideProductDetails();
            context.showSnackBar('Product deleted successfully');
          }
        } catch (e) {
          if (mounted) {
            context.showSnackBar('Failed to delete product: $e', isError: true);
          }
        }
      },
    );
  }

  void _showDeleteVariantDialog(ProductVariantEntity variant) {
    performSecureActionDialog(
      context,
      SecretPasswordLocations.productDeletion,
      onSuccess: () async {
        await context.read<ProductDetailsCubit>().deleteProductVariant(
          productId: widget.productId,
          variantId: variant.id,
        );
      },
    );
  }

  void _showAddVariantDialog(BuildContext context) {
    final variantAttributeController = TextEditingController();
    final variantQuantityController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    final currentState = context.read<ProductDetailsCubit>().state;
    List<ProductVariantEntity> currentVariants = [];
    currentState.maybeWhen(
      loaded: (product, _, __, ___, ____) => currentVariants = product.variants,
      orElse: () {},
    );

    final variantsNotifier = ValueNotifier<List<ProductVariantEntity>>(
      List.from(currentVariants),
    );

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text(
          'Add Variant',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        content: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              VariantSizeTypeTextField(
                variantAttributeController: variantAttributeController,
                variantsNotifier: variantsNotifier,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: variantQuantityController,
                decoration: InputDecoration(
                  labelText: 'Quantity',
                  hintText: 'Enter quantity',
                  border: const OutlineInputBorder(),
                  hintStyle: TextStyle(
                    color: Colors.grey.shade400,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                keyboardType: TextInputType.number,
                validator: AppInputValidators.quantity,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              if (formKey.currentState!.validate()) {
                final attribute = variantAttributeController.text.trim();
                final quantity =
                    int.tryParse(variantQuantityController.text.trim()) ?? 0;

                try {
                  await context.read<ProductDetailsCubit>().addProductVariant(
                    productId: widget.productId,
                    attribute: attribute,
                    stock: quantity,
                  );

                  if (context.mounted) {
                    Navigator.of(dialogContext).pop();
                    context.showSnackBar('Variant added successfully');
                  }
                } catch (e) {
                  if (context.mounted) {
                    context.showSnackBar(
                      'Failed to add variant: $e',
                      isError: true,
                    );
                  }
                }
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.purple,
              foregroundColor: Colors.white,
            ),
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  void _showEditVariantDialog(ProductVariantEntity variant) {
    final variantAttributeController = TextEditingController(
      text: variant.attribute,
    );
    final variantQuantityController = TextEditingController(
      text: variant.stock.toString(),
    );
    final externalBarcodeController = TextEditingController(
      text: variant.externalQrCode ?? '',
    );
    final formKey = GlobalKey<FormState>();

    final currentState = context.read<ProductDetailsCubit>().state;
    List<ProductVariantEntity> currentVariants = [];
    currentState.maybeWhen(
      loaded: (product, _, __, ___, ____) => currentVariants = product.variants
          .where((v) => v.id != variant.id)
          .toList(),
      orElse: () {},
    );

    final variantsNotifier = ValueNotifier<List<ProductVariantEntity>>(
      List.from(currentVariants),
    );

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text(
          'Edit Variant',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        content: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              VariantSizeTypeTextField(
                variantAttributeController: variantAttributeController,
                variantsNotifier: variantsNotifier,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: variantQuantityController,
                decoration: InputDecoration(
                  labelText: 'Quantity',
                  hintText: 'Enter quantity',
                  border: const OutlineInputBorder(),
                  hintStyle: TextStyle(
                    color: Colors.grey.shade400,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                keyboardType: TextInputType.number,
                validator: AppInputValidators.quantity,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: externalBarcodeController,
                decoration: InputDecoration(
                  labelText: 'External Barcode (Optional)',
                  hintText: 'Enter external QR code or barcode',
                  border: const OutlineInputBorder(),
                  prefixIcon: const Icon(Icons.qr_code),
                  hintStyle: TextStyle(
                    color: Colors.grey.shade400,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
        actions: [
          Row(
            children: [
              TextButton(
                onPressed: () {
                  Navigator.of(dialogContext).pop();
                  _showDeleteVariantDialog(variant);
                },
                child: const Text(
                  'Delete',
                  style: TextStyle(color: Colors.red),
                ),
              ),
              const Spacer(),
              TextButton(
                onPressed: () => Navigator.of(dialogContext).pop(),
                child: const Text('Cancel'),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    final attribute = variantAttributeController.text.trim();
                    final quantity =
                        int.tryParse(variantQuantityController.text.trim()) ??
                        0;
                    final externalBarcode =
                        externalBarcodeController.text.trim();

                    try {
                      await context
                          .read<ProductDetailsCubit>()
                          .updateProductVariant(
                            productId: widget.productId,
                            variantId: variant.id,
                            attribute: attribute,
                            stock: quantity,
                            externalQrCode: externalBarcode.isEmpty
                                ? null
                                : externalBarcode,
                          );

                      if (context.mounted) {
                        Navigator.of(dialogContext).pop();
                        context.showSnackBar('Variant updated successfully');
                      }
                    } catch (e) {
                      if (context.mounted) {
                        context.showSnackBar(
                          'Failed to update variant: $e',
                          isError: true,
                        );
                      }
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.purple,
                  foregroundColor: Colors.white,
                ),
                child: const Text('Save'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _showAddEditProductDialog(
    BuildContext context, {
    ProductEntity? product,
  }) async {
    final result = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => SaveProductCubit(saveProduct: getIt.get()),
          ),
          BlocProvider.value(value: context.read<ServiceBloc>()),
        ],
        child: AddEditProductDialog(
          serviceId: widget.serviceId,
          product: product,
        ),
      ),
    );

    if (result == true && mounted) {
      context.read<ProductDetailsCubit>().loadProductDetails(
        widget.productId,
        bookingStatus: _currentBookingStatus,
      );
    }
  }
}
