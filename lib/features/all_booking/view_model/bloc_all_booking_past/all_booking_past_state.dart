part of 'all_booking_past_bloc.dart';

@freezed
class AllBookingPastState with _$AllBookingPastState {
  const factory AllBookingPastState.loading() = _Loading;
  const factory AllBookingPastState.loaded({
    required List<BookingsModel> bookings,
    String? nextPageUrl,
    @Default(false) bool isPaginating,
    String? startDate,
    String? endDate,
    String? searchQuery,
  }) = _Loaded;
  const factory AllBookingPastState.error(String error) = _Error;
}
