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
              border: Border.all(color: Colors.grey.shade200),
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

            return LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: SizedBox(
                    width: constraints.maxWidth < 1000
                        ? 1000
                        : constraints.maxWidth,
                    child: Column(
                      children: [
                        _buildTableHeader(),
                        Expanded(
                          child: ListView.builder(
                            padding: EdgeInsets.zero,
                            itemCount: products.length + (isPaginating ? 1 : 0),
                            itemBuilder: (context, index) {
                              if (index < products.length) {
                                return _buildProductRow(products[index]);
                              } else {
                                return const Padding(
                                  padding: EdgeInsets.all(16),
                                  child: Center(
                                    child: CircularProgressIndicator(
                                      color: Color(0xFF8A63FE),
                                    ),
                                  ),
                                );
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
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
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: const BoxDecoration(
        color: Color(0xFFF1F0FF),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
      child: Row(
        children: [
          const SizedBox(width: 11), // Match the bar (3px) + spacing (8px)
          SizedBox(
            width: 241,
            child: Text(
              'ITEM',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ),
          const SizedBox(width: 12),
          SizedBox(
            width: 133,
            child: Text(
              'CATEGORY',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ),
          const SizedBox(width: 12),
          SizedBox(
            width: 117,
            child: Text(
              'SALE PRICE',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ),
          const SizedBox(width: 12),
          SizedBox(
            width: 102,
            child: Text(
              'RENT PRICE',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ),
          const SizedBox(width: 12),
          SizedBox(
            width: 106,
            child: Text(
              'TOTAL QTY',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(width: 12),
          SizedBox(
            width: 106,
            child: Text(
              'TOTAL VRNT',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(width: 12),
          SizedBox(
            width: 120,
            child: Text(
              'ACTIONS',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
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
      child: InkWell(
        onTap: () {
          // Navigate to product details when clicking anywhere on the row
          context.read<StockManagementCubit>().showProductDetails(product.id);
        },
        hoverColor: AppColors.purple.withOpacity(0.04),
        splashColor: AppColors.purple.withOpacity(0.1),
        highlightColor: AppColors.purple.withOpacity(0.05),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(color: Colors.grey.shade100),
            ),
          ),
          child: Row(
            children: [
              const SizedBox(width: 11), // Match header spacing
              // Item (image + name) - Width: 241
              SizedBox(
                width: 241,
                child: Row(
                  children: [
                    Container(
                      width: 52,
                      height: 52,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: product.thumbnailImage != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(6),
                              child: CustomNetworkImage(
                                imageUrl: product.thumbnailImage!,
                                width: 52,
                                height: 52,
                                fit: BoxFit.cover,
                              ),
                            )
                          : Icon(Icons.image,
                              color: Colors.grey.shade400, size: 24),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product.name,
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF1F2937),
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          if (product.description != null &&
                              product.description!.isNotEmpty)
                            Text(
                              product.description!,
                              style: TextStyle(
                                fontSize: 11,
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
              const SizedBox(width: 12),
              // Category - Width: 133
              SizedBox(
                width: 133,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.purple.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      product.category ?? 'Bridals',
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: AppColors.purple,
                      ),
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              // Sale Price - Width: 117
              SizedBox(
                width: 117,
                child: Text(
                  product.price != null ? '₹ ${product.price}' : '-',
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF1F2937),
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 12),
              // Rent Price - Width: 102
              SizedBox(
                width: 102,
                child: Text(
                  product.price != null ? '₹ ${product.price}' : '-',
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF1F2937),
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 12),
              // Total Quantity - Width: 106
              SizedBox(
                width: 106,
                child: Text(
                  totalStock.toString(),
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1F2937),
                  ),
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 12),
              // Total Variants - Width: 106
              SizedBox(
                width: 106,
                child: Text(
                  variantCount.toString(),
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1F2937),
                  ),
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 12),
              // Actions - Width: 120
              SizedBox(
                width: 120,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {
                        _showAddEditProductDialog(context, product: product);
                      },
                      icon: Icon(
                        Icons.edit_outlined,
                        size: 20,
                        color: Colors.grey.shade600,
                      ),
                      tooltip: 'Edit',
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                    const SizedBox(width: 8),
                    IconButton(
                      onPressed: () {
                        // Use state-based navigation to show product details as full screen
                        context
                            .read<StockManagementCubit>()
                            .showProductDetails(product.id);
                      },
                      icon: Icon(
                        Icons.visibility_outlined,
                        size: 20,
                        color: Colors.grey.shade600,
                      ),
                      tooltip: 'View',
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                    const SizedBox(width: 8),
                    IconButton(
                      onPressed: () {
                        _showDeleteConfirmationDialog(context, product);
                      },
                      icon: Icon(
                        Icons.delete_outline,
                        size: 20,
                        color: Colors.grey.shade600,
                      ),
                      tooltip: 'Delete',
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
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
