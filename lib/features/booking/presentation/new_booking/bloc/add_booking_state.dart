part of 'add_booking_cubit.dart';

@freezed
abstract class AddBookingState with _$AddBookingState {
  const factory AddBookingState.initial() = _Initial;
  const factory AddBookingState.loading() = _Loading;
  const factory AddBookingState.success({
    required int id,
    required BookingType type,
  }) = _Success;
  const factory AddBookingState.error({required String message}) = _Error;
}
