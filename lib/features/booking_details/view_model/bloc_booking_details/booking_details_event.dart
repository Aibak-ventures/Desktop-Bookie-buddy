part of 'booking_details_bloc.dart';

@freezed
class BookingDetailsEvent with _$BookingDetailsEvent {
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
    required PaymentMethod paymentMethod,
  }) = _UpdatePayment;

  const factory BookingDetailsEvent.cancelBooking({
    required int bookingId,
    required int refundAmount,
    required PaymentMethod paymentMethod,
    required String refundReason,
  }) = _CancelBooking;

  const factory BookingDetailsEvent.deleteBooking(int bookingId) =
      _DeleteBooking;
}
