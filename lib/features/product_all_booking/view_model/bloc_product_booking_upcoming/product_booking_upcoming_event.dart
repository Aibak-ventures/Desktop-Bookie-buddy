part of 'product_booking_upcoming_bloc.dart';

@freezed
class ProductBookingUpcomingEvent with _$ProductBookingUpcomingEvent {
  const factory ProductBookingUpcomingEvent.loadBookings(
    int productId,
  ) = _LoadBookings;
  const factory ProductBookingUpcomingEvent.loadNextBooking(
    int productId,
  ) = _LoadNextBookings;
}
