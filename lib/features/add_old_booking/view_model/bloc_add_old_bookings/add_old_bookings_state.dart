part of 'add_old_bookings_bloc.dart';

@freezed
class AddOldBookingsState with _$AddOldBookingsState {
  const factory AddOldBookingsState.initial() = _Initial;
  const factory AddOldBookingsState.submitting() = _Submitting;

  const factory AddOldBookingsState.success() = _Success;

  const factory AddOldBookingsState.failure(String message) = _Failure;
}
