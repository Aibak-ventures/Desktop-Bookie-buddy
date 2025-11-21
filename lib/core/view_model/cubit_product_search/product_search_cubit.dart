import 'dart:developer';

import 'package:bookie_buddy_web/core/models/pagination_model/pagination_model.dart';
import 'package:bookie_buddy_web/core/models/product_model/product_model.dart';
import 'package:bookie_buddy_web/core/repositories/product_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_search_state.dart';
part 'product_search_cubit.freezed.dart';

class ProductSearchCubit extends Cubit<ProductSearchState> {
  final ProductRepository _repository;
  ProductSearchCubit({required ProductRepository repository})
      : _repository = repository,
        super(
          const ProductSearchState(
            suggestions: [],
            searchQuery: '',
            selectedProduct: null,
          ),
        );

  Future<List<ProductModel>> searchProducts(String query) async {
    try {
      final result = await _repository.searchAllProducts(page: 1, query: query);

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
      final result = await _repository.searchAllProducts(
        page: nextPage,
        query: s.searchQuery,
      );
      log('data: ${result.data.length}, next page url: ${result.nextPageUrl}');
      log(
        'Updated Suggestions Count: ${s.suggestions.length + result.data.length}',
      );

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

  void selectProduct(ProductModel selectedProduct) {
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

// part of 'product_search_bloc.dart';

// @freezed
// class ProductSearchEvent with _$ProductSearchEvent {
//   const factory ProductSearchEvent.searchQueryChanged(String query) =
//       _SearchQueryChanged;
//   const factory ProductSearchEvent.loadNextData() = _LoadNextData;

//   const factory ProductSearchEvent.productSelected(
//       ProductModel selectedProduct) = _ProductSelected;
//   const factory ProductSearchEvent.clearSelected() = _ClearSelected;
// }
