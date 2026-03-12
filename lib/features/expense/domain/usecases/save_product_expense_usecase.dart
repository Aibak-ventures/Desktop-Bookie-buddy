import 'package:bookie_buddy_web/features/expense/domain/models/expense_request_model/expense_request_model.dart';
import 'package:bookie_buddy_web/features/expense/domain/repositories/i_expense_repository.dart';

class SaveProductExpenseUsecase {
  final IExpenseRepository _repository;

  SaveProductExpenseUsecase(this._repository);

  Future<void> call({
    required ExpenseRequestModel expense,
  }) async {
    await _repository.saveProductExpense(expense: expense);
  }
}
