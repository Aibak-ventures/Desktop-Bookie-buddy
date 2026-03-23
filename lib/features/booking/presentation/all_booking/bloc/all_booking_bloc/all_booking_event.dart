part of 'all_booking_bloc.dart';

@freezed
abstract class AllBookingEvent with _$AllBookingEvent {
  const factory AllBookingEvent.loadBookings({
    String? status,
    String? startDate,
    String? endDate,
    String? searchQuery,
  }) = _LoadBookings;

  const factory AllBookingEvent.loadNextPageBookings() = _LoadNextPageBookings;

  /// Handles the update booking event by either refreshing the bookings list
  /// or updating a specific booking in the current state. If `shouldRefresh`
  /// is true, it triggers a full reload of bookings. If a specific booking
  /// is provided, it updates that booking in the list. Emits an updated
  /// state with the modified bookings list.
  const factory AllBookingEvent.updateBooking(
    DesktopBookingItemModel? booking, {
    @Default(false) bool shouldRefresh,
    @Default(false) bool isDeleted,
  }) = _UpdateBooking;

  const factory AllBookingEvent.updateDeliveryStatus({
    required int bookingId,
    required DeliveryStatus deliveryStatus,
  }) = _UpdateDeliveryStatus;

  const factory AllBookingEvent.deleteBooking({
    required int bookingId,
  }) = _DeleteBooking;

  const factory AllBookingEvent.markAsCompleted({
    required int bookingId,
    required DeliveryStatus? currentStatus,
  }) = _MarkAsCompleted;
}
