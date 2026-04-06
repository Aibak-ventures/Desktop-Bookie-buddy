import 'package:bookie_buddy_web/core/constants/enums/enums.dart';
import 'package:bookie_buddy_web/core/di/app_dependencies.dart';
import 'package:bookie_buddy_web/features/product/presentation/stock_management/bloc/save_product_cubit/save_product_cubit.dart';
import 'package:bookie_buddy_web/features/product/presentation/stock_management/bloc/stock_management_cubit/stock_management_cubit.dart';
import 'package:bookie_buddy_web/utils/extensions/color_extensions.dart';
import 'package:bookie_buddy_web/features/product/domain/entities/product_entity/product_entity.dart';
import 'package:bookie_buddy_web/core/common/entities/user_entity/user_entity.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:bookie_buddy_web/core/common/widgets/dialogs/perform_secure_action_dialog.dart';
import 'package:bookie_buddy_web/features/shop/presentation/bloc/service_bloc/service_bloc.dart';
import 'package:bookie_buddy_web/features/auth/presentation/bloc/user_cubit/user_cubit.dart';
import 'package:bookie_buddy_web/features/product/presentation/product_details/pages/product_details_screen.dart';
import 'package:bookie_buddy_web/features/product/presentation/product_details/bloc/product_details_cubit/product_details_cubit.dart';
import 'package:bookie_buddy_web/features/product/presentation/stock_management/widgets/add_edit_product_dialog.dart';
import 'package:bookie_buddy_web/features/product/presentation/stock_management/widgets/stock_management_category_tabs.dart';
import 'package:bookie_buddy_web/features/product/presentation/stock_management/widgets/stock_management_filter_dialog.dart';
import 'package:bookie_buddy_web/features/product/presentation/stock_management/widgets/stock_management_product_row.dart';
import 'package:bookie_buddy_web/features/product/presentation/stock_management/widgets/stock_management_search_bar.dart';
import 'package:bookie_buddy_web/features/product/presentation/stock_management/widgets/stock_management_summary_cards.dart';
import 'package:bookie_buddy_web/features/product/presentation/stock_management/widgets/stock_management_table_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    // Force reload services when entering stock screen
    context.read<ServiceBloc>().add(
      const ServiceEvent.loadServices(force: true),
    );

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
  Future<void> _showAddEditProductDialog(
    BuildContext context, {
    ProductEntity? product,
  }) async {
    // Get current selected service ID from state
    final selectedServiceId = await context
        .read<StockManagementCubit>()
        .state
        .maybeWhen(
          loaded: (_, __, ___, ____, _____, serviceId, ______, _______) =>
              serviceId,
          orElse: () => null,
        );

    if (!mounted) return;

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
          serviceId: selectedServiceId,
          product: product,
        ),
      ),
    );

    // Refresh the product list if a product was added/edited
    if (result == true && mounted) {
      // For new products, reload without service filter to ensure visibility
      // For edited products, keep the current filter
      context.read<StockManagementCubit>().loadProducts(
        serviceId: product != null ? selectedServiceId : null,
        searchQuery: _searchController.text,
        page: 1,
      );
    }
  }

  void _showDeleteConfirmationDialog(
    BuildContext context,
    ProductEntity product,
  ) {
    performSecureActionDialog(
      context,
      SecretPasswordLocations.productDeletion,
      onSuccess: () async {
        try {
          await context.read<StockManagementCubit>().deleteProduct(product.id);
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

  /// Show product filter dialog
  void _showProductFilterBottomSheet() {
    // Calculate max price from current product list
    final currentState = context.read<StockManagementCubit>().state;
    final currentProducts = currentState.maybeWhen(
      loaded: (products, _, __, ___, ____, _____, ______, _______) => products,
      orElse: () => <ProductEntity>[],
    );

    if (currentProducts.isNotEmpty) {
      double maxProductPrice = 0;
      for (final product in currentProducts) {
        final productPrice = product.price ?? 0;
        if (productPrice > maxProductPrice) {
          maxProductPrice = productPrice.toDouble();
        }
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

    final selectedServiceId = currentState.maybeWhen(
      loaded: (_, __, ___, ____, _____, serviceId, ______, _______) =>
          serviceId,
      orElse: () => -1,
    );

    showDialog<StockFilterResult>(
      context: context,
      barrierDismissible: true,
      barrierColor: Colors.black.withValues(alpha: 0.5),
      builder: (context) => StockManagementFilterDialog(
        maxPriceNotifier: _maxPriceNotifier,
        initialSearchTypeIndex: _selectedSearchTypeIndex.value,
        initialPriceRange: _priceRange.value,
        initialIsPriceEnabled: _isPriceFilterEnabled.value,
      ),
    ).then((result) {
      if (result != null) {
        setState(() {
          _selectedSearchTypeIndex.value = result.searchTypeIndex;
          _priceRange.value = result.priceRange;
          _isPriceFilterEnabled.value = result.isPriceEnabled;
        });
        _applyProductFilters(
          selectedServiceId == -1 ? null : selectedServiceId,
          result.searchTypeIndex,
          result.priceRange,
          result.isPriceEnabled,
        );
      }
    });
  }

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
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserCubit, UserEntity?>(
      listener: (context, user) {
        // Reload products and services when shop switches
        if (user != null) {
          context.read<ServiceBloc>().add(
            const ServiceEvent.loadServices(force: true),
          );
          context.read<StockManagementCubit>().loadProducts();
        }
      },
      child: Scaffold(
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
                        loaded: (
                          _,
                          __,
                          ___,
                          ____,
                          _____,
                          ______,
                          _______,
                          selectedProductId,
                        ) {
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
                    child: BlocBuilder<StockManagementCubit,
                        StockManagementState>(
                      builder: (context, state) {
                        return state.maybeWhen(
                          loaded: (
                            products,
                            __,
                            ___,
                            ____,
                            _____,
                            selectedServiceId,
                            _______,
                            selectedProductId,
                          ) {
                            if (selectedProductId != null) {
                              final selectedProduct = products.firstWhere(
                                (p) => p.id == selectedProductId,
                                orElse: () => products.first,
                              );
                              return BlocProvider(
                                create: (context) => ProductDetailsCubit(
                                  getProductInfo: getIt.get(),
                                  updateVariant: getIt.get(),
                                  deleteProduct: getIt.get(),
                                  addProductVariants: getIt.get(),
                                  getProductBookings: getIt.get(),
                                  getProductGrowthData: getIt.get(),
                                )..loadProductDetails(selectedProductId),
                                child: ProductDetailsScreen(
                                  productId: selectedProductId,
                                  serviceId: selectedServiceId,
                                  mainServiceType:
                                      selectedProduct.mainServiceType,
                                  productForEdit: selectedProduct,
                                ),
                              );
                            } else {
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
      ),
    );
  }

  Widget _buildHeader() {
    return const Row(
      children: [
        Text(
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

  Widget _buildProductList() {
    return BlocBuilder<StockManagementCubit, StockManagementState>(
      builder: (context, state) {
        final selectedServiceId = state.maybeWhen(
              loaded: (_, __, ___, ____, _____, selected, ______, _______) =>
                  selected,
              orElse: () => -1,
            ) ??
            -1;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const StockManagementSummaryCards(),
            const SizedBox(height: 24),
            StockManagementSearchBar(
              searchController: _searchController,
              selectedSearchTypeIndex: _selectedSearchTypeIndex,
              selectedServiceId: selectedServiceId,
              onFilterTap: _showProductFilterBottomSheet,
              onAddProduct: () => _showAddEditProductDialog(context),
              onSearch: () => _applyProductFilters(
                selectedServiceId == -1 ? null : selectedServiceId,
                _selectedSearchTypeIndex.value,
                _priceRange.value,
                _isPriceFilterEnabled.value,
              ),
            ),
            const SizedBox(height: 20),
            const StockManagementCategoryTabs(),
            const SizedBox(height: 20),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade200, width: 1.5),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.changeOpacity(0.04),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                    BoxShadow(
                      color: Colors.black.changeOpacity(0.02),
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
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ),
              );
            }

            return Column(
              children: [
                const StockManagementTableHeader(),
                Expanded(
                  child: ListView.builder(
                    controller: _scrollController,
                    padding: EdgeInsets.zero,
                    itemCount: products.length + (isPaginating ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index < products.length) {
                        final product = products[index];
                        return StockManagementProductRow(
                          product: product,
                          onTap: () => context
                              .read<StockManagementCubit>()
                              .showProductDetails(product.id),
                          onEdit: () => performSecureActionDialog(
                            context,
                            SecretPasswordLocations.productEdit,
                            onSuccess: () => _showAddEditProductDialog(
                              context,
                              product: product,
                            ),
                          ),
                          onViewDetails: () => context
                              .read<StockManagementCubit>()
                              .showProductDetails(product.id),
                          onDelete: () =>
                              _showDeleteConfirmationDialog(context, product),
                        );
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
                  Icon(
                    Icons.error_outline,
                    size: 48,
                    color: Colors.red.shade300,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    message,
                    style: TextStyle(
                        fontSize: 16, color: Colors.red.shade400),
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
}
