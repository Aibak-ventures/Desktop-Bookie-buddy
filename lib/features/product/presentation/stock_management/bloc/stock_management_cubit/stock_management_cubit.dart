import 'dart:developer';

import 'package:bookie_buddy_web/features/product/domain/models/product_model/product_model.dart';
import 'package:bookie_buddy_web/features/product/domain/usecases/delete_product_usecase.dart';
import 'package:bookie_buddy_web/features/product/domain/usecases/get_products_paginated_usecase.dart';
import 'package:bookie_buddy_web/features/product/domain/usecases/search_all_products_usecase.dart';
import 'package:bookie_buddy_web/features/product/domain/usecases/search_and_filter_products_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'stock_management_state.dart';
part 'stock_management_cubit.freezed.dart';

class StockManagementCubit extends Cubit<StockManagementState> {
  final GetProductsPaginatedUseCase _getProducts;
  final SearchAndFilterProductsUseCase _searchAndFilterProducts;
  final SearchAllProductsUseCase _searchAllProducts;
  final DeleteProductUseCase _deleteProduct;

  // Track unique categories across all loaded pages for current service
  final Set<String> _uniqueCategories = {};
  String _activeSearchQuery = '';
  String? _activeSearchType;
  int? _activeStartPrice;
  int? _activeEndPrice;
  int? _activeServiceId = -1;

  StockManagementCubit({
    required GetProductsPaginatedUseCase getProducts,
    required SearchAndFilterProductsUseCase searchAndFilterProducts,
    required SearchAllProductsUseCase searchAllProducts,
    required DeleteProductUseCase deleteProduct,
  })  : _getProducts = getProducts,
        _searchAndFilterProducts = searchAndFilterProducts,
        _searchAllProducts = searchAllProducts,
        _deleteProduct = deleteProduct,
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
        _activeServiceId = serviceId ?? -1;
        _activeSearchQuery = searchQuery;
        _activeSearchType = searchType;
        _activeStartPrice = startPrice;
        _activeEndPrice = endPrice;
      }

      final resolvedServiceId = page == 1 ? serviceId : _activeServiceId;
      final resolvedSearchQuery = page == 1 ? searchQuery : _activeSearchQuery;
      final resolvedSearchType = page == 1 ? searchType : _activeSearchType;
      final resolvedStartPrice = page == 1 ? startPrice : _activeStartPrice;
      final resolvedEndPrice = page == 1 ? endPrice : _activeEndPrice;

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
          (resolvedServiceId == null || resolvedServiceId == -1)
              ? null
              : resolvedServiceId;

      final paginationModel = (apiServiceId == null)
          ? await _searchAllProducts(
              query: resolvedSearchQuery,
              page: page,
            )
          : (resolvedSearchQuery.isEmpty &&
                  resolvedStartPrice == null &&
                  resolvedEndPrice == null)
              ? await _getProducts(
                  serviceId: apiServiceId,
                  page: page,
                  includeInStockOnly: false,
                )
              : await _searchAndFilterProducts(
                  serviceId: apiServiceId,
                  query: resolvedSearchQuery,
                  type: resolvedSearchType ?? 'name',
                  startPrice: resolvedStartPrice,
                  endPrice: resolvedEndPrice,
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
          selectedServiceId:
              resolvedServiceId ?? -1, // Default to -1 (All Services)
          searchQuery: resolvedSearchQuery,
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
              selectedServiceId: resolvedServiceId ?? -1,
              searchQuery: resolvedSearchQuery,
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
            serviceId: _activeServiceId,
            searchQuery: _activeSearchQuery,
            searchType: _activeSearchType,
            startPrice: _activeStartPrice,
            endPrice: _activeEndPrice,
            page: page,
          );
        }
      },
      orElse: () async {},
    );
  }

  /// Filter by service ID
  Future<void> filterByService(int? serviceId) async {
    await loadProducts(
      serviceId: serviceId,
      searchQuery: '',
      searchType: null,
      startPrice: null,
      endPrice: null,
      page: 1,
    );
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
      await _deleteProduct(productId: productId);
      // Refresh the list after deletion
      await loadProducts();
    } catch (e) {
      log('Error deleting product: $e');
      rethrow;
    }
  }
}
