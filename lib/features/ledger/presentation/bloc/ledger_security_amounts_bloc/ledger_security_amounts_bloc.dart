import 'dart:developer';

import 'package:bookie_buddy_web/core/models/pagination_model/pagination_model.dart';
import 'package:bookie_buddy_web/features/ledger/domain/models/ledger_security_amount_grouped_model/ledger_security_amount_grouped_model.dart';
import 'package:bookie_buddy_web/features/ledger/domain/usecases/get_ledger_security_amounts_paginated_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'ledger_security_amounts_event.dart';
part 'ledger_security_amounts_state.dart';
part 'ledger_security_amounts_bloc.freezed.dart';

class LedgerSecurityAmountsBloc
    extends Bloc<LedgerSecurityAmountsEvent, LedgerSecurityAmountsState> {
  final GetLedgerSecurityAmountsPaginatedUseCase _getSecurityAmounts;

  LedgerSecurityAmountsBloc(
      {required GetLedgerSecurityAmountsPaginatedUseCase getSecurityAmounts})
      : _getSecurityAmounts = getSecurityAmounts,
        super(const _Loading()) {
    on<_LoadSecurityAmounts>(_onLoadSecurityAmounts);
    on<_LoadNextPageSecurityAmounts>(_onLoadNextPageSecurityAmounts);
  }

  Future<void> _onLoadSecurityAmounts(
    _LoadSecurityAmounts event,
    Emitter<LedgerSecurityAmountsState> emit,
  ) async {
    if (state is! _Loading) emit(const _Loading());
    try {
      final result = await _getSecurityAmounts(page: 1, clientId: event.clientId);

      emit(
        _Loaded(
          ledgerSecurityAmounts: result.data,
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

  Future<void> _onLoadNextPageSecurityAmounts(
    _LoadNextPageSecurityAmounts event,
    Emitter<LedgerSecurityAmountsState> emit,
  ) async {
    if (state is! _Loaded) return;
    final s = state as _Loaded;
    if (s.isPaginating || s.nextPageUrl == null) return;

    emit(s.copyWith(isPaginating: true, isFirstFetch: false));

    try {
      final nextPage = PaginationModel.getPageFromUrl(s.nextPageUrl);
      final result = await _getSecurityAmounts(page: nextPage, clientId: s.clientId);

      emit(
        s.copyWith(
          ledgerSecurityAmounts: [...s.ledgerSecurityAmounts, ...result.data],
          nextPageUrl: result.nextPageUrl,
          clientId: s.clientId,
          isPaginating: false,
          isFirstFetch: false,
        ),
      );
    } catch (e, stack) {
      log(e.toString(), stackTrace: stack);
      emit(_Error(e.toString()));
    }
  }
}
