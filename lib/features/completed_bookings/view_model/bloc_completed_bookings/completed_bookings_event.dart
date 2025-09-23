part of 'completed_bookings_bloc.dart';

@freezed
class CompletedBookingsEvent with _$CompletedBookingsEvent {
  const factory CompletedBookingsEvent.loadCompletedBookings({
    String? startDate,
    String? endDate,
    String? searchQuery,
  }) = _LoadCompletedBookings;

  const factory CompletedBookingsEvent.loadNextPageCompletedBookings({
    String? startDate,
    String? endDate,
    String? searchQuery,
  }) = _LoadNextPageCompletedBookings;

  /// Handles the update booking event by either refreshing the bookings list
  /// or updating a specific booking in the current state. If `shouldRefresh`
  /// is true, it triggers a full reload of bookings. If a specific booking
  /// is provided, it updates that booking in the list. Emits an updated
  /// state with the modified bookings list.
  const factory CompletedBookingsEvent.updateBooking(
    BookingsModel? booking, {
    @Default(false) bool shouldRefresh,
  }) = _UpdateBooking;
}
