import 'package:bookie_buddy_web/features/expense/domain/models/expense_request_model/expense_request_model.dart';
import 'package:bookie_buddy_web/features/expense/domain/repositories/i_expense_repository.dart';

class SaveExpenseUsecase {
  final IExpenseRepository _repository;
  SaveExpenseUsecase(this._repository);

  Future<void> call({
    required ExpenseRequestModel expense,
  }) async {
    expense.expenseId == null
        ? await _repository.addNewExpense(expense: expense)
        : await _repository.updateExpense(updatedExpense: expense);
  }
}
