part of 'product_reserve_days_cubit.dart';

enum ProductReserveDaysStatus {
  initial,
  saving,
  success,
  failure;

  bool get isSaving => this == saving;
  bool get isSuccess => this == success;
  bool get isFailure => this == failure;
}

@freezed
class ProductReserveDaysState with _$ProductReserveDaysState {
  const factory ProductReserveDaysState({
    required int selectedDays,
    required ProductReserveDaysStatus status,
    String? error,
    DateTime? lastSavedAt,
  }) = _ProductReserveDaysState;

  factory ProductReserveDaysState.initial(int initialDays) =>
      ProductReserveDaysState(
        selectedDays: initialDays,
        status: ProductReserveDaysStatus.initial,
      );
}
