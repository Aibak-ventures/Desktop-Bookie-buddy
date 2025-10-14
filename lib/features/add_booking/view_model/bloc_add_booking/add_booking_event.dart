part of 'add_booking_bloc.dart';

@freezed
class AddBookingEvent with _$AddBookingEvent {
  const factory AddBookingEvent.addNewBooking(RequestBookingModel booking) =
      _AddNewBooking;
  const factory AddBookingEvent.updateBookingData(RequestBookingModel booking) =
      _UpdateBookingData;
}
