part of 'all_booking_bloc.dart';

@freezed
class AllBookingEvent with _$AllBookingEvent {
  const factory AllBookingEvent.loadBookings({
    String? startDate,
    String? endDate,
    String? searchQuery,
  }) = _LoadBookings;

  const factory AllBookingEvent.loadNextPageBookings({
    String? startDate,
    String? endDate,
    String? searchQuery,
  }) = _LoadNextPageBookings;

  /// Handles the update booking event by either refreshing the bookings list
  /// or updating a specific booking in the current state. If `shouldRefresh`
  /// is true, it triggers a full reload of bookings. If a specific booking
  /// is provided, it updates that booking in the list. Emits an updated
  /// state with the modified bookings list.
  const factory AllBookingEvent.updateBooking(
    BookingsModel? booking, {
    @Default(false) bool shouldRefresh,
  }) = _UpdateBooking;
}
