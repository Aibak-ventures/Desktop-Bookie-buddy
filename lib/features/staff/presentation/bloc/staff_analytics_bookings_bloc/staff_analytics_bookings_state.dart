part of 'staff_analytics_bookings_bloc.dart';

@freezed
class StaffAnalyticsBookingsState with _$StaffAnalyticsBookingsState {
  const factory StaffAnalyticsBookingsState.loading() = _Loading;
  const factory StaffAnalyticsBookingsState.loaded({
    required List<BookingsModel> bookings,
    required String? nextPageUrl,
    @Default(false) bool isPaginating,
    required int staffId,
    required int month,
    required int year,
  }) = _Loaded;
  const factory StaffAnalyticsBookingsState.error(String message) = _Error;
}
