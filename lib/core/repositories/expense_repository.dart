import 'dart:developer';

import 'package:bookie_buddy_web/core/models/pagination_model/pagination_model.dart';
import 'package:bookie_buddy_web/core/services/expense_service.dart';
import 'package:bookie_buddy_web/core/utils/safe_api_call.dart';
import 'package:bookie_buddy_web/features/ledger/models/ledger_expense_grouped_model/ledger_expense_grouped_model.dart';
import 'package:bookie_buddy_web/features/save_expense/models/expense_request_model/expense_request_model.dart';


class ExpenseRepository {
  final ExpenseService _service;

  ExpenseRepository(this._service);

  Future<PaginationModel<LedgerExpenseDailyModel>> getExpensePagination({
    required int page,
    int? clientId,
  }) async {
    try {
      final response = await safeApiCall(
        () => _service.fetchExpensePagination(page: page),
      );
      if (response.status.isSuccess) {
        return PaginationModel<LedgerExpenseDailyModel>.fromJson(
          response.data,
          (item) =>
              LedgerExpenseDailyModel.fromJson(item as Map<String, dynamic>),
          customJsonParser: (dataJson, itemFromJson) {
            final expenses = LedgerExpenseGroupedModel.fromCustomJson(
              dataJson as Map<String, dynamic>,
            );
            return expenses.dailyExpenses;
          },
        );
      }
      log('Get Expense Pagination Error: ${response.devMessage}');
      throw response.message;
    } catch (e, stack) {
      log('Get Expense Pagination Error: $e', stackTrace: stack);
      rethrow;
    }
  }

  Future<void> addNewExpense({
    required ExpenseRequestModel expense,
  }) async {
    try {
      final response = await safeApiCall(
        () => _service.addExpense(expense: expense),
      );
      if (response.status.isSuccess) return;
      log('Add Expense Error: ${response.devMessage}');
      throw response.message;
    } catch (e, stack) {
      log('Add Expense Error: $e', stackTrace: stack);
      rethrow;
    }
  }

  Future<void> updateExpense({
    required ExpenseRequestModel updatedExpense,
  }) async {
    try {
      final response = await safeApiCall(
        () => _service.editExpense(updatedExpense: updatedExpense),
      );
      if (response.status.isSuccess) return;
      log('Update Expense Error: ${response.devMessage}');
      throw response.message;
    } catch (e, stack) {
      log('Update Expense Error: $e', stackTrace: stack);
      rethrow;
    }
  }

  Future<void> deleteExpense({
    required int expenseId,
    required int? variantId,
  }) async {
    try {
      final response = await safeApiCall(
        () => _service.deleteExpense(
          expenseId: expenseId,
          variantId: variantId,
        ),
      );
      if (response.status.isSuccess) return;
      log('Delete Expense Error: ${response.devMessage}');
      throw response.message;
    } catch (e, stack) {
      log('Delete Expense Error: $e', stackTrace: stack);
      rethrow;
    }
  }
}
