import 'package:bookie_buddy_web/features/expense/domain/repositories/i_expense_repository.dart';

class DeleteExpenseUsecase {
  final IExpenseRepository _repository;

  DeleteExpenseUsecase(this._repository);

  Future<void> call({
    required int expenseId,
    required int? variantId,
  }) async {
    await _repository.deleteExpense(
      expenseId: expenseId,
      variantId: variantId,
    );
  }
}
