part of 'booking_details_bloc.dart';

@freezed
abstract class BookingDetailsState with _$BookingDetailsState {
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

extension BookingDetailsStateX on BookingDetailsState {
  bool get isLoading => this is _Loading;
  bool get isSuccess => this is _Success;
  bool get isFailure => this is _Failed;
  bool get isError => this is _Error;

  BookingDetailsModel? get booking => maybeWhen(
        loaded: (booking) => booking,
        orElse: () => null,
      );
}
