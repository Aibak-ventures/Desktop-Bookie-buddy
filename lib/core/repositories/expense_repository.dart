import 'package:bookie_buddy_web/core/models/expense_model/expense_model.dart';
import 'package:bookie_buddy_web/core/models/pagination_model.dart';
import 'package:bookie_buddy_web/core/services/expense_service.dart';
import 'package:bookie_buddy_web/features/save_expense/models/expense_request_model/expense_request_model.dart';

class ExpenseRepository {
  final ExpenseService _service;

  ExpenseRepository(this._service);

  Future<PaginationModel<ExpenseModel>> getExpensePagination({
    required int page,
    int? clientId,
  }) async {
    try {
      return await _service.fetchExpensePagination(page: page);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addNewExpense({
    required ExpenseRequestModel expense,
  }) async {
    try {
      await _service.addExpense(
        expense: expense,
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateExpense({
    required ExpenseRequestModel updatedExpense,
  }) async {
    try {
      await _service.editExpense(
        updatedExpense: updatedExpense,
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteExpense({
    required int expenseId,
    required int? variantId,
  }) async {
    await _service.deleteExpense(
      expenseId: expenseId,
      variantId: variantId,
    );
  }
}
