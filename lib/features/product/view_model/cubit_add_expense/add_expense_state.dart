part of 'add_expense_cubit.dart';

@freezed
class AddExpenseState with _$AddExpenseState {
  const factory AddExpenseState.initial() = _Initial;
  const factory AddExpenseState.submitted() = _Submitted;
  const factory AddExpenseState.success(String message) = _Success;
  const factory AddExpenseState.error(String error) = _Error;
}
