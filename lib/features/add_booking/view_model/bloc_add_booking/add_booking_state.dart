part of 'add_booking_bloc.dart';

@freezed
class AddBookingState with _$AddBookingState {
  const factory AddBookingState.initial({
    required RequestBookingModel booking,
  }) = _Initial;

  const factory AddBookingState.submitting() = _Submitting;

  const factory AddBookingState.success() = _Success;

  const factory AddBookingState.error(String error) = _Error;
}

extension AddBookingStateX on AddBookingState {
  bool get isInitial => this is _Initial;
  bool get isSubmitting => this is _Submitting;
  bool get isSuccess => this is _Success;
  bool get isError => this is _Error;

  RequestBookingModel get initialStateData => (this as _Initial).booking;
}
