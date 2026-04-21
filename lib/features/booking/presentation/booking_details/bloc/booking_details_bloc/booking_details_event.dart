part of 'booking_details_bloc.dart';

@freezed
abstract class BookingDetailsEvent with _$BookingDetailsEvent {
  const factory BookingDetailsEvent.fetchBookingDetails(int bookingId) =
      _FetchBookingDetails;

  const factory BookingDetailsEvent.updateDeliveryStatus({
    required int bookingId,
    required DeliveryStatus deliveryStatus,
  }) = _UpdateDeliveryStatus;

  const factory BookingDetailsEvent.updateBookingStatus({
    required int bookingId,
    required BookingStatus bookingStatus,
  }) = _UpdateBookingStatus;

  const factory BookingDetailsEvent.updatePayment({
    required int bookingId,
    required int amount,
    required int accountId,
  }) = _UpdatePayment;

  const factory BookingDetailsEvent.deletePayment({
    required int bookingId,
    required int paymentId,
  }) = _DeletePayment;

  const factory BookingDetailsEvent.cancelBooking({
    required int bookingId,
    int? refundAmount,
    int? accountId,
  }) = _CancelBooking;

  const factory BookingDetailsEvent.deleteBooking(int bookingId) =
      _DeleteBooking;
}
