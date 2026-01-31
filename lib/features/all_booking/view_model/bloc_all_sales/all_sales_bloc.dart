import 'dart:async';
import 'dart:developer';

import 'package:bookie_buddy_web/core/models/pagination_model/pagination_model.dart';
import 'package:bookie_buddy_web/core/models/sale_model/sale_model.dart';
import 'package:bookie_buddy_web/core/repositories/sales_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'all_sales_bloc.freezed.dart';
part 'all_sales_event.dart';
part 'all_sales_state.dart';

class AllSalesBloc extends Bloc<AllSalesEvent, AllSalesState> {
  final SalesRepository _repository;

  AllSalesBloc({required SalesRepository repository})
      : _repository = repository,
        super(const AllSalesState.loading()) {
    on<_LoadSales>(_onFetchSales);
  }

  Future<void> _onFetchSales(
    _LoadSales event,
    Emitter<AllSalesState> emit,
  ) async {
    emit(const _Loading());

    try {
      final result = await _repository.getSalesPagination(
        page: event.page ?? 1,
        search: event.searchQuery,
      );

      emit(
        _Loaded(
          sales: result.data,
          nextPageUrl: result.nextPageUrl,
          searchQuery: event.searchQuery,
        ),
      );
    } catch (e, stack) {
      log('Error loading sales: $e', stackTrace: stack);
      emit(_Error(e.toString()));
    }
  }
}
