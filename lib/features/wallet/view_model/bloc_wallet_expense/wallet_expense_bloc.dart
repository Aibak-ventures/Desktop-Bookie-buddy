import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:bookie_buddy_web/core/app_dependencies.dart';
import 'package:bookie_buddy_web/core/models/expense_model/expense_model.dart';
import 'package:bookie_buddy_web/core/models/pagination_model.dart';
import 'package:bookie_buddy_web/core/repositories/expense_repository.dart';
import 'package:bookie_buddy_web/features/wallet/models/ledger_expense_grouped_model/ledger_expense_grouped_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'wallet_expense_bloc.freezed.dart';
part 'wallet_expense_event.dart';
part 'wallet_expense_state.dart';

class WalletExpenseBloc extends Bloc<WalletExpenseEvent, WalletExpenseState> {
  final ExpenseRepository _repository = getIt.get<ExpenseRepository>();
  WalletExpenseBloc() : super(const _Loading()) {
    on<_LoadExpense>(_onLoadExpense);
    on<_LoadNextPageExpense>(_onLoadNextPageExpense);
    on<_DeleteExpense>(_onDeleteExpense);
  }

  Future<void> _onLoadExpense(
      _LoadExpense event, Emitter<WalletExpenseState> emit) async {
    if (state is! _Loading) emit(const _Loading());
    try {
      final result = await _repository.getExpensePagination(
        page: 1,
        clientId: event.clientId,
      );

      emit(
        _Loaded(
          expenseGroupedList: _groupByDate(result.data),
          nextPageUrl: result.nextPageUrl,
          clientId: event.clientId,
        ),
      );

      log(result.data.toString());
    } catch (e, stack) {
      log(e.toString(), stackTrace: stack);
      emit(_Error(e.toString()));
    }
  }

  Future<void> _onLoadNextPageExpense(
      _LoadNextPageExpense event, Emitter<WalletExpenseState> emit) async {
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
      final result = await _repository.getExpensePagination(
        page: nextPage,
        clientId: s.clientId,
      );
      final grouped = _groupByDate(result.data);
      emit(
        s.copyWith(
          expenseGroupedList: [...s.expenseGroupedList, ...grouped],
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

  Future<void> _onDeleteExpense(
    _DeleteExpense event,
    Emitter<WalletExpenseState> emit,
  ) async {
    // final s = state;
    try {
      await _repository.deleteExpense(
        expenseId: event.expenseId,
        variantId: event.variantId,
      );
      // add(const _LoadExpense());
      emit(const _Success('Expense deleted successfully'));
    } catch (e, stack) {
      log(e.toString(), stackTrace: stack);
      emit(_Failure(e.toString()));
    }
  }

  List<LedgerExpenseGroupedModel> _groupByDate(List<ExpenseModel> expenses) {
    final Map<String, List<ExpenseModel>> grouped = {};
    for (final expense in expenses) {
      final date = expense.date;

      if (grouped.containsKey(date)) {
        grouped[date]!.add(expense);
      } else {
        grouped[date] = [expense];
      }
    }
    final groupedList = grouped.entries
        .map(
          (e) => LedgerExpenseGroupedModel(
            date: e.key,
            expenses: e.value,
          ),
        )
        .toList();

    return groupedList;
  }
}
