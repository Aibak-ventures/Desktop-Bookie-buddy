import 'package:bookie_buddy_web/utils/phone_number_utils.dart';
import 'package:flutter/material.dart';
import 'package:phone_form_field/phone_form_field.dart';

/// Shared phone-field population logic used by both new-booking and
/// edit-booking flows.
///
/// All methods are pure static — no BLoC, no BuildContext.
class BookingPhonePopulator {
  /// Sets a single phone field pair ([phoneController] + [textController])
  /// from raw phone data.
  ///
  /// Normalises the number, caches its E.164 form, and syncs both
  /// controllers so the UI reflects the correct value and cursor position.
  static void setPhoneFieldValue(
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
}
