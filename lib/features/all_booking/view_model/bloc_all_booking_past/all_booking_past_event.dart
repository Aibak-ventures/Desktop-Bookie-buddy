part of 'all_booking_past_bloc.dart';

@freezed
class AllBookingPastEvent with _$AllBookingPastEvent {
  const factory AllBookingPastEvent.loadBookings({
    String? startDate,
    String? endDate,
    String? searchQuery,
    @Default(true) bool shouldRefresh,
  }) = _LoadBookings;

  const factory AllBookingPastEvent.loadNextPageBookings() =
      _LoadNextPageBookings;

  /// Handles the update booking event by either refreshing the bookings list
  /// or updating a specific booking in the current state. If `shouldRefresh`
  /// is true, it triggers a full reload of bookings. If a specific booking
  /// is provided, it updates that booking in the list. Emits an updated
  /// state with the modified bookings list.
  const factory AllBookingPastEvent.updateBooking(
    BookingsModel? booking, {
    @Default(false) bool shouldRefresh,
    @Default(false) bool isDeleted,
  }) = _UpdateBooking;
}
