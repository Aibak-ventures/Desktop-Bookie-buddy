import 'dart:developer';

import 'package:bookie_buddy_web/features/expense/data/datasources/expense_remote_datasources.dart';
import 'package:bookie_buddy_web/features/expense/domain/repositories/i_expense_repository.dart';
import 'package:bookie_buddy_web/utils/safe_api_call.dart';
import 'package:bookie_buddy_web/features/expense/domain/models/expense_request_model/expense_request_model.dart';

class ExpenseRepositoryImpl implements IExpenseRepository {
  final ExpenseRemoteDataSource _datasource;

  ExpenseRepositoryImpl(this._datasource);

  @override
  Future<void> addNewExpense({
    required ExpenseRequestModel expense,
  }) async {
    try {
      final response = await safeApiCall(
        () => _datasource.addExpense(expense: expense),
      );
      if (response.status.isSuccess) return;
      log('Add Expense Error: ${response.devMessage}');
      throw response.message ?? 'Failed to add expense';
    } catch (e, stack) {
      log('Add Expense Error: $e', stackTrace: stack);
      rethrow;
    }
  }

  @override
  Future<void> updateExpense({
    required ExpenseRequestModel updatedExpense,
  }) async {
    try {
      final response = await safeApiCall(
        () => _datasource.editExpense(updatedExpense: updatedExpense),
      );
      if (response.status.isSuccess) return;
      log('Update Expense Error: ${response.devMessage}');
      throw response.message ?? 'Failed to update expense';
    } catch (e, stack) {
      log('Update Expense Error: $e', stackTrace: stack);
      rethrow;
    }
  }

  @override
  Future<void> deleteExpense({
    required int expenseId,
    required int? variantId,
  }) async {
    try {
      final response = await safeApiCall(
        () => _datasource.deleteExpense(
          expenseId: expenseId,
          variantId: variantId,
        ),
      );
      if (response.status.isSuccess) return;
      log('Delete Expense Error: ${response.devMessage}');
      throw response.message ?? 'Failed to delete expense';
    } catch (e, stack) {
      log('Delete Expense Error: $e', stackTrace: stack);
      rethrow;
    }
  }

  // CREATE or UPDATE Expense
  @override
  Future<void> saveProductExpense({
    required ExpenseRequestModel expense,
  }) async {
    try {
      final response = await safeApiCall(
        () => _datasource.addOrUpdateProductExpense(expense: expense),
      );
      log('Save product expense response: ${response.toJson()}');
      if (response.status.isSuccess) {
        return;
      }
      log('Save product expense failed: ${response.devMessage}');
      throw response.message ?? 'Failed to complete operation';
    } catch (e, stack) {
      log('Error saving product expense: $e', stackTrace: stack);
      rethrow;
    }
  }
}
