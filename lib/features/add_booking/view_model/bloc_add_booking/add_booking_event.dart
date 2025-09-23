part of 'add_booking_bloc.dart';

@freezed
class AddBookingEvent with _$AddBookingEvent {
  const factory AddBookingEvent.addNewBooking(AddBookingModel booking) =
      _AddNewBooking;
  const factory AddBookingEvent.updateBookingData(AddBookingModel booking) =
      _UpdateBookingData;
}
