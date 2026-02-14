import 'package:bookie_buddy_web/core/enums/enums.dart';
import 'package:bookie_buddy_web/core/enums/service_type_enums.dart';
import 'package:bookie_buddy_web/core/extensions/number_extensions.dart';
import 'package:bookie_buddy_web/core/models/product_model/product_model.dart';
// import 'package:bookie_buddy_web/core/models/service_model.dart';
import 'package:bookie_buddy_web/core/models/services_model/services_model.dart';
import 'package:bookie_buddy_web/core/repositories/product_repository.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:bookie_buddy_web/core/ui/dialogs/perform_secure_action_dialog.dart';
import 'package:bookie_buddy_web/core/ui/widgets/custom_network_image.dart';
import 'package:bookie_buddy_web/core/view_model/bloc_service/service_bloc.dart';
import 'package:bookie_buddy_web/features/product/view_model/cubit_save_product/save_product_cubit.dart';
import 'package:bookie_buddy_web/features/product_details/view/product_details_screen.dart';
import 'package:bookie_buddy_web/features/product_details/view_model/product_details_cubit.dart';
import 'package:bookie_buddy_web/features/stock_management/view/widgets/add_edit_product_dialog.dart';
import 'package:bookie_buddy_web/features/stock_management/view_model/stock_management_cubit.dart';
import 'package:bookie_buddy_web/features/stock_management/view_model/stock_management_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class StockManagementScreen extends StatefulWidget {
  const StockManagementScreen({super.key});

  @override
  State<StockManagementScreen> createState() => _StockManagementScreenState();
}

class _StockManagementScreenState extends State<StockManagementScreen> {
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  
  // Filter state variables (matching new_booking_screen pattern)
  final _selectedSearchTypeIndex = ValueNotifier<int>(0);
  final _priceRange = ValueNotifier<RangeValues>(const RangeValues(0, 50000));
  final _maxPriceNotifier = ValueNotifier<double>(50000);
  final _isPriceFilterEnabled = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();
    // Load initial data
    context.read<StockManagementCubit>().loadProducts();

    // Setup pagination scroll listener
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    _selectedSearchTypeIndex.dispose();
    _priceRange.dispose();
    _maxPriceNotifier.dispose();
    _isPriceFilterEnabled.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      context.read<StockManagementCubit>().loadNextPage();
    }
  }

  /// Show add/edit product modal dialog
  Future<void> _showAddEditProductDialog(BuildContext context,
      {ProductModel? product}) async {
    // Get current selected service ID from state
    final selectedServiceId =
        await context.read<StockManagementCubit>().state.maybeWhen(
              loaded: (_, __, ___, ____, _____, serviceId, ______, _______) =>
                  serviceId,
              orElse: () => null,
            );

    if (!mounted) return;

    final result = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => BlocProvider(
        create: (context) => SaveProductCubit(),
        child: AddEditProductDialog(
          serviceId: selectedServiceId,
          product: product,
        ),
      ),
    );

    // Refresh the product list if a product was added/edited
    if (result == true && mounted) {
      context.read<StockManagementCubit>().loadProducts(
            serviceId: selectedServiceId,
            searchQuery: _searchController.text,
            page: 1,
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1400),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Only show header when on product list, not on product details
                BlocBuilder<StockManagementCubit, StockManagementState>(
                  builder: (context, state) {
                    final showingProductDetails = state.maybeWhen(
                      loaded: (_, __, ___, ____, _____, ______, _______,
                          selectedProductId) {
                        return selectedProductId != null;
                      },
                      orElse: () => false,
                    );

                    if (!showingProductDetails) {
                      return Column(
                        children: [
                          _buildHeader(),
                          const SizedBox(height: 16),
                        ],
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
                Expanded(
                  child:
                      BlocBuilder<StockManagementCubit, StockManagementState>(
                    builder: (context, state) {
                      // Check if we should show product details
                      return state.maybeWhen(
                        loaded: (_, __, ___, ____, _____, ______, _______,
                            selectedProductId) {
                          if (selectedProductId != null) {
                            // Show product details
                            return RepositoryProvider.value(
                              value: context.read<ProductRepository>(),
                              child: BlocProvider(
                                create: (context) => ProductDetailsCubit(
                                  context.read<ProductRepository>(),
                                )..loadProductDetails(selectedProductId),
                                child: ProductDetailsScreen(
                                    productId: selectedProductId),
                              ),
                            );
                          } else {
                            // Show product list
                            return _buildProductList();
                          }
                        },
                        orElse: () => _buildProductList(),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProductList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSummaryCards(),
        const SizedBox(height: 24),
        _buildSearchBar(),
        const SizedBox(height: 20),
        _buildCategoryTabs(),
        const SizedBox(height: 20),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Colors.grey.shade200,
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
                BoxShadow(
                  color: Colors.black.withOpacity(0.02),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: _buildProductsTable(),
          ),
        ),
      ],
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back, size: 20),
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
        ),
        const SizedBox(width: 12),
        const Text(
          'All Orders > ',
          style: TextStyle(
            fontSize: 18,
            color: Colors.grey,
            fontWeight: FontWeight.w500,
          ),
        ),
        const Text(
          'Stock Management',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w400,
            color: Color(0xFF2D3436),
          ),
        ),
      ],
    );
  }

  Widget _buildSummaryCards() {
    return BlocBuilder<StockManagementCubit, StockManagementState>(
      builder: (context, state) {
        return state.maybeWhen(
          loaded: (_, totalProducts, totalCategories, __, ___, ____, _____,
              ______) {
            return Row(
              children: [
                _summaryCard(
                  'Total Products',
                  NumberFormat('#,###').format(totalProducts),
                ),
                const SizedBox(width: 16),
                _summaryCard(
                  'Total Categories',
                  totalCategories.toString(),
                ),
              ],
            );
          },
          orElse: () => Row(
            children: [
              SizedBox(
                width: 227,
                height: 98,
                child: _summaryCard('Total Products', '-'),
              ),
              const SizedBox(width: 16),
              SizedBox(
                width: 227,
                height: 98,
                child: _summaryCard('Total Categories', '-'),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _summaryCard(String title, String value) {
    return Container(
      width: 217,
      height: 97,
      // padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          SizedBox(
            width: 40,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10,
              ),
              Text(
                title,
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1F2937),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Row(
      children: [
        Container(
          width: 269,
          height: 40,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Row(
            children: [
              Icon(Icons.search, color: Colors.grey.shade500, size: 20),
              const SizedBox(width: 12),
              Expanded(
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Search by name or id',
                    hintStyle: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade400,
                    ),
                    border: InputBorder.none,
                  ),
                  onChanged: (value) {
                    // Debounce search
                    Future.delayed(const Duration(milliseconds: 500), () {
                      if (_searchController.text == value) {
                        context
                            .read<StockManagementCubit>()
                            .searchProducts(value);
                      }
                    });
                  },
                ),
              ),
              IconButton(
                onPressed: () {
                  _showProductFilterBottomSheet();
                },
                icon: Icon(Icons.tune, color: Colors.grey.shade600, size: 20),
              ),
            ],
          ),
        ),
        const Spacer(),
        // Add Product Button
        ElevatedButton.icon(
          onPressed: () {
            _showAddEditProductDialog(context);
          },
          icon: const Icon(Icons.add, size: 18),
          label: const Text(
            'Add Product',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.purple,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            elevation: 0,
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryTabs() {
    return BlocBuilder<ServiceBloc, ServiceState>(
      builder: (context, serviceState) {
        return BlocBuilder<StockManagementCubit, StockManagementState>(
          builder: (context, state) {
            final selectedServiceId = state.maybeWhen(
              loaded: (_, __, ___, ____, _____, selected, ______, _______) =>
                  selected,
              orElse: () => -1, // Default to -1 (All Services)
            );

            return serviceState.maybeWhen(
              loaded: (services) {
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      // "All Services" tab
                      Padding(
                        padding: const EdgeInsets.only(right: 12),
                        child: InkWell(
                          onTap: () {
                            context
                                .read<StockManagementCubit>()
                                .filterByService(-1);
                          },
                          borderRadius: BorderRadius.circular(8),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 10,
                            ),
                            decoration: BoxDecoration(
                              color: selectedServiceId == -1
                                  ? AppColors.purple.withOpacity(0.1)
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: selectedServiceId == -1
                                    ? AppColors.purple
                                    : Colors.grey.shade300,
                                width: selectedServiceId == -1 ? 2 : 1,
                              ),
                            ),
                            child: Text(
                              'All Services',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: selectedServiceId == -1
                                    ? FontWeight.w600
                                    : FontWeight.w500,
                                color: selectedServiceId == -1
                                    ? AppColors.purple
                                    : Colors.grey.shade700,
                              ),
                            ),
                          ),
                        ),
                      ),
                      // Service tabs from API
                      ...services.map((service) {
                        final isSelected = service.id == selectedServiceId;
                        return Padding(
                          padding: const EdgeInsets.only(right: 12),
                          child: InkWell(
                            onTap: () {
                              context
                                  .read<StockManagementCubit>()
                                  .filterByService(service.id);
                            },
                            borderRadius: BorderRadius.circular(8),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 10,
                              ),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? AppColors.purple.withOpacity(0.1)
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: isSelected
                                      ? AppColors.purple
                                      : Colors.grey.shade300,
                                  width: isSelected ? 2 : 1,
                                ),
                              ),
                              child: Text(
                                service.name,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: isSelected
                                      ? FontWeight.w600
                                      : FontWeight.w500,
                                  color: isSelected
                                      ? AppColors.purple
                                      : Colors.grey.shade700,
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ],
                  ),
                );
              },
              orElse: () => const Center(
                child: SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildProductsTable() {
    return BlocBuilder<StockManagementCubit, StockManagementState>(
      builder: (context, state) {
        return state.when(
          initial: () => const SizedBox.shrink(),
          loading: () => const Center(
            child: Padding(
              padding: EdgeInsets.all(40),
              child: CircularProgressIndicator(),
            ),
          ),
          loaded: (products, _, __, ___, isPaginating, ____, _____, ______) {
            if (products.isEmpty) {
              return Container(
                padding: const EdgeInsets.all(40),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Center(
                  child: Text(
                    'No products found',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                ),
              );
            }

            return Column(
              children: [
                _buildTableHeader(),
                Expanded(
                  child: ListView.builder(
                    controller: _scrollController,
                    padding: EdgeInsets.zero,
                    itemCount: products.length + (isPaginating ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index < products.length) {
                        return _buildProductRow(products[index]);
                      } else {
                        return Padding(
                          padding: const EdgeInsets.all(20),
                          child: Center(
                            child: CircularProgressIndicator(
                              color: AppColors.purple,
                              strokeWidth: 3,
                            ),
                          ),
                        );
                      }
                    },
                  ),
                ),
              ],
            );
          },
          error: (message) => Container(
            padding: const EdgeInsets.all(40),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Column(
                children: [
                  Icon(Icons.error_outline,
                      size: 48, color: Colors.red.shade300),
                  const SizedBox(height: 16),
                  Text(
                    message,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.red.shade400,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      context.read<StockManagementCubit>().loadProducts();
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildTableHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.purple.withOpacity(0.08),
            AppColors.purple.withOpacity(0.12),
          ],
        ),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
        border: Border(
          bottom: BorderSide(
            color: AppColors.purple.withOpacity(0.2),
            width: 2,
          ),
        ),
      ),
      child: Row(
        children: [
          // Item column - enhanced width for better visibility
          Expanded(
            flex: 3,
            child: Text(
              'ITEM',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: AppColors.purple.withOpacity(0.9),
                letterSpacing: 0.8,
              ),
            ),
          ),
          const SizedBox(width: 16),
          // Category column
          Expanded(
            flex: 2,
            child: Text(
              'CATEGORY',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: AppColors.purple.withOpacity(0.9),
                letterSpacing: 0.8,
              ),
            ),
          ),
          const SizedBox(width: 16),
          // Sale Price column
          Expanded(
            flex: 2,
            child: Text(
              'SALE PRICE',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: AppColors.purple.withOpacity(0.9),
                letterSpacing: 0.8,
              ),
            ),
          ),
          const SizedBox(width: 16),
          // Rent Price column
          Expanded(
            flex: 2,
            child: Text(
              'RENT PRICE',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: AppColors.purple.withOpacity(0.9),
                letterSpacing: 0.8,
              ),
            ),
          ),
          const SizedBox(width: 16),
          // Total Qty column
          SizedBox(
            width: 100,
            child: Text(
              'TOTAL QTY',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: AppColors.purple.withOpacity(0.9),
                letterSpacing: 0.8,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(width: 16),
          // Total Variants column
          SizedBox(
            width: 100,
            child: Text(
              'VARIANTS',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: AppColors.purple.withOpacity(0.9),
                letterSpacing: 0.8,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(width: 16),
          // Actions column
          SizedBox(
            width: 140,
            child: Text(
              'ACTIONS',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: AppColors.purple.withOpacity(0.9),
                letterSpacing: 0.8,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductRow(ProductModel product) {
    final totalStock = product.variants.fold<int>(
      0,
      (sum, variant) => sum + variant.stock,
    );
    final variantCount = product.variants.length;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: Container(
        height: 80,
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.grey.shade100,
              width: 1,
            ),
          ),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              context
                  .read<StockManagementCubit>()
                  .showProductDetails(product.id);
            },
            hoverColor: AppColors.purple.withOpacity(0.08),
            splashColor: AppColors.purple.withOpacity(0.12),
            highlightColor: AppColors.purple.withOpacity(0.1),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Row(
                children: [
                  // Item column (image + name)
                  Expanded(
                    flex: 3,
                    child: Row(
                      children: [
                        // Enhanced image with shadow
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade50,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.08),
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              ),
                            ],
                            border: Border.all(
                              color: Colors.grey.shade200,
                              width: 1,
                            ),
                          ),
                          child: product.thumbnailImage != null
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: CustomNetworkImage(
                                    imageUrl: product.thumbnailImage!,
                                    width: 60,
                                    height: 60,
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : Icon(
                                  Icons.image_outlined,
                                  color: Colors.grey.shade400,
                                  size: 28,
                                ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                product.name,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF1F2937),
                                  height: 1.3,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              // const SizedBox(height: 4),
                              // Show color, category, and model under product name
                              Wrap(
                                spacing: 6,
                                runSpacing: 4,
                                children: [
                                  if (product.color != null &&
                                      product.color!.isNotEmpty)
                                    Text(
                                      'Color: ${product.color}',
                                      style: TextStyle(
                                        fontSize: 10,
                                        // color: Colors.orange.shade700,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  if (product.category != null &&
                                      product.category!.isNotEmpty)
                                    Text(
                                      'Cat: ${product.category}',
                                      style: TextStyle(
                                        fontSize: 10,
                                        // color: Colors.blue.shade700,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  if (product.model != null &&
                                      product.model!.isNotEmpty)
                                    Text(
                                      'Model: ${product.model}',
                                      style: TextStyle(
                                        fontSize: 10,
                                        // color: Colors.purple.shade700,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                ],
                              ),
                              if (product.description != null &&
                                  product.description!.isNotEmpty) ...[
                                // const SizedBox(height: 4),
                                Text(
                                  product.description!,
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: Colors.grey.shade600,
                                    height: 1.3,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  // Category column with modern badge (only show if category exists)
                  Expanded(
                    flex: 2,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: product.category != null &&
                              product.category!.isNotEmpty
                          ? Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    AppColors.purple.withOpacity(0.12),
                                    AppColors.purple.withOpacity(0.08),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(
                                  color: AppColors.purple.withOpacity(0.2),
                                  width: 1,
                                ),
                              ),
                              child: Text(
                                product.mainServiceType.productNameLabel,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.purple.withOpacity(0.95),
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            )
                          : const SizedBox.shrink(), // Hide if no category
                    ),
                  ),
                  const SizedBox(width: 16),
                  // Sale Price column
                  Expanded(
                    flex: 2,
                    child: Text(
                      product.price != null
                          ? '₹ ${NumberFormat('#,###').format(product.price)}'
                          : '-',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF1F2937),
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(width: 16),
                  // Rent Price column
                  Expanded(
                    flex: 2,
                    child: Text(
                      product.price != null
                          ? '₹ ${NumberFormat('#,###').format(product.price)}'
                          : '-',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF1F2937),
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(width: 16),
                  // Quantity column with badge
                  SizedBox(
                    width: 100,
                    child: Center(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: totalStock > 0
                              ? Colors.green.shade50
                              : Colors.red.shade50,
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(
                            color: totalStock > 0
                                ? Colors.green.shade200
                                : Colors.red.shade200,
                            width: 1,
                          ),
                        ),
                        child: Text(
                          totalStock.toString(),
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: totalStock > 0
                                ? Colors.green.shade800
                                : Colors.red.shade800,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  // Variants column with badge
                  SizedBox(
                    width: 100,
                    child: Center(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.blue.shade50,
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(
                            color: Colors.blue.shade200,
                            width: 1,
                          ),
                        ),
                        child: Text(
                          variantCount.toString(),
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: Colors.blue.shade800,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  // Actions column with modern styled buttons
                  SizedBox(
                    width: 140,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildActionButton(
                          icon: Icons.edit_outlined,
                          tooltip: 'Edit Product',
                          color: Colors.blue,
                          onPressed: () {
                            _showAddEditProductDialog(context,
                                product: product);
                          },
                        ),
                        const SizedBox(width: 8),
                        _buildActionButton(
                          icon: Icons.visibility_outlined,
                          tooltip: 'View Details',
                          color: Colors.green,
                          onPressed: () {
                            context
                                .read<StockManagementCubit>()
                                .showProductDetails(product.id);
                          },
                        ),
                        const SizedBox(width: 8),
                        _buildActionButton(
                          icon: Icons.delete_outline,
                          tooltip: 'Delete Product',
                          color: Colors.red,
                          onPressed: () {
                            _showDeleteConfirmationDialog(context, product);
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
      ),
    );
  }

  /// Build a modern styled action button
  Widget _buildActionButton({
    required IconData icon,
    required String tooltip,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return Tooltip(
      message: tooltip,
      waitDuration: const Duration(milliseconds: 500),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(6),
        hoverColor: color.withOpacity(0.1),
        splashColor: color.withOpacity(0.2),
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.08),
            borderRadius: BorderRadius.circular(6),
            border: Border.all(
              color: color.withOpacity(0.2),
              width: 1,
            ),
          ),
          child: Icon(
            icon,
            size: 18,
            color: color,
          ),
        ),
      ),
    );
  }

  void _showDeleteConfirmationDialog(
      BuildContext context, ProductModel product) {
    performSecureActionDialog(
      context,
      SecretPasswordLocations.productDeletion,
      onSuccess: () async {
        try {
          await context
              .read<StockManagementCubit>()
              .deleteProduct(product.id);
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Product deleted successfully')),
            );
          }
        } catch (e) {
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Failed to delete product: $e'),
                backgroundColor: Colors.red,
              ),
            );
          }
        }
      },
    );
  }

  /// Show product filter bottom sheet (from new_booking_screen pattern)
  void _showProductFilterBottomSheet() {
    // Calculate max price from current product list
    final currentState = context.read<StockManagementCubit>().state;
    final currentProducts = currentState.maybeWhen(
      loaded: (products, _, __, ___, ____, _____, ______, _______) => products,
      orElse: () => <ProductModel>[],
    );

    if (currentProducts.isNotEmpty) {
      double maxProductPrice = 0;
      for (final product in currentProducts) {
        final productPrice = product.price ?? 0;
        if (productPrice > maxProductPrice) {
          maxProductPrice = productPrice.toDouble();
        }
        // Also check variant prices
        for (final variant in product.variants) {
          final variantPrice = variant.price ?? 0;
          if (variantPrice > maxProductPrice) {
            maxProductPrice = variantPrice.toDouble();
          }
        }
      }
      if (maxProductPrice > _maxPriceNotifier.value) {
        _maxPriceNotifier.value = maxProductPrice;
        _priceRange.value = RangeValues(0, maxProductPrice);
      }
    }

    // Get services for filter
    final servicesState = context.read<ServiceBloc>().state;
    List<ServicesModel> services = [];
    servicesState.whenOrNull(loaded: (s) => services = s);

    // Get current selected service ID from state
    final selectedServiceId = currentState.maybeWhen(
      loaded: (_, __, ___, ____, _____, serviceId, ______, _______) => serviceId,
      orElse: () => -1,
    );

    // Setup local state for dialog
    final TextEditingController maxPriceController = TextEditingController();
    final isPriceFilterEnabledWidgetNotifier =
        ValueNotifier(_isPriceFilterEnabled.value);
    final tempSelectedServiceId = ValueNotifier<int?>(selectedServiceId);
    final tempSelectedSearchTypeIndex =
        ValueNotifier<int>(_selectedSearchTypeIndex.value);
    final tempPriceRange = ValueNotifier<RangeValues>(_priceRange.value);

    final searchTypes = ['Name', 'Category', 'Model', 'Color'];

    showDialog(
      context: context,
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        child: Container(
          width: 500,
          constraints: const BoxConstraints(
            maxWidth: 500,
            maxHeight: 700,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 30,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                decoration: BoxDecoration(
                  color: const Color(0xFFF8F9FA),
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(20),
                  ),
                  border: Border(
                    bottom: BorderSide(color: Colors.grey.shade200, width: 1),
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: const Color(0xFF6132E4).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(
                        Icons.tune_rounded,
                        color: Color(0xFF6132E4),
                        size: 22,
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Expanded(
                      child: Text(
                        'Search & Filter',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF2D2D2D),
                          fontFamily: 'Inter',
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: Icon(Icons.close, color: Colors.grey.shade600),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                  ],
                ),
              ),

              // Content
              Flexible(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Service Filter Section
                      const Text(
                        'Select Service',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF2D2D2D),
                          fontFamily: 'Inter',
                        ),
                      ),
                      const SizedBox(height: 12),

                      ValueListenableBuilder<int?>(
                        valueListenable: tempSelectedServiceId,
                        builder: (context, selectedId, child) {
                          return Wrap(
                            spacing: 10,
                            runSpacing: 10,
                            children: [
                              // "All Services" option
                              GestureDetector(
                                onTap: () {
                                  tempSelectedServiceId.value = -1;
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 10,
                                  ),
                                  decoration: BoxDecoration(
                                    color: selectedId == -1
                                        ? const Color(0xFF6132E4)
                                        : Colors.white,
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: selectedId == -1
                                          ? const Color(0xFF6132E4)
                                          : Colors.grey.shade300,
                                      width: selectedId == -1 ? 2 : 1,
                                    ),
                                  ),
                                  child: Text(
                                    'All Services',
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: selectedId == -1
                                          ? FontWeight.w600
                                          : FontWeight.normal,
                                      color: selectedId == -1
                                          ? Colors.white
                                          : Colors.grey.shade700,
                                      fontFamily: 'Inter',
                                    ),
                                  ),
                                ),
                              ),
                              // Individual services
                              ...services.map((service) {
                                final isSelected = service.id == selectedId;
                                return GestureDetector(
                                  onTap: () {
                                    tempSelectedServiceId.value = service.id;
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 10,
                                    ),
                                    decoration: BoxDecoration(
                                      color: isSelected
                                          ? const Color(0xFF6132E4)
                                          : Colors.white,
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                        color: isSelected
                                            ? const Color(0xFF6132E4)
                                            : Colors.grey.shade300,
                                        width: isSelected ? 2 : 1,
                                      ),
                                    ),
                                    child: Text(
                                      service.name,
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: isSelected
                                            ? FontWeight.w600
                                            : FontWeight.normal,
                                        color: isSelected
                                            ? Colors.white
                                            : Colors.grey.shade700,
                                        fontFamily: 'Inter',
                                      ),
                                    ),
                                  ),
                                );
                              }).toList(),
                            ],
                          );
                        },
                      ),

                      const SizedBox(height: 28),
                      const Divider(height: 1),
                      const SizedBox(height: 24),

                      // Search Type Section
                      const Text(
                        'Search By',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF2D2D2D),
                          fontFamily: 'Inter',
                        ),
                      ),
                      const SizedBox(height: 12),

                      ValueListenableBuilder<int>(
                        valueListenable: tempSelectedSearchTypeIndex,
                        builder: (context, selectedIndex, child) {
                          return Wrap(
                            spacing: 10,
                            runSpacing: 10,
                            children: List.generate(searchTypes.length, (index) {
                              final isSelected = index == selectedIndex;
                              return GestureDetector(
                                onTap: () {
                                  tempSelectedSearchTypeIndex.value = index;
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 10,
                                  ),
                                  decoration: BoxDecoration(
                                    color: isSelected
                                        ? const Color(0xFF6132E4).withOpacity(0.1)
                                        : Colors.grey.shade50,
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: isSelected
                                          ? const Color(0xFF6132E4)
                                          : Colors.grey.shade300,
                                      width: isSelected ? 2 : 1,
                                    ),
                                  ),
                                  child: Text(
                                    searchTypes[index],
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: isSelected
                                          ? FontWeight.w600
                                          : FontWeight.normal,
                                      color: isSelected
                                          ? const Color(0xFF6132E4)
                                          : Colors.grey.shade700,
                                      fontFamily: 'Inter',
                                    ),
                                  ),
                                ),
                              );
                            }),
                          );
                        },
                      ),

                      const SizedBox(height: 28),
                      const Divider(height: 1),
                      const SizedBox(height: 24),

                      // Price Filter Section
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Price Range',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF2D2D2D),
                              fontFamily: 'Inter',
                            ),
                          ),
                          ValueListenableBuilder<bool>(
                            valueListenable: isPriceFilterEnabledWidgetNotifier,
                            builder: (context, isEnabled, child) =>
                                Transform.scale(
                              scale: 0.85,
                              child: Switch(
                                value: isEnabled,
                                onChanged: (value) {
                                  isPriceFilterEnabledWidgetNotifier.value =
                                      value;
                                },
                                activeThumbColor: const Color(0xFF6132E4),
                                activeTrackColor:
                                    const Color(0xFF6132E4).withOpacity(0.3),
                                inactiveThumbColor: Colors.grey.shade400,
                                inactiveTrackColor: Colors.grey.shade200,
                              ),
                            ),
                          ),
                        ],
                      ),

                      // Price Range Content
                      ValueListenableBuilder<bool>(
                        valueListenable: isPriceFilterEnabledWidgetNotifier,
                        builder: (context, isEnabled, child) => AnimatedSize(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                          child: isEnabled
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 16),
                                    // Max Price Editor
                                    Row(
                                      children: [
                                        const Text(
                                          'Maximum Price',
                                          style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w500,
                                            color: Color(0xFF6B6B6B),
                                            fontFamily: 'Inter',
                                          ),
                                        ),
                                        const Spacer(),
                                        ValueListenableBuilder<double>(
                                          valueListenable: _maxPriceNotifier,
                                          builder: (context, currentMaxPrice,
                                              child) {
                                            maxPriceController.text =
                                                currentMaxPrice
                                                    .toInt()
                                                    .toString();
                                            return Container(
                                              width: 130,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 14,
                                                vertical: 10,
                                              ),
                                              decoration: BoxDecoration(
                                                color: const Color(0xFFF8F9FA),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                border: Border.all(
                                                  color: Colors.grey.shade300,
                                                  width: 1,
                                                ),
                                              ),
                                              child: TextField(
                                                controller: maxPriceController,
                                                keyboardType:
                                                    TextInputType.number,
                                                onTapOutside: (_) {
                                                  FocusScope.of(context)
                                                      .unfocus();
                                                },
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                  fontFamily: 'Inter',
                                                ),
                                                decoration:
                                                    const InputDecoration(
                                                  border: InputBorder.none,
                                                  contentPadding:
                                                      EdgeInsets.zero,
                                                  isDense: true,
                                                  prefixText: '₹ ',
                                                  prefixStyle: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    color: Color(0xFF6132E4),
                                                  ),
                                                ),
                                                onChanged: (value) {
                                                  if (value.isNotEmpty) {
                                                    final newMaxPrice =
                                                        double.tryParse(
                                                                value) ??
                                                            currentMaxPrice;
                                                    _maxPriceNotifier.value =
                                                        newMaxPrice;
                                                    if (tempPriceRange
                                                            .value.end >
                                                        newMaxPrice) {
                                                      tempPriceRange.value =
                                                          RangeValues(
                                                              tempPriceRange
                                                                          .value
                                                                          .start >
                                                                      newMaxPrice
                                                                  ? 0
                                                                  : tempPriceRange
                                                                      .value
                                                                      .start,
                                                              newMaxPrice);
                                                    }
                                                  }
                                                },
                                              ),
                                            );
                                          },
                                        ),
                                      ],
                                    ),

                                    const SizedBox(height: 20),

                                    // Price Range Display
                                    ValueListenableBuilder<RangeValues>(
                                      valueListenable: tempPriceRange,
                                      builder: (context, range, child) => Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 16,
                                              vertical: 10,
                                            ),
                                            decoration: BoxDecoration(
                                              gradient: LinearGradient(
                                                colors: [
                                                  const Color(0xFF6132E4)
                                                      .withOpacity(0.1),
                                                  const Color(0xFF6132E4)
                                                      .withOpacity(0.05),
                                                ],
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              border: Border.all(
                                                color: const Color(0xFF6132E4)
                                                    .withOpacity(0.3),
                                              ),
                                            ),
                                            child: Text(
                                              range.start.toCurrency(),
                                              style: const TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w700,
                                                color: Color(0xFF6132E4),
                                                fontFamily: 'Inter',
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 12),
                                            child: Icon(
                                              Icons.arrow_forward,
                                              size: 18,
                                              color: Colors.grey.shade400,
                                            ),
                                          ),
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 16,
                                              vertical: 10,
                                            ),
                                            decoration: BoxDecoration(
                                              gradient: LinearGradient(
                                                colors: [
                                                  const Color(0xFF6132E4)
                                                      .withOpacity(0.1),
                                                  const Color(0xFF6132E4)
                                                      .withOpacity(0.05),
                                                ],
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              border: Border.all(
                                                color: const Color(0xFF6132E4)
                                                    .withOpacity(0.3),
                                              ),
                                            ),
                                            child: Text(
                                              range.end.toCurrency(),
                                              style: const TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w700,
                                                color: Color(0xFF6132E4),
                                                fontFamily: 'Inter',
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    const SizedBox(height: 8),

                                    // Price Range Slider
                                    ValueListenableBuilder<RangeValues>(
                                      valueListenable: tempPriceRange,
                                      builder: (context, range, child) =>
                                          ValueListenableBuilder<double>(
                                        valueListenable: _maxPriceNotifier,
                                        builder:
                                            (context, currentMaxPrice, child) =>
                                                SliderTheme(
                                          data: SliderThemeData(
                                            activeTrackColor:
                                                const Color(0xFF6132E4),
                                            inactiveTrackColor:
                                                Colors.grey.shade200,
                                            thumbColor: const Color(0xFF6132E4),
                                            overlayColor:
                                                const Color(0xFF6132E4)
                                                    .withOpacity(0.2),
                                            trackHeight: 4,
                                            thumbShape:
                                                const RoundSliderThumbShape(
                                              enabledThumbRadius: 8,
                                            ),
                                            overlayShape:
                                                const RoundSliderOverlayShape(
                                              overlayRadius: 16,
                                            ),
                                          ),
                                          child: RangeSlider(
                                            values: range,
                                            min: 0,
                                            max: currentMaxPrice,
                                            divisions: 20,
                                            onChanged: (RangeValues newRange) {
                                              tempPriceRange.value = newRange;
                                            },
                                          ),
                                        ),
                                      ),
                                    ),

                                    const SizedBox(height: 20),

                                    // Quick Filters
                                    const Text(
                                      'Quick Filters',
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xFF2D2D2D),
                                        fontFamily: 'Inter',
                                      ),
                                    ),
                                    const SizedBox(height: 12),

                                    ValueListenableBuilder<double>(
                                      valueListenable: _maxPriceNotifier,
                                      builder:
                                          (context, currentMaxPrice, child) {
                                        final quickFilters =
                                            _generateQuickFilters(
                                          0,
                                          currentMaxPrice,
                                        );

                                        return Wrap(
                                          spacing: 8,
                                          runSpacing: 8,
                                          children: quickFilters
                                              .map((filter) =>
                                                  _buildQuickFilterChip(
                                                    filter['label'],
                                                    filter['range'],
                                                    tempPriceRange,
                                                    (val) => tempPriceRange
                                                        .value = val,
                                                  ))
                                              .toList(),
                                        );
                                      },
                                    ),
                                  ],
                                )
                              : const SizedBox.shrink(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Footer
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: const Color(0xFFF8F9FA),
                  borderRadius: const BorderRadius.vertical(
                    bottom: Radius.circular(20),
                  ),
                  border: Border(
                    top: BorderSide(color: Colors.grey.shade200, width: 1),
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          tempSelectedSearchTypeIndex.value = 0;
                          tempSelectedServiceId.value = -1;
                          tempPriceRange.value =
                              RangeValues(0, _maxPriceNotifier.value);
                          isPriceFilterEnabledWidgetNotifier.value = false;
                        },
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          side: BorderSide(
                            color: Colors.grey.shade300,
                            width: 1.5,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          'Reset',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey.shade700,
                            fontFamily: 'Inter',
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      flex: 2,
                      child: ElevatedButton(
                        onPressed: () {
                          // Apply changes
                          setState(() {
                            _selectedSearchTypeIndex.value =
                                tempSelectedSearchTypeIndex.value;
                            _priceRange.value = tempPriceRange.value;
                            _isPriceFilterEnabled.value =
                                isPriceFilterEnabledWidgetNotifier.value;
                          });

                          Navigator.of(context).pop();

                          // Trigger filter application
                          _applyProductFilters(
                            tempSelectedServiceId.value,
                            _selectedSearchTypeIndex.value,
                            _priceRange.value,
                            _isPriceFilterEnabled.value,
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          backgroundColor: const Color(0xFF6132E4),
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shadowColor: const Color(0xFF6132E4).withOpacity(0.3),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.check, size: 18),
                            SizedBox(width: 8),
                            Text(
                              'Apply Filters',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Inter',
                              ),
                            ),
                          ],
                        ),
                      ),
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

  // Helper function to round numbers to meaningful values
  double _roundToMeaningfulNumber(double value) {
    if (value < 100) {
      return (value / 10).round() * 10.0;
    } else if (value < 1000) {
      return (value / 100).round() * 100.0;
    } else if (value < 10000) {
      return (value / 1000).round() * 1000.0;
    } else {
      return (value / 5000).round() * 5000.0;
    }
  }

  // Helper function to generate dynamic quick filters based on max price
  List<Map<String, dynamic>> _generateQuickFilters(
      double minPrice, double maxPrice) {
    final List<Map<String, dynamic>> filters = [];

    // Calculate dynamic ranges based on maxPrice
    double range1 = maxPrice * 0.1; // 10% of max
    double range2 = maxPrice * 0.25; // 25% of max
    double range3 = maxPrice * 0.5; // 50% of max
    double range4 = maxPrice * 0.75; // 75% of max

    // Round to nearest meaningful number
    range1 = _roundToMeaningfulNumber(range1);
    range2 = _roundToMeaningfulNumber(range2);
    range3 = _roundToMeaningfulNumber(range3);
    range4 = _roundToMeaningfulNumber(range4);

    // Ensure ranges are distinct and meaningful
    if (range1 > minPrice && range1 < maxPrice) {
      filters.add({
        'label': 'Under ${range1.toCurrency()}',
        'range': RangeValues(minPrice, range1),
      });
    }

    if (range2 > range1 && range2 < maxPrice) {
      filters.add({
        'label': '${range1.toCurrency()} - ${range2.toCurrency()}',
        'range': RangeValues(range1, range2),
      });
    }

    if (range3 > range2 && range3 < maxPrice) {
      filters.add({
        'label': '${range2.toCurrency()} - ${range3.toCurrency()}',
        'range': RangeValues(range2, range3),
      });
    }

    if (range4 > range3 && range4 < maxPrice) {
      filters.add({
        'label': '${range3.toCurrency()} - ${range4.toCurrency()}',
        'range': RangeValues(range3, range4),
      });
    }

    // Always add "Above X" filter
    if (range4 < maxPrice) {
      filters.add({
        'label': 'Above ${range4.toCurrency()}',
        'range': RangeValues(range4, maxPrice),
      });
    }

    // Fallback: if no meaningful ranges, create simple divisions
    if (filters.isEmpty) {
      final quarter = (maxPrice - minPrice) / 4;
      filters.addAll([
        {
          'label': 'Under ${(minPrice + quarter).toCurrency()}',
          'range': RangeValues(minPrice, minPrice + quarter),
        },
        {
          'label':
              '${(minPrice + quarter).toCurrency()} - ${(minPrice + 2 * quarter).toCurrency()}',
          'range': RangeValues(minPrice + quarter, minPrice + 2 * quarter),
        },
        {
          'label':
              '${(minPrice + 2 * quarter).toCurrency()} - ${(minPrice + 3 * quarter).toCurrency()}',
          'range': RangeValues(minPrice + 2 * quarter, minPrice + 3 * quarter),
        },
        {
          'label': 'Above ${(minPrice + 3 * quarter).toCurrency()}',
          'range': RangeValues(minPrice + 3 * quarter, maxPrice),
        },
      ]);
    }

    return filters;
  }

  Widget _buildQuickFilterChip(
    String label,
    RangeValues range,
    ValueNotifier<RangeValues> currentRange,
    void Function(RangeValues) onChanged,
  ) =>
      ValueListenableBuilder<RangeValues>(
        valueListenable: currentRange,
        builder: (context, current, child) {
          final isSelected =
              current.start == range.start && current.end == range.end;

          return GestureDetector(
            onTap: () {
              currentRange.value = range;
              onChanged(range);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color:
                    isSelected ? const Color(0xFF6132E4) : Colors.grey.shade50,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: isSelected
                      ? const Color(0xFF6132E4)
                      : Colors.grey.shade300,
                ),
              ),
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  color: isSelected ? Colors.white : Colors.grey.shade700,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                ),
              ),
            ),
          );
        },
      );

  /// Apply product filters based on selection
  void _applyProductFilters(
    int? serviceId,
    int searchTypeIndex,
    RangeValues priceRange,
    bool isPriceEnabled,
  ) {
    final searchTerm = _searchController.text.trim();

    // Determine search type
    String? searchType;
    switch (searchTypeIndex) {
      case 0:
        searchType = 'name';
        break;
      case 1:
        searchType = 'category';
        break;
      case 2:
        searchType = 'model';
        break;
      case 3:
        searchType = 'color';
        break;
    }

    // Apply filter with service ID, search parameters, and price range
    context.read<StockManagementCubit>().loadProducts(
          serviceId: serviceId,
          searchQuery: searchTerm,
          searchType: searchType,
          startPrice: isPriceEnabled ? priceRange.start.toInt() : null,
          endPrice: isPriceEnabled ? priceRange.end.toInt() : null,
          page: 1,
        );

    // Show feedback
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Filters applied: ${searchType ?? 'all'}'
          '${isPriceEnabled ? ', price: ${priceRange.start.toCurrency()} - ${priceRange.end.toCurrency()}' : ''}',
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
