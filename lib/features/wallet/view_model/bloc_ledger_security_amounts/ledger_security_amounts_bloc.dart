import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:bookie_buddy_web/core/app_dependencies.dart';
import 'package:bookie_buddy_web/core/models/pagination_model.dart';
import 'package:bookie_buddy_web/features/wallet/models/ledger_security_amount_model/ledger_security_amount_model.dart';
import 'package:bookie_buddy_web/features/wallet/repository/ledger_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'ledger_security_amounts_event.dart';
part 'ledger_security_amounts_state.dart';
part 'ledger_security_amounts_bloc.freezed.dart';

class LedgerSecurityAmountsBloc
    extends Bloc<LedgerSecurityAmountsEvent, LedgerSecurityAmountsState> {
  final LedgerRepository _repository = getIt.get<LedgerRepository>();

  LedgerSecurityAmountsBloc() : super(const _Loading()) {
    on<_LoadSecurityAmounts>(_onLoadSecurityAmounts);
    on<_LoadNextPageSecurityAmounts>(_onLoadNextPageSecurityAmounts);
  }

  Future<void> _onLoadSecurityAmounts(_LoadSecurityAmounts event,
      Emitter<LedgerSecurityAmountsState> emit) async {
    emit(const _Loading());
    try {
      final result = await _repository.getSecurityAmountsPagination(
        page: 1,
        clientId: event.clientId,
      );

      emit(_Loaded(
        ledgerSecurityAmounts: result.data,
        nextPageUrl: result.nextPageUrl,
        clientId: event.clientId,
      ));
    } catch (e, stack) {
      log(e.toString(), stackTrace: stack);
      emit(_Error(e.toString()));
    }
  }

  Future<void> _onLoadNextPageSecurityAmounts(
      _LoadNextPageSecurityAmounts event,
      Emitter<LedgerSecurityAmountsState> emit) async {
    if (state is! _Loaded) return;
    final s = state as _Loaded;
    if (s.isPaginating || s.nextPageUrl == null) return;

    emit(
      s.copyWith(
        isPaginating: true,
      ),
    );

    try {
      final nextPage = PaginationModel.getPageFromUrl(s.nextPageUrl);
      final result = await _repository.getSecurityAmountsPagination(
        page: nextPage,
        clientId: s.clientId,
      );

      emit(
        s.copyWith(
          ledgerSecurityAmounts: [...s.ledgerSecurityAmounts, ...result.data],
          nextPageUrl: result.nextPageUrl,
          isPaginating: false,
          clientId: s.clientId,
        ),
      );
    } catch (e, stack) {
      log(e.toString(), stackTrace: stack);
      emit(_Error(e.toString()));
    }
  }
}
