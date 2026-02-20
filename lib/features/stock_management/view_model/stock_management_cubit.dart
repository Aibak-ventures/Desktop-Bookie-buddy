import 'dart:developer';

import 'package:bookie_buddy_web/core/repositories/product_repository.dart';
import 'package:bookie_buddy_web/features/stock_management/view_model/stock_management_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StockManagementCubit extends Cubit<StockManagementState> {
  final ProductRepository _repository;
  
  // Track unique categories across all loaded pages for current service
  final Set<String> _uniqueCategories = {};

  StockManagementCubit({required ProductRepository repository})
      : _repository = repository,
        super(const StockManagementState.initial());

  /// Load products with optional filtering and searching
  Future<void> loadProducts({
    int? serviceId, // null or -1 means "All Services"
    String searchQuery = '',
    String? searchType,
    int? startPrice,
    int? endPrice,
    int page = 1,
  }) async {
    try {
      if (page == 1) {
        emit(const StockManagementState.loading());
        // Reset categories when loading first page or switching services
        _uniqueCategories.clear();
      } else {
        // Keep current state but mark as paginating
        state.maybeWhen(
          loaded: (products,
              totalProducts,
              totalCategories,
              nextPageUrl,
              isPaginating,
              selectedServiceId,
              currentQuery,
              selectedProductId) {
            emit(StockManagementState.loaded(
              products: products,
              totalProducts: totalProducts,
              totalCategories: totalCategories,
              nextPageUrl: nextPageUrl,
              isPaginating: true,
              selectedServiceId: selectedServiceId,
              searchQuery: currentQuery,
              selectedProductId: selectedProductId,
            ));
          },
          orElse: () {},
        );
      }

      // Prepare the service ID for API (null if -1 or null means all services)
      final int? apiServiceId =
          (serviceId == null || serviceId == -1) ? null : serviceId;

      final paginationModel = (apiServiceId == null)
          ? await _repository.searchAllProducts(
              query: searchQuery,
              page: page,
            )
          : (searchQuery.isEmpty && startPrice == null && endPrice == null)
              ? await _repository.getProductsPaginated(
                  serviceId: apiServiceId,
                  page: page,
                  includeInStockOnly: false,
                )
              : await _repository.searchAndFilterProducts(
                  serviceId: apiServiceId,
                  query: searchQuery,
                  type: searchType ?? 'name',
                  startPrice: startPrice,
                  endPrice: endPrice,
                  page: page,
                  includeInStockOnly: false,
                );

      final productList = paginationModel.data;
      final nextPageUrl = paginationModel.nextPageUrl;
      final totalProducts = paginationModel.totalData;

      // Accumulate unique categories from loaded products
      for (final product in productList) {
        if (product.category != null && product.category!.isNotEmpty) {
          _uniqueCategories.add(product.category!);
        }
      }
      final totalCategories = _uniqueCategories.length;

      if (page == 1) {
        emit(StockManagementState.loaded(
          products: productList,
          totalProducts: totalProducts,
          totalCategories: totalCategories,
          nextPageUrl: nextPageUrl,
          isPaginating: false,
          selectedServiceId: serviceId ?? -1, // Default to -1 (All Services)
          searchQuery: searchQuery,
        ));
      } else {
        // Append to existing products
        state.maybeWhen(
          loaded: (existingProducts, _, __, ___, ____, _____, ______,
              selectedProductId) {
            emit(StockManagementState.loaded(
              products: [...existingProducts, ...productList],
              totalProducts: totalProducts,
              totalCategories: totalCategories,
              nextPageUrl: nextPageUrl,
              isPaginating: false,
              selectedServiceId: serviceId ?? -1,
              searchQuery: searchQuery,
              selectedProductId: selectedProductId,
            ));
          },
          orElse: () {},
        );
      }
    } catch (e) {
      log('Error loading products: $e');
      emit(StockManagementState.error(
        message: 'An error occurred: $e',
      ));
    }
  }

  /// Load next page of products
  Future<void> loadNextPage() async {
    await state.maybeWhen(
      loaded: (products,
          totalProducts,
          totalCategories,
          nextPageUrl,
          isPaginating,
          selectedServiceId,
          searchQuery,
          selectedProductId) async {
        if (nextPageUrl != null && !isPaginating) {
          // Extract page number from next URL
          final uri = Uri.parse(nextPageUrl);
          final page = int.tryParse(uri.queryParameters['page'] ?? '1') ?? 1;
          await loadProducts(
            serviceId: selectedServiceId,
            searchQuery: searchQuery,
            page: page,
          );
        }
      },
      orElse: () async {},
    );
  }

  /// Filter by service ID
  Future<void> filterByService(int? serviceId) async {
    await loadProducts(serviceId: serviceId, searchQuery: '', page: 1);
  }

  /// Search products
  Future<void> searchProducts(String query) async {
    await state.maybeWhen(
      loaded:
          (_, __, ___, ____, _____, selectedServiceId, ______, _______) async {
        await loadProducts(
          serviceId: selectedServiceId,
          searchQuery: query,
          page: 1,
        );
      },
      orElse: () async {
        await loadProducts(searchQuery: query, page: 1);
      },
    );
  }

  /// Show product details
  void showProductDetails(int productId) {
    state.maybeWhen(
      loaded: (products, totalProducts, totalCategories, nextPageUrl,
          isPaginating, selectedServiceId, searchQuery, _) {
        emit(StockManagementState.loaded(
          products: products,
          totalProducts: totalProducts,
          totalCategories: totalCategories,
          nextPageUrl: nextPageUrl,
          isPaginating: isPaginating,
          selectedServiceId: selectedServiceId,
          searchQuery: searchQuery,
          selectedProductId: productId,
        ));
      },
      orElse: () {},
    );
  }

  /// Hide product details (return to list view)
  void hideProductDetails() {
    state.maybeWhen(
      loaded: (products, totalProducts, totalCategories, nextPageUrl,
          isPaginating, selectedServiceId, searchQuery, _) {
        emit(StockManagementState.loaded(
          products: products,
          totalProducts: totalProducts,
          totalCategories: totalCategories,
          nextPageUrl: nextPageUrl,
          isPaginating: isPaginating,
          selectedServiceId: selectedServiceId,
          searchQuery: searchQuery,
          selectedProductId: null,
        ));
      },
      orElse: () {},
    );
  }

  /// Delete a product
  Future<void> deleteProduct(int productId) async {
    try {
      await _repository.deleteProduct(productId: productId);
      // Refresh the list after deletion
      await loadProducts();
    } catch (e) {
      log('Error deleting product: $e');
      rethrow;
    }
  }
}
