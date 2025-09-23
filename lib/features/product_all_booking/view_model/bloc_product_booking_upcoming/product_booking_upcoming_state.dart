part of 'product_booking_upcoming_bloc.dart';

@freezed
class ProductBookingUpcomingState with _$ProductBookingUpcomingState {
  const factory ProductBookingUpcomingState.loading() = _Loading;
  const factory ProductBookingUpcomingState.loaded({
    required List<BookingsModel> bookings,
    required String? nextPageUrl,
    @Default(false) bool isPaginating,
  }) = _Loaded;
  const factory ProductBookingUpcomingState.error(String error) = _Error;
}
