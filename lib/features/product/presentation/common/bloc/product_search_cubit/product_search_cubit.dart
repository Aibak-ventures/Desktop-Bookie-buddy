import 'dart:developer';

import 'package:bookie_buddy_web/core/common/models/pagination_model/pagination_model.dart';
import 'package:bookie_buddy_web/features/product/domain/entities/product_entity/product_entity.dart';
import 'package:bookie_buddy_web/features/product/domain/usecases/search_all_products_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_search_state.dart';
part 'product_search_cubit.freezed.dart';

class ProductSearchCubit extends Cubit<ProductSearchState> {
  final SearchAllProductsUseCase _searchAllProductsUseCase;
  ProductSearchCubit({
    required SearchAllProductsUseCase searchAllProductsUseCase,
  }) : _searchAllProductsUseCase = searchAllProductsUseCase,
       super(
         const ProductSearchState(
           suggestions: [],
           searchQuery: '',
           selectedProduct: null,
         ),
       );

  Future<List<ProductEntity>> searchProducts(String query) async {
    try {
      final result = await _searchAllProductsUseCase(page: 1, query: query);

      emit(
        ProductSearchState(
          suggestions: result.data,
          selectedProduct: null,
          searchQuery: query,
          nextPageUrl: result.nextPageUrl,
        ),
      );

      return result.data;
    } catch (e, stack) {
      log(e.toString(), stackTrace: stack);
      emit(
        const ProductSearchState(
          suggestions: [],
          selectedProduct: null,
          searchQuery: '',
        ),
      );
      return [];
    }
  }

  Future<void> loadNexData() async {
    final s = state;

    if (s.isLoading) return;

    try {
      emit(s.copyWith(isLoading: true));
      final nextPage = PaginationModel.getPageFromUrl(s.nextPageUrl);
      log('loading next page: $nextPage with query: ${s.searchQuery}');
      final result = await _searchAllProductsUseCase(
        page: nextPage,
        query: s.searchQuery,
      );
      log('data: ${result.data.length}, next page url: ${result.nextPageUrl}');
      log('Updated Suggestions Count: ${s.suggestions.length + result.data.length}');

      emit(
        s.copyWith(
          suggestions: [...s.suggestions, ...result.data],
          isLoading: false,
          nextPageUrl: result.nextPageUrl,
        ),
      );
    } catch (e, stack) {
      log(e.toString(), stackTrace: stack);
      emit(s.copyWith(isLoading: false));
    }
  }

  void selectProduct(ProductEntity selectedProduct) {
    emit(
      ProductSearchState(
        suggestions: [],
        selectedProduct: selectedProduct,
        searchQuery: selectedProduct.name,
      ),
    );
  }

  void clearSelected() {
    emit(
      const ProductSearchState(
        suggestions: [],
        selectedProduct: null,
        searchQuery: '',
      ),
    );
  }
}
