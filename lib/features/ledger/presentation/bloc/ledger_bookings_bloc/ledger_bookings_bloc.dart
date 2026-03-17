import 'dart:async';
import 'dart:developer';

import 'package:bookie_buddy_web/core/models/pagination_model/pagination_model.dart';
import 'package:bookie_buddy_web/features/ledger/domain/models/ledger_bookings_grouped_model/ledger_bookings_grouped_model.dart';
import 'package:bookie_buddy_web/features/ledger/domain/usecases/get_ledger_bookings_paginated_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'ledger_bookings_event.dart';
part 'ledger_bookings_state.dart';
part 'ledger_bookings_bloc.freezed.dart';

class LedgerBookingsBloc
    extends Bloc<LedgerBookingsEvent, LedgerBookingsState> {
  final GetLedgerBookingsPaginatedUseCase _getBookings;

  LedgerBookingsBloc(
      {required GetLedgerBookingsPaginatedUseCase getBookings})
      : _getBookings = getBookings,
        super(const _Loading()) {
    on<_LoadBookings>(_onLoadBookings);
    on<_LoadNextPageBookings>(_onLoadNextPageBookings);
  }

  Future<void> _onLoadBookings(
    _LoadBookings event,
    Emitter<LedgerBookingsState> emit,
  ) async {
    if (state is! _Loading) emit(const _Loading());

    try {
      final result = await _getBookings(clientId: event.clientId);

      emit(
        _Loaded(
          ledgerBookings: result.data,
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

  Future<void> _onLoadNextPageBookings(
    _LoadNextPageBookings event,
    Emitter<LedgerBookingsState> emit,
  ) async {
    if (state is! _Loaded) return;
    final s = state as _Loaded;
    if (s.isPaginating || s.nextPageUrl == null) return;

    emit(s.copyWith(isPaginating: true, isFirstFetch: false));

    try {
      final nextPage = PaginationModel.getPageFromUrl(s.nextPageUrl);
      final result = await _getBookings(page: nextPage, clientId: s.clientId);

      emit(
        s.copyWith(
          ledgerBookings: [...s.ledgerBookings, ...result.data],
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
