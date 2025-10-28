import 'dart:async';
import 'dart:developer';

import 'package:bookie_buddy_web/core/models/pagination_model/pagination_model.dart';
import 'package:bookie_buddy_web/core/models/sale_model/sale_model.dart';
import 'package:bookie_buddy_web/core/repositories/staff_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'staff_analytics_sales_event.dart';
part 'staff_analytics_sales_state.dart';
part 'staff_analytics_sales_bloc.freezed.dart';

class StaffAnalyticsSalesBloc
    extends Bloc<StaffAnalyticsSalesEvent, StaffAnalyticsSalesState> {
  final StaffRepository _repository;
  StaffAnalyticsSalesBloc({required StaffRepository repository})
    : _repository = repository,
      super(const _Loading()) {
    on<_LoadSales>(_onLoadSales);
    on<_LoadNextPageSales>(_onLoadNextPageSales);
  }

  FutureOr<void> _onLoadSales(
    _LoadSales event,
    Emitter<StaffAnalyticsSalesState> emit,
  ) async {
    if (state is! _Loading) emit(const _Loading());
    try {
      final result = await _repository.getStaffMonthlySalesPagination(
        staffId: event.staffId,
        year: event.year,
        month: event.month,
      );
      emit(
        _Loaded(
          sales: result.data,
          nextPageUrl: result.nextPageUrl,
          staffId: event.staffId,
          month: event.month,
          year: event.year,
        ),
      );
    } catch (e, stack) {
      log('Error loading sales data: $e', stackTrace: stack);
      emit(_Error(e.toString()));
    }
  }

  FutureOr<void> _onLoadNextPageSales(
    _LoadNextPageSales event,
    Emitter<StaffAnalyticsSalesState> emit,
  ) async {
    if (state is! _Loaded) return;
    final s = state as _Loaded;
    if (s.nextPageUrl == null || s.isPaginating) return;

    emit(s.copyWith(isPaginating: true));
    try {
      final nextPage = PaginationModel.getPageFromUrl(s.nextPageUrl);
      final result = await _repository.getStaffMonthlySalesPagination(
        page: nextPage,
        staffId: s.staffId,
        month: s.month,
        year: s.year,
      );
      emit(
        s.copyWith(
          sales: [...s.sales, ...result.data],
          nextPageUrl: result.nextPageUrl,
          isPaginating: false,
        ),
      );
    } catch (e, stack) {
      log('Error loading next page of sales: $e', stackTrace: stack);
      emit(_Error(e.toString()));
    }
  }
}
