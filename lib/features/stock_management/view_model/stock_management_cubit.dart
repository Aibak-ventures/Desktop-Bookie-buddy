import 'dart:developer';

import 'package:bookie_buddy_web/core/repositories/product_repository.dart';
import 'package:bookie_buddy_web/features/stock_management/view_model/stock_management_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StockManagementCubit extends Cubit<StockManagementState> {
  final ProductRepository _repository;

  StockManagementCubit({required ProductRepository repository})
      : _repository = repository,
        super(const StockManagementState.initial());

  /// Load products with optional filtering and searching
  Future<void> loadProducts({
    String category = 'All products',
    String searchQuery = '',
    int page = 1,
  }) async {
    try {
      if (page == 1) {
        emit(const StockManagementState.loading());
      } else {
        // Keep current state but mark as paginating
        state.maybeWhen(
          loaded: (products, totalProducts, totalCategories, nextPageUrl,
              isPaginating, selectedCategory, currentQuery) {
            emit(StockManagementState.loaded(
              products: products,
              totalProducts: totalProducts,
              totalCategories: totalCategories,
              nextPageUrl: nextPageUrl,
              isPaginating: true,
              selectedCategory: selectedCategory,
              searchQuery: currentQuery,
            ));
          },
          orElse: () {},
        );
      }

      // Use searchAllProducts which calls the product-search API
      // This API supports both search and getting all products
      final paginationModel = await _repository.searchAllProducts(
        query: searchQuery.isEmpty ? null : searchQuery,
        page: page,
      );

      final productList = paginationModel.data;
      final nextPageUrl = paginationModel.nextPageUrl;
      final totalProducts = paginationModel.totalData;

      // Calculate total categories (dummy for now as requested)
      final totalCategories = 5;

      if (page == 1) {
        emit(StockManagementState.loaded(
          products: productList,
          totalProducts: totalProducts,
          totalCategories: totalCategories,
          nextPageUrl: nextPageUrl,
          isPaginating: false,
          selectedCategory: category,
          searchQuery: searchQuery,
        ));
      } else {
        // Append to existing products
        state.maybeWhen(
          loaded: (existingProducts, _, __, ___, ____, _____, ______) {
            emit(StockManagementState.loaded(
              products: [...existingProducts, ...productList],
              totalProducts: totalProducts,
              totalCategories: totalCategories,
              nextPageUrl: nextPageUrl,
              isPaginating: false,
              selectedCategory: category,
              searchQuery: searchQuery,
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
      loaded: (products, totalProducts, totalCategories, nextPageUrl,
          isPaginating, selectedCategory, searchQuery) async {
        if (nextPageUrl != null && !isPaginating) {
          // Extract page number from next URL
          final uri = Uri.parse(nextPageUrl);
          final page = int.tryParse(uri.queryParameters['page'] ?? '1') ?? 1;
          await loadProducts(
            category: selectedCategory,
            searchQuery: searchQuery,
            page: page,
          );
        }
      },
      orElse: () async {},
    );
  }

  /// Filter by category
  Future<void> filterByCategory(String category) async {
    await loadProducts(category: category, searchQuery: '', page: 1);
  }

  /// Search products
  Future<void> searchProducts(String query) async {
    await state.maybeWhen(
      loaded: (_, __, ___, ____, _____, selectedCategory, ______) async {
        await loadProducts(
          category: selectedCategory,
          searchQuery: query,
          page: 1,
        );
      },
      orElse: () async {
        await loadProducts(searchQuery: query, page: 1);
      },
    );
  }
}
