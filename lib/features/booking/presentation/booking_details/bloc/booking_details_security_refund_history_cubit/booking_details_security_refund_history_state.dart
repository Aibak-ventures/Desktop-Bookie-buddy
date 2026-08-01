part of 'booking_details_security_refund_history_cubit.dart';

@freezed
abstract class BookingDetailsSecurityRefundHistoryState
    with _$BookingDetailsSecurityRefundHistoryState {
  const factory BookingDetailsSecurityRefundHistoryState.collapsed() =
      _Collapsed;
  const factory BookingDetailsSecurityRefundHistoryState.loading() = _Loading;
  const factory BookingDetailsSecurityRefundHistoryState.error(String error) =
      _Error;
  const factory BookingDetailsSecurityRefundHistoryState.expanded(
    List<BookingSecurityRefundHistoryEntity> history,
  ) = _Expanded;
}
