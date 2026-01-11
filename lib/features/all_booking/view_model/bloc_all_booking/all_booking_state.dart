part of 'all_booking_bloc.dart';

@freezed
class AllBookingState with _$AllBookingState {
  const factory AllBookingState.initial() = _Initial;
  const factory AllBookingState.loading() = _Loading;
  const factory AllBookingState.loaded({
    required List<DesktopBookingItemModel> bookings,
    String? nextPageUrl,
    @Default(false) bool isPaginating,
    String? startDate,
    String? endDate,
    String? searchQuery,
    String? status,
    StatusCountsModel? statusCounts,
  }) = _Loaded;
  const factory AllBookingState.error(String error) = _Error;
}
