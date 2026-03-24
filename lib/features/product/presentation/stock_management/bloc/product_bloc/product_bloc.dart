import 'package:bloc/bloc.dart';
import 'package:bookie_buddy_web/core/common/models/pagination_model/pagination_model.dart';
import 'package:bookie_buddy_web/features/product/domain/entities/product_entity/product_entity.dart';
import 'package:bookie_buddy_web/features/product/domain/usecases/get_products_paginated_usecase.dart';
import 'package:bookie_buddy_web/features/product/domain/usecases/search_and_filter_products_usecase.dart';
import 'package:bookie_buddy_web/utils/bloc_transforms.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_bloc.freezed.dart';
part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final GetProductsPaginatedUseCase _getProducts;
  final SearchAndFilterProductsUseCase _searchAndFilterProducts;

  ProductBloc({
    required GetProductsPaginatedUseCase getProducts,
    required SearchAndFilterProductsUseCase searchAndFilterProducts,
  }) : _getProducts = getProducts,
       _searchAndFilterProducts = searchAndFilterProducts,
       super(const _Loading()) {
    on<_LoadProducts>(_onLoadProducts);
    on<_LoadNextPageProducts>(
      _onLoadNextPageProducts,
      transformer: throttleDroppable(),
    );
    on<_SearchProducts>(_onSearchProducts, transformer: debounceDroppable());
  }

  Future<void> _onLoadProducts(
    _LoadProducts event,
    Emitter<ProductState> emit,
  ) async {
    emit(const _Loading());
    try {
      final result = await _getProducts(serviceId: event.serviceId, page: 1);
      emit(_Loaded(products: result.data, nextPageUrl: result.nextPageUrl));
    } catch (e) {
      emit(_Error(e.toString()));
    }
  }

  Future<void> _onLoadNextPageProducts(
    _LoadNextPageProducts event,
    Emitter<ProductState> emit,
  ) async {
    if (state is! _Loaded) return;
    final s = state as _Loaded;
    if (s.isPaginating || s.nextPageUrl == null) return;

    emit(s.copyWith(isPaginating: true));

    try {
      final page = PaginationModel.getPageFromUrl(s.nextPageUrl);
      final result = s.isSearching
          ? await _searchAndFilterProducts(
              serviceId: event.serviceId,
              query: s.searchQuery,
              type: s.searchType,
              page: page,
              startPrice: s.startPrice,
              endPrice: s.endPrice,
            )
          : await _getProducts(serviceId: event.serviceId, page: page);

      emit(
        s.copyWith(
          products: [...s.products, ...result.data],
          nextPageUrl: result.nextPageUrl,
          isPaginating: false,
        ),
      );
    } catch (e) {
      emit(_Error(e.toString()));
    }
  }

  Future<void> _onSearchProducts(
    _SearchProducts event,
    Emitter<ProductState> emit,
  ) async {
    emit(const _Loading());
    try {
      final result = await _searchAndFilterProducts(
        serviceId: event.serviceId,
        query: event.query,
        type: event.type,
        page: 1,
        startPrice: event.startPrice,
        endPrice: event.endPrice,
      );

      emit(
        _Loaded(
          products: result.data,
          nextPageUrl: result.nextPageUrl,
          isSearching: true,
          searchQuery: event.query,
          searchType: event.type,
        ),
      );
    } catch (e) {
      emit(_Error(e.toString()));
    }
  }
}
