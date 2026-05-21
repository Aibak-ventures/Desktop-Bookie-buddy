part of '../pages/new_booking_screen.dart';

extension BookingPhoneHelper on NewBookingScreenState {
  void _populateClientPhones({
    required String? phone1,
    String? phone1E164,
    String? phone2,
    String? phone2E164,
  }) {
    BookingPhonePopulator.setPhoneFieldValue(
      _clientPhone1FieldController,
      clientPhone1Controller,
      phoneNumber: phone1,
      e164: phone1E164,
    );
    BookingPhonePopulator.setPhoneFieldValue(
      _clientPhone2FieldController,
      clientPhone2Controller,
      phoneNumber: phone2,
      e164: phone2E164,
    );
  }
}
