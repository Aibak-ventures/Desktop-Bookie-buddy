part of 'booking_details_payment_history_cubit.dart';

@freezed
class BookingDetailsPaymentHistoryState
    with _$BookingDetailsPaymentHistoryState {
  const factory BookingDetailsPaymentHistoryState.collapsed() = _Collapsed;
  const factory BookingDetailsPaymentHistoryState.loading() = _Loading;
  const factory BookingDetailsPaymentHistoryState.error(String error) = _Error;
  const factory BookingDetailsPaymentHistoryState.expanded(
      List<BookingDetailsPaymentHistoryModel> paymentHistory) = _Expanded;
}
