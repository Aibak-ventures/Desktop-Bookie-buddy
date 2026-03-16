part of 'product_booking_completed_bloc.dart';

@freezed
class ProductBookingCompletedState with _$ProductBookingCompletedState {
  const factory ProductBookingCompletedState.loading() = _Loading;
  const factory ProductBookingCompletedState.loaded({
    required List<BookingsModel> bookings,
    required String? nextPageUrl,
    @Default(false) bool isPaginating,
  }) = _Loaded;
  const factory ProductBookingCompletedState.error(String error) = _Error;
}
