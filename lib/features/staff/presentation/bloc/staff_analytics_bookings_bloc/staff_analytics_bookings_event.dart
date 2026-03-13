part of 'staff_analytics_bookings_bloc.dart';

@freezed
class StaffAnalyticsBookingsEvent with _$StaffAnalyticsBookingsEvent {
  const factory StaffAnalyticsBookingsEvent.loadBookings({
    required int staffId,
    required int month,
    required int year,
  }) = _LoadBookings;

  const factory StaffAnalyticsBookingsEvent.loadNextPageBookings() =
      _LoadNextPageBookings;
}
