import 'package:bookie_buddy_web/core/models/product_model/product_model.dart';
import 'package:bookie_buddy_web/core/repositories/product_repository.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
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
                  // Filter button - could open filter dialog
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
              'QUANTITY',
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
                              if (product.description != null &&
                                  product.description!.isNotEmpty) ...[
                                const SizedBox(height: 4),
                                Text(
                                  product.description!,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey.shade600,
                                    height: 1.4,
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
                                product.category!,
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
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Delete Product'),
        content: Text(
            'Are you sure you want to delete product "${product.name}"? This action cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(dialogContext);
              try {
                // Show loading indicator if possible, or just call the cubit
                await context
                    .read<StockManagementCubit>()
                    .deleteProduct(product.id);
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text('Product deleted successfully')),
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
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
