import 'dart:async';
import 'dart:developer';

import 'package:bookie_buddy_web/core/models/pagination_model/pagination_model.dart';
import 'package:bookie_buddy_web/features/sales/domain/models/sale_model/sale_model.dart';
import 'package:bookie_buddy_web/features/sales/domain/usecases/get_sales_usecase.dart';
import 'package:bookie_buddy_web/utils/bloc_transforms.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'all_sales_bloc.freezed.dart';
part 'all_sales_event.dart';
part 'all_sales_state.dart';

class AllSalesBloc extends Bloc<AllSalesEvent, AllSalesState> {
  final GetSalesUseCase _getSalesUseCase;

  AllSalesBloc({required GetSalesUseCase getSalesUseCase})
      : _getSalesUseCase = getSalesUseCase,
        super(const AllSalesState.loading()) {
    on<_LoadSales>(_onFetchSales);
    on<_LoadMoreSales>(
      _onLoadMoreSales,
      transformer: throttleDroppable(),
    );
  }

  Future<void> _onLoadMoreSales(
    _LoadMoreSales event,
    Emitter<AllSalesState> emit,
  ) async {
    if (state is! _Loaded) return;
    final s = state as _Loaded;
    if (s.isPaginating || s.nextPageUrl == null) return;

    emit(s.copyWith(isPaginating: true));

    try {
      final nextPage = PaginationModel.getPageFromUrl(s.nextPageUrl);
      final result = await _getSalesUseCase(
        page: nextPage,
        search: s.searchQuery,
        fromDate: s.fromDate,
        toDate: s.toDate,
      );

      emit(
        s.copyWith(
          sales: [...s.sales, ...result.data],
          nextPageUrl: result.nextPageUrl,
          isPaginating: false,
          searchQuery: s.searchQuery,
          fromDate: s.fromDate,
          toDate: s.toDate,
        ),
      );
    } catch (e, stack) {
      log('Error loading more sales: $e', stackTrace: stack);
      emit(_Error(e.toString()));
    }
  }

  Future<void> _onFetchSales(
    _LoadSales event,
    Emitter<AllSalesState> emit,
  ) async {
    emit(const _Loading());

    try {
      final result = await _getSalesUseCase(
        page: event.page ?? 1,
        search: event.searchQuery,
        fromDate: event.fromDate,
        toDate: event.toDate,
      );

      emit(
        _Loaded(
          sales: result.data,
          nextPageUrl: result.nextPageUrl,
          searchQuery: event.searchQuery,
          fromDate: event.fromDate,
          toDate: event.toDate,
        ),
      );
    } catch (e, stack) {
      log('Error loading sales: $e', stackTrace: stack);
      emit(_Error(e.toString()));
    }
  }
}
