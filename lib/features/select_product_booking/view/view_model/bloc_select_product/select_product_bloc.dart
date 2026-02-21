import 'package:bookie_buddy_web/core/models/pagination_model/pagination_model.dart';
import 'package:bookie_buddy_web/core/models/product_model/product_model.dart';
import 'package:bookie_buddy_web/core/repositories/product_repository.dart';
import 'package:bookie_buddy_web/utils/bloc_transforms.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'select_product_bloc.freezed.dart';
part 'select_product_event.dart';
part 'select_product_state.dart';

class SelectProductBloc extends Bloc<SelectProductEvent, SelectProductState> {
  final ProductRepository _repository;

  SelectProductBloc({required ProductRepository repository})
      : _repository = repository,
        super(const _Loading()) {
    on<_LoadProducts>(_onLoadProducts);
    on<_LoadNextPageProducts>(
      _onLoadNextPageProducts,
      transformer: throttleDroppable(),
    );
    on<_SearchProducts>(_onSearchProducts, transformer: debounceDroppable());
    on<_LoadNextSearchResults>(
      _onLoadNextSearchResults,
      transformer: throttleDroppable(),
    );
  }

  Future<void> _onLoadProducts(
    _LoadProducts event,
    Emitter<SelectProductState> emit,
  ) async {
    emit(const _Loading());
    try {
      final PaginationModel<ProductModel> result;
      // Convert 0 to null for "All Services" mode
      final serviceId = event.serviceId == 0 ? null : event.serviceId;
      if (event.useAvailableProductsApi) {
        result = await _repository.getAvailableProductsPaginated(
          serviceId: serviceId,
          page: 1,
          pickupDate: event.pickupDate,
          returnDate: event.returnDate,
          nextPageUrl: null,
          pickupTime: event.pickupTime,
          returnTime: event.returnTime,
          bookingId: event.bookingId,
          variantIds: event.variantIds,
        );
      } else {
        result = await _repository.getProductsPaginated(
          serviceId: serviceId,
          page: 1,
          includeInStockOnly: event.isSales,
        );
      }

      emit(
        _Loaded(
          products: result.data,
          nextPageUrl: result.nextPageUrl,
          pickupDate: event.pickupDate,
          returnDate: event.returnDate,
          serviceId: event.serviceId,
          pickupTime: event.pickupTime,
          returnTime: event.returnTime,
          useAvailableProductsApi: event.useAvailableProductsApi,
          isSales: event.isSales,
        ),
      );
    } catch (e) {
      emit(_Error(e.toString()));
    }
  }

  Future<void> _onLoadNextPageProducts(
    _LoadNextPageProducts event,
    Emitter<SelectProductState> emit,
  ) async {
    if (state is! _Loaded) return;
    final s = state as _Loaded;
    if (s.isPaginating || s.nextPageUrl == null) return;

    emit(s.copyWith(isPaginating: true));
    try {
      final page = PaginationModel.getPageFromUrl(s.nextPageUrl);
      final PaginationModel<ProductModel> result;
      // Convert 0 to null for "All Services" mode
      final serviceId = s.serviceId == 0 ? null : s.serviceId;
      if (s.useAvailableProductsApi) {
        result = await _repository.getAvailableProductsPaginated(
          serviceId: serviceId,
          page: page,
          pickupDate: s.pickupDate,
          returnDate: s.returnDate,
          nextPageUrl: s.nextPageUrl,
          startPrice: s.startPrice,
          endPrice: s.endPrice,
          pickupTime: s.pickupTime,
          returnTime: s.returnTime,
        );
      } else {
        result = await _repository.getProductsPaginated(
          serviceId: serviceId,
          page: page,
          includeInStockOnly: s.isSales,
        );
      }

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
    Emitter<SelectProductState> emit,
  ) async {
    emit(const _Loading());

    try {
      final PaginationModel<ProductModel> result;
      // Convert 0 to null for "All Services" mode
      final serviceId = event.serviceId == 0 ? null : event.serviceId;
      if (event.useAvailableProductsApi) {
        result = await _repository.getAvailableProductsPaginated(
          serviceId: serviceId,
          page: 1,
          query: event.query,
          type: event.type,
          pickupDate: event.pickupDate,
          returnDate: event.returnDate,
          nextPageUrl: null,
          startPrice: event.startPrice,
          endPrice: event.endPrice,
          pickupTime: event.pickupTime,
          returnTime: event.returnTime,
          bookingId: event.bookingId,
          variantIds: event.variantIds,
        );
      } else {
        result = await _repository.searchAndFilterProducts(
          serviceId: serviceId,
          query: event.query,
          type: event.type,
          endPrice: event.endPrice,
          startPrice: event.startPrice,
          includeInStockOnly: event.isSales,
        );
      }
      emit(
        _Loaded(
          products: result.data,
          nextPageUrl: result.nextPageUrl,
          isSearching: true,
          searchQuery: event.query,
          searchType: event.type,
          pickupDate: event.pickupDate,
          returnDate: event.returnDate,
          serviceId: event.serviceId,
          startPrice: event.startPrice,
          endPrice: event.endPrice,
          pickupTime: event.pickupTime,
          returnTime: event.returnTime,
          useAvailableProductsApi: event.useAvailableProductsApi,
          isSales: event.isSales,
        ),
      );
    } catch (e) {
      emit(_Error(e.toString()));
    }
  }

  Future<void> _onLoadNextSearchResults(
    _LoadNextSearchResults event,
    Emitter<SelectProductState> emit,
  ) async {
    if (state is! _Loaded) return;
    final s = state as _Loaded;
    if (!s.isSearching || s.isPaginating || s.nextPageUrl == null) return;

    emit(s.copyWith(isPaginating: true));
    try {
      final page = PaginationModel.getPageFromUrl(s.nextPageUrl);
      final PaginationModel<ProductModel> result;
      // Convert 0 to null for "All Services" mode
      final serviceId = s.serviceId == 0 ? null : s.serviceId;
      if (s.useAvailableProductsApi) {
        result = await _repository.getAvailableProductsPaginated(
          serviceId: serviceId,
          page: page,
          query: s.searchQuery,
          type: s.searchType,
          nextPageUrl: s.nextPageUrl,
          pickupDate: s.pickupDate,
          returnDate: s.returnDate,
          startPrice: s.startPrice,
          endPrice: s.endPrice,
          pickupTime: s.pickupTime,
          returnTime: s.returnTime,
        );
      } else {
        result = await _repository.searchAndFilterProducts(
          serviceId: serviceId,
          page: page,
          query: s.searchQuery,
          type: s.searchType,
          endPrice: s.endPrice,
          startPrice: s.startPrice,
          includeInStockOnly: s.isSales,
        );
      }

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
}
