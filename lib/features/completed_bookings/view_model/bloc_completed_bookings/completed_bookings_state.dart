part of 'completed_bookings_bloc.dart';

@freezed
class CompletedBookingsState with _$CompletedBookingsState {
  const factory CompletedBookingsState.initial() = _Initial;

  const factory CompletedBookingsState.loading() = _Loading;

  const factory CompletedBookingsState.loaded({
    required List<BookingsModel> completedBookings,
    required String? nextPageUrl,
    @Default(false) bool isPaginating,
  }) = _Loaded;

  const factory CompletedBookingsState.error(String error) = _Error;
}
