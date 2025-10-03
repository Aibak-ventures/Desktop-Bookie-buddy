part of 'save_sales_cubit.dart';

@freezed
class SaveSalesState with _$SaveSalesState {
  const factory SaveSalesState.initial() = _Initial;
  const factory SaveSalesState.saving() = _Saving;
  const factory SaveSalesState.success([String? message]) = _Success;
  const factory SaveSalesState.failure(String message) = _Failure;
}
