import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:bookie_buddy_web/core/app_dependencies.dart';
import 'package:bookie_buddy_web/core/models/pagination_model.dart';
import 'package:bookie_buddy_web/core/models/product_model/product_model.dart';
import 'package:bookie_buddy_web/core/repositories/product_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_search_event.dart';
part 'product_search_state.dart';
part 'product_search_bloc.freezed.dart';

class ProductSearchBloc extends Bloc<ProductSearchEvent, ProductSearchState> {
  final ProductRepository _repository = getIt.get<ProductRepository>();
  ProductSearchBloc()
      : super(const _Initial(
          suggestions: [],
          searchQuery: '',
          selectedProduct: null,
        )) {
    on<_ProductSelected>(_onProductSelected);
    on<_ClearSelected>(_onClearSelected);
    on<_SearchQueryChanged>(_onSearchChanged);
    on<_LoadNextData>(_onLoadNexData);
  }

  Future<void> _onSearchChanged(
      _SearchQueryChanged event, Emitter<ProductSearchState> emit) async {
    try {
      final result = await _repository.searchAllProducts(
        page: 1,
        query: event.query,
      );

      emit(_Initial(
        suggestions: result.data,
        selectedProduct: null,
        isLoading: false,
        searchQuery: event.query,
        nextPageUrl: result.nextPageUrl,
      ));
    } catch (e, stack) {
      log(e.toString(), stackTrace: stack);
      emit(const _Initial(
        suggestions: [],
        selectedProduct: null,
        isLoading: false,
        searchQuery: '',
      ));
    }
  }

  Future<void> _onLoadNexData(
      _LoadNextData event, Emitter<ProductSearchState> emit) async {
    final s = state as _Initial;

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
      log('Updated Suggestions Count: ${s.suggestions.length + result.data.length}');

      emit(s.copyWith(
        // suggestions: [...s.suggestions, ...result.data],
        suggestions: result.data,
        isLoading: false,
        nextPageUrl: result.nextPageUrl,
      ));
    } catch (e, stack) {
      log(e.toString(), stackTrace: stack);
      emit(s.copyWith(isLoading: false));
    }
  }

  void _onProductSelected(
      _ProductSelected event, Emitter<ProductSearchState> emit) {
    emit(_Initial(
      suggestions: [],
      selectedProduct: event.selectedProduct,
      searchQuery: event.selectedProduct.name,
    ));
  }

  void _onClearSelected(
      _ClearSelected event, Emitter<ProductSearchState> emit) {
    emit(const _Initial(
      suggestions: [],
      selectedProduct: null,
      searchQuery: '',
    ));
  }
}
