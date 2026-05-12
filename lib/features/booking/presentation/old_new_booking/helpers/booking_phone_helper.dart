part of '../pages/old_new_booking_screen.dart';

extension BookingPhoneHelper on OldNewBookingScreenState {
  void _setPhoneFieldValue(
    PhoneController phoneController,
    TextEditingController textController, {
    String? phoneNumber,
    String? e164,
  }) {
    final phone = phoneNumberFromData(phoneNumber: phoneNumber, e164: e164);
    phoneController.value =
        phone ?? PhoneNumber(isoCode: kDefaultPhoneIsoCode, nsn: '');
    final digits = normalizePhoneDigits(phone?.nsn ?? phoneNumber);
    cachePhoneE164(rawPhoneNumber: digits, e164: phoneNumberToE164(phone));
    textController.value = TextEditingValue(
      text: digits,
      selection: TextSelection.collapsed(offset: digits.length),
    );
  }

  void _populateClientPhones({
    required String? phone1,
    String? phone1E164,
    String? phone2,
    String? phone2E164,
  }) {
    _setPhoneFieldValue(
      _clientPhone1FieldController,
      clientPhone1Controller,
      phoneNumber: phone1,
      e164: phone1E164,
    );
    _setPhoneFieldValue(
      _clientPhone2FieldController,
      clientPhone2Controller,
      phoneNumber: phone2,
      e164: phone2E164,
    );
  }
}
