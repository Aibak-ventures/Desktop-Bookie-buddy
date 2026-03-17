import 'dart:developer';

import 'package:bookie_buddy_web/core/models/pagination_model/pagination_model.dart';
import 'package:bookie_buddy_web/features/ledger/domain/models/ledger_pendings_grouped_model/ledger_pendings_grouped_model.dart';
import 'package:bookie_buddy_web/features/ledger/domain/usecases/get_ledger_pending_paginated_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'wallet_pending_bloc.freezed.dart';
part 'wallet_pending_event.dart';
part 'wallet_pending_state.dart';

class WalletPendingBloc extends Bloc<WalletPendingEvent, WalletPendingState> {
  final GetLedgerPendingPaginatedUseCase _getPending;

  WalletPendingBloc({required GetLedgerPendingPaginatedUseCase getPending})
      : _getPending = getPending,
        super(const _Loading()) {
    on<_LoadPending>(_onLoadPending);
    on<_LoadNextPagePending>(_onLoadNextPagePending);
  }

  Future<void> _onLoadPending(
    _LoadPending event,
    Emitter<WalletPendingState> emit,
  ) async {
    if (state is! _Loading) emit(const _Loading());
    try {
      final result = await _getPending(page: 1, clientId: event.clientId);

      emit(
        _Loaded(
          walletPending: result.data,
          nextPageUrl: result.nextPageUrl,
          clientId: event.clientId,
          isFirstFetch: true,
        ),
      );
    } catch (e) {
      emit(_Error(e.toString()));
    }
  }

  Future<void> _onLoadNextPagePending(
    _LoadNextPagePending event,
    Emitter<WalletPendingState> emit,
  ) async {
    if (state is! _Loaded) return;
    final s = state as _Loaded;
    if (s.isPaginating || s.nextPageUrl == null) return;

    emit(s.copyWith(isPaginating: true, isFirstFetch: false));

    try {
      final nextPage = PaginationModel.getPageFromUrl(s.nextPageUrl);
      final result = await _getPending(page: nextPage, clientId: s.clientId);

      final grouped = [...s.walletPending, ...result.data];

      emit(
        s.copyWith(
          walletPending: grouped,
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

  // List<LedgerPendingsGroupedModel> _groupByDate(
  //   List<LedgerPendingModel> pendings, [
  //   List<LedgerPendingsGroupedModel>? lastData,
  // ]) {
  //   try {
  //     if (pendings.isEmpty) return lastData ?? [];
  //     final Map<String, List<LedgerPendingModel>> grouped = {};

  //     // Group by date
  //     for (final pending in pendings) {
  //       final date = pending.returnDate;
  //       grouped.putIfAbsent(date, () => []).add(pending);
  //     }

  //     // Prepare old data copy
  //     final oldGroups = lastData != null && lastData.isNotEmpty
  //         ? List<LedgerPendingsGroupedModel>.from(lastData)
  //         : <LedgerPendingsGroupedModel>[];

  //     // Check if last date in old matches first date in new
  //     final lastGroup = oldGroups.isNotEmpty ? oldGroups.removeLast() : null;
  //     final newFirstDate = grouped.keys.firstOrNull;

  //     if (lastGroup != null && lastGroup.date == newFirstDate) {
  //       grouped[newFirstDate]?.insertAll(0, lastGroup.pendings);
  //     } else if (lastGroup != null) {
  //       oldGroups.add(lastGroup);
  //     }

  //     // Convert map to list
  //     final newGroups = grouped.entries
  //         .map(
  //           (e) => LedgerPendingsGroupedModel(
  //             date: e.key,
  //             pendings: e.value,
  //           ),
  //         )
  //         .toList();

  //     // newGroups.sort((a, b) => b.date.compareTo(a.date)); // descending

  //     return [...oldGroups, ...newGroups];
  //   } catch (e, stack) {
  //     log(e.toString(), stackTrace: stack);
  //     rethrow;
  //   }
  // }
}
