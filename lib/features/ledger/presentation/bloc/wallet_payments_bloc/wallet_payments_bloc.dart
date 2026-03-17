import 'dart:developer';

import 'package:bookie_buddy_web/core/models/pagination_model/pagination_model.dart';
import 'package:bookie_buddy_web/features/ledger/domain/models/ledger_payment_grouped_model/ledger_payment_grouped_model.dart';
import 'package:bookie_buddy_web/features/ledger/domain/usecases/get_ledger_payments_paginated_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'wallet_payments_bloc.freezed.dart';
part 'wallet_payments_event.dart';
part 'wallet_payments_state.dart';

class WalletPaymentsBloc
    extends Bloc<WalletPaymentsEvent, WalletPaymentsState> {
  final GetLedgerPaymentsPaginatedUseCase _getPayments;

  WalletPaymentsBloc({required GetLedgerPaymentsPaginatedUseCase getPayments})
      : _getPayments = getPayments,
        super(const _Loading()) {
    on<_LoadPayments>(_onLoadPayments);
    on<_LoadNextPagePayments>(_onLoadNextPagePayments);
  }

  Future<void> _onLoadPayments(
    _LoadPayments event,
    Emitter<WalletPaymentsState> emit,
  ) async {
    if (state is! _Loading) emit(const _Loading());
    try {
      final result = await _getPayments(clientId: event.clientId);

      emit(
        _Loaded(
          paymentHistory: result.data,
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

  Future<void> _onLoadNextPagePayments(
    _LoadNextPagePayments event,
    Emitter<WalletPaymentsState> emit,
  ) async {
    if (state is! _Loaded) return;
    final s = state as _Loaded;
    if (s.isPaginating || s.nextPageUrl == null) return;

    emit(s.copyWith(isPaginating: true, isFirstFetch: false));

    try {
      final nextPage = PaginationModel.getPageFromUrl(s.nextPageUrl);
      final result = await _getPayments(page: nextPage, clientId: s.clientId);

      emit(
        s.copyWith(
          paymentHistory: [...s.paymentHistory, ...result.data],
          nextPageUrl: result.nextPageUrl,
          isPaginating: false,
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
