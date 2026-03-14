import 'dart:async';

import 'package:bookie_buddy_web/core/models/pagination_model/pagination_model.dart';
import 'package:bookie_buddy_web/features/sales/domain/models/sale_model/sale_model.dart';
import 'package:bookie_buddy_web/features/sales/domain/usecases/get_sales_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'sales_list_event.dart';
part 'sales_list_state.dart';
part 'sales_list_bloc.freezed.dart';

class SalesListBloc extends Bloc<SalesListEvent, SalesListState> {
  final GetSalesUseCase _getSalesUseCase;

  SalesListBloc({required GetSalesUseCase getSalesUseCase})
      : _getSalesUseCase = getSalesUseCase,
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
      print('🔄 SalesListBloc: Fetching sales...');
      final result = await _getSalesUseCase(
        page: 1,
        fromDate: event.fromDate,
        toDate: event.toDate,
        search: event.search,
      );

      print('✅ SalesListBloc: Got ${result.data.length} sales');
      print('📦 First sale: ${result.data.firstOrNull}');

      emit(
        SalesListState.loaded(
          sales: result.data,
          nextPageUrl: result.nextPageUrl,
          fromDate: event.fromDate,
          toDate: event.toDate,
          search: event.search,
        ),
      );

      print('✨ SalesListBloc: State emitted successfully');
    } catch (e, stack) {
      print('❌ SalesListBloc: Error - $e');
      print('Stack: $stack');
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
      final result = await _getSalesUseCase(
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
