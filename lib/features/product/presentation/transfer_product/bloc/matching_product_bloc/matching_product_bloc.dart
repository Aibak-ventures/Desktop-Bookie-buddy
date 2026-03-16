import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:bookie_buddy_web/core/models/pagination_model/pagination_model.dart';
import 'package:bookie_buddy_web/features/product/domain/models/product_model/product_model.dart';
import 'package:bookie_buddy_web/features/product/domain/usecases/get_matching_products_from_another_shop_usecase.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'matching_product_event.dart';
part 'matching_product_state.dart';
part 'matching_product_bloc.freezed.dart';

class MatchingProductBloc
    extends Bloc<MatchingProductEvent, MatchingProductState> {
  final GetMatchingProductsFromAnotherShopUseCase _getMatchingProducts;

  MatchingProductBloc({
    required GetMatchingProductsFromAnotherShopUseCase getMatchingProducts,
  })  : _getMatchingProducts = getMatchingProducts,
        super(const _Loading()) {
    on<_LoadMatchingProducts>(_onLoadMatchingProducts);
    on<_LoadNextPageMatchingProducts>(_onLoadNextPageMatchingProducts);
  }

  FutureOr<void> _onLoadMatchingProducts(
      _LoadMatchingProducts event, Emitter<MatchingProductState> emit) async {
    emit(const _Loading());
    try {
      final result = await _getMatchingProducts(
        fromVariantId: event.fromVariantId,
        toShopId: event.toShopId,
      );

      emit(
        _Loaded(
          products: result.data,
          fromVariantId: event.fromVariantId,
          toShopId: event.toShopId,
          nextPageUrl: result.nextPageUrl,
        ),
      );
    } catch (e, stack) {
      log(e.toString(), stackTrace: stack);
      emit(_Error(e.toString()));
    }
  }

  FutureOr<void> _onLoadNextPageMatchingProducts(
      _LoadNextPageMatchingProducts event,
      Emitter<MatchingProductState> emit) async {
    if (state is! _Loaded) return;
    final s = state as _Loaded;
    if (s.isPaginating || s.nextPageUrl == null) return;

    emit(s.copyWith(isPaginating: true));
    try {
      final nextPage = PaginationModel.getPageFromUrl(s.nextPageUrl);
      final result = await _getMatchingProducts(
        fromVariantId: s.fromVariantId,
        toShopId: s.toShopId,
        page: nextPage,
      );
      emit(
        s.copyWith(
          products: [...s.products, ...result.data],
          nextPageUrl: result.nextPageUrl,
          isPaginating: false,
        ),
      );
    } catch (e, stack) {
      log(e.toString(), stackTrace: stack);
      emit(_Error(e.toString()));
    }
  }
}
