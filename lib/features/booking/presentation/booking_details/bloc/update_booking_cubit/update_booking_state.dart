part of 'update_booking_cubit.dart';

@freezed
abstract class UpdateBookingState with _$UpdateBookingState {
  const factory UpdateBookingState.initial() = _Initial;

  const factory UpdateBookingState.submitting() = _Submitting;

  const factory UpdateBookingState.success() = _Success;

  const factory UpdateBookingState.failure(Map<String, dynamic> error) =
      _Failure;

  const factory UpdateBookingState.error(String error) = _Error;
}
