part of 'edit_booking_cubit.dart';

@freezed
abstract class EditBookingState with _$EditBookingState {
  const factory EditBookingState.initial() = _Initial;
  const factory EditBookingState.loading() = _Loading;
  const factory EditBookingState.success({required bool isBooking}) = _Success;
  const factory EditBookingState.error({required String message}) = _Error;
}
