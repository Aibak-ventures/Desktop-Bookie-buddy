part of 'booking_details_bloc.dart';

@freezed
class BookingDetailsState with _$BookingDetailsState {
  const factory BookingDetailsState.loading() = _Loading;
  const factory BookingDetailsState.loaded({
    required BookingDetailsModel booking,
  }) = _Loaded;

  const factory BookingDetailsState.success(
    String message, {
    @Default(false) bool didPop,
    @Default(true) bool needRefresh,
  }) = _Success;
  const factory BookingDetailsState.failed(String message) = _Failed;
  const factory BookingDetailsState.error(String error) = _Error;
}
