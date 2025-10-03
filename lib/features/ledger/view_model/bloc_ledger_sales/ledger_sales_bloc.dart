import 'dart:async';
import 'dart:developer';

import 'package:bookie_buddy_web/core/models/pagination_model/pagination_model.dart';
import 'package:bookie_buddy_web/features/ledger/models/ledger_sales_grouped_model/ledger_sales_grouped_model.dart';
import 'package:bookie_buddy_web/features/ledger/repository/ledger_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'ledger_sales_event.dart';
part 'ledger_sales_state.dart';
part 'ledger_sales_bloc.freezed.dart';

class LedgerSalesBloc extends Bloc<LedgerSalesEvent, LedgerSalesState> {
  final LedgerRepository _repository;

  LedgerSalesBloc({required LedgerRepository repository})
    : _repository = repository,
      super(const _Loading()) {
    on<_LoadSales>(_onLoadSales);
    on<_LoadNextPageSales>(_onLoadNextPageSales);
  }

  FutureOr<void> _onLoadSales(
    _LoadSales event,
    Emitter<LedgerSalesState> emit,
  ) async {
    if (state is! _Loading) emit(const _Loading());
    try {
      final result = await _repository.getSalesPagination(
        clientId: event.clientId,
      );

      emit(
        _Loaded(
          ledgerSales: result.data,
          nextPageUrl: result.nextPageUrl,
          clientId: event.clientId,
          isFirstFetch: true,
        ),
      );
    } catch (e, stack) {
      log(e.toString(), stackTrace: stack);
      emit(_Error(e.toString()));
    }
  }

  Future<void> _onLoadNextPageSales(
    _LoadNextPageSales event,
    Emitter<LedgerSalesState> emit,
  ) async {
    if (state is! _Loaded) return;
    final s = state as _Loaded;
    if (s.isPaginating || s.nextPageUrl == null) return;

    emit(s.copyWith(isPaginating: true, isFirstFetch: false));

    try {
      final nextPage = PaginationModel.getPageFromUrl(s.nextPageUrl);
      final result = await _repository.getSalesPagination(
        page: nextPage,
        clientId: s.clientId,
      );

      emit(
        s.copyWith(
          ledgerSales: [...s.ledgerSales, ...result.data],
          nextPageUrl: result.nextPageUrl,
          isPaginating: false,
          clientId: s.clientId,
          isFirstFetch: false,
        ),
      );
    } catch (e, stack) {
      log(e.toString(), stackTrace: stack);
      emit(_Error(e.toString()));
    }
  }

  _Loaded get getLoadedState => state as _Loaded;
}
