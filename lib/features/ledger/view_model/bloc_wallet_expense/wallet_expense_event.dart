part of 'wallet_expense_bloc.dart';

@freezed
class WalletExpenseEvent with _$WalletExpenseEvent {
  const factory WalletExpenseEvent.loadExpense({int? clientId}) = _LoadExpense;
  const factory WalletExpenseEvent.loadNextPageExpense() = _LoadNextPageExpense;
  const factory WalletExpenseEvent.deleteExpense({
    required int expenseId,
    required int? variantId,
  }) = _DeleteExpense;
}
