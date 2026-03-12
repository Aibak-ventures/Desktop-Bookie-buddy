import 'dart:developer';

import 'package:bookie_buddy_web/core/models/pagination_model/pagination_model.dart';
import 'package:bookie_buddy_web/features/expense/domain/usecases/delete_expense_usecase.dart';
import 'package:bookie_buddy_web/features/ledger/models/ledger_expense_grouped_model/ledger_expense_grouped_model.dart';
import 'package:bookie_buddy_web/features/ledger/repository/ledger_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'wallet_expense_bloc.freezed.dart';
part 'wallet_expense_event.dart';
part 'wallet_expense_state.dart';

class WalletExpenseBloc extends Bloc<WalletExpenseEvent, WalletExpenseState> {
  final LedgerRepository _repository;
  final DeleteExpenseUsecase _deleteExpenseUsecase;
  WalletExpenseBloc(
      {required LedgerRepository repository,
      required DeleteExpenseUsecase deleteExpenseUsecase})
      : _repository = repository,
        _deleteExpenseUsecase = deleteExpenseUsecase,
        super(const _Loading()) {
    on<_LoadExpense>(_onLoadExpense);
    on<_LoadNextPageExpense>(_onLoadNextPageExpense);
    on<_DeleteExpense>(_onDeleteExpense);
  }

  Future<void> _onLoadExpense(
    _LoadExpense event,
    Emitter<WalletExpenseState> emit,
  ) async {
    if (state is! _Loading) emit(const _Loading());
    try {
      final result = await _repository.getExpensePagination(
        page: 1,
        clientId: event.clientId,
      );

      emit(
        _Loaded(
          expenseGroupedList: result.data,
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

  Future<void> _onLoadNextPageExpense(
    _LoadNextPageExpense event,
    Emitter<WalletExpenseState> emit,
  ) async {
    if (state is! _Loaded) return;
    final s = state as _Loaded;
    if (s.isPaginating || s.nextPageUrl == null) return;

    emit(s.copyWith(isPaginating: true, isFirstFetch: false));

    try {
      final nextPage = PaginationModel.getPageFromUrl(s.nextPageUrl);
      final result = await _repository.getExpensePagination(
        page: nextPage,
        clientId: s.clientId,
      );
      final grouped = [...s.expenseGroupedList, ...result.data];
      emit(
        s.copyWith(
          expenseGroupedList: grouped,
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

  Future<void> _onDeleteExpense(
    _DeleteExpense event,
    Emitter<WalletExpenseState> emit,
  ) async {
    // final s = state;
    try {
      await _deleteExpenseUsecase.call(
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

  // List<LedgerExpenseGroupedModel> _groupByDate(
  //   List<ExpenseModel> expenses, [
  //   List<LedgerExpenseGroupedModel>? lastData,
  // ]) {
  //   try {
  //     if (expenses.isEmpty) return lastData ?? [];
  //     final Map<String, List<ExpenseModel>> grouped = {};

  //     // Group by date
  //     for (final expense in expenses) {
  //       final date = expense.date.formatToUiDate();
  //       grouped.putIfAbsent(date, () => []).add(expense);
  //     }

  //     // Prepare old data copy
  //     final oldGroups = lastData != null && lastData.isNotEmpty
  //         ? List<LedgerExpenseGroupedModel>.from(lastData)
  //         : <LedgerExpenseGroupedModel>[];

  //     // Check if last date in old matches first date in new
  //     final lastGroup = oldGroups.isNotEmpty ? oldGroups.removeLast() : null;
  //     final newFirstDate = grouped.keys.firstOrNull;

  //     if (lastGroup != null && lastGroup.date == newFirstDate) {
  //       grouped[newFirstDate]?.insertAll(0, lastGroup.expenses);
  //     } else if (lastGroup != null) {
  //       oldGroups.add(lastGroup);
  //     }

  //     // Convert map to list
  //     final newGroups = grouped.entries
  //         .map(
  //           (e) => LedgerExpenseGroupedModel(
  //             date: e.key,
  //             expenses: e.value,
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

  // List<LedgerExpenseGroupedModel> _groupByDate(List<ExpenseModel> expenses) {
  //   final Map<String, List<ExpenseModel>> grouped = {};
  //   for (final expense in expenses) {
  //     final date = expense.date;

  //     if (grouped.containsKey(date)) {
  //       grouped[date]!.add(expense);
  //     } else {
  //       grouped[date] = [expense];
  //     }
  //   }
  //   final groupedList = grouped.entries
  //       .map(
  //         (e) => LedgerExpenseGroupedModel(
  //           date: e.key,
  //           expenses: e.value,
  //         ),
  //       )
  //       .toList();

  //   return groupedList;
  // }
}
