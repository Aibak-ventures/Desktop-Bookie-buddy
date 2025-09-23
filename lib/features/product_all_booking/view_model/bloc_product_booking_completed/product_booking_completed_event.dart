part of 'product_booking_completed_bloc.dart';

@freezed
class ProductBookingCompletedEvent with _$ProductBookingCompletedEvent {
  const factory ProductBookingCompletedEvent.loadBookings(
    int productId,
  ) = _LoadBookings;
  const factory ProductBookingCompletedEvent.loadNextBooking(
    int productId,
  ) = _LoadNextBookings;
}
