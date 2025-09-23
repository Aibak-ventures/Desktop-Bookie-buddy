part of 'add_old_bookings_bloc.dart';

@freezed
class AddOldBookingsEvent with _$AddOldBookingsEvent {
  const factory AddOldBookingsEvent.addBooking(AddBookingModel booking) =
      _AddBooking;
}
