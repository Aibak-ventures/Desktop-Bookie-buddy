import 'package:bookie_buddy_web/features/expense/domain/models/expense_request_model/expense_request_model.dart';

abstract interface class IExpenseRepository {
  Future<void> addNewExpense({
    required ExpenseRequestModel expense,
  });

  Future<void> updateExpense({
    required ExpenseRequestModel updatedExpense,
  });

  Future<void> saveProductExpense({
    required ExpenseRequestModel expense,
  });

  Future<void> deleteExpense({
    required int expenseId,
    required int? variantId,
  });
}
