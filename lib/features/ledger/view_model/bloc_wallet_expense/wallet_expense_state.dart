part of 'wallet_expense_bloc.dart';

@freezed
class WalletExpenseState with _$WalletExpenseState {
  const factory WalletExpenseState.loading() = _Loading;

  const factory WalletExpenseState.loaded({
    required List<LedgerExpenseDailyModel> expenseGroupedList,
    required String? nextPageUrl,
    @Default(false) bool isPaginating,
    int? clientId,
    @Default(false) bool isFirstFetch,
  }) = _Loaded;

  const factory WalletExpenseState.error(String error) = _Error;
  const factory WalletExpenseState.success(String message) = _Success;
  const factory WalletExpenseState.failure(String message) = _Failure;
}
