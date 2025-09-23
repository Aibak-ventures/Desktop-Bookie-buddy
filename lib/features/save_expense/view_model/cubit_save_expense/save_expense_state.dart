part of 'save_expense_cubit.dart';

@freezed
class SaveExpenseState with _$SaveExpenseState {
  const factory SaveExpenseState.initial() = _Initial;
  const factory SaveExpenseState.submitted() = _Submitted;
  const factory SaveExpenseState.success(String message) = _Success;
  const factory SaveExpenseState.error(String error) = _Error;
}
