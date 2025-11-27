import 'dart:async';

import 'package:bookie_buddy_web/core/models/pagination_model/pagination_model.dart';
import 'package:bookie_buddy_web/core/models/sale_model/sale_model.dart';
import 'package:bookie_buddy_web/core/repositories/sales_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'sales_list_event.dart';
part 'sales_list_state.dart';
part 'sales_list_bloc.freezed.dart';


class SalesListBloc extends Bloc<SalesListEvent, SalesListState> {
  final SalesRepository _repository;
  SalesListBloc({required SalesRepository repository})
    : _repository = repository,
      super(const _Loading()) {
    on<_GetSales>(_getSales);
    on<_GetNextPageSales>(_getNextPageSales);
  }

  FutureOr<void> _getSales(
    _GetSales event,
    Emitter<SalesListState> emit,
  ) async {
    if (state is! _Loading) emit(const SalesListState.loading());
    try {
      final result = await _repository.getSalesPagination(
        page: 1,
        fromDate: event.fromDate,
        toDate: event.toDate,
        search: event.search,
      );

      emit(
        SalesListState.loaded(
          sales: result.data,
          nextPageUrl: result.nextPageUrl,
          fromDate: event.fromDate,
          toDate: event.toDate,
          search: event.search,
        ),
      );
    } catch (e) {
      emit(SalesListState.error(e.toString()));
    }
  }

  FutureOr<void> _getNextPageSales(
    _GetNextPageSales event,
    Emitter<SalesListState> emit,
  ) async {
    try {
      if (state is! _Loaded) return;
      final s = state as _Loaded;
      if (s.isPaginating || s.nextPageUrl == null) return;

      emit(s.copyWith(isPaginating: true));

      final nextPage = PaginationModel.getPageFromUrl(s.nextPageUrl);
      final result = await _repository.getSalesPagination(
        page: nextPage,
        fromDate: s.fromDate,
        toDate: s.toDate,
        search: s.search,
      );

      emit(
        s.copyWith(
          sales: [...s.sales, ...result.data],
          nextPageUrl: result.nextPageUrl,
          isPaginating: false,
        ),
      );
    } catch (e) {
      emit(SalesListState.error(e.toString()));
    }
  }
}