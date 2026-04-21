import 'package:phone_form_field/phone_form_field.dart';

const IsoCode kDefaultPhoneIsoCode = IsoCode.IN;
final Map<String, String> _phoneE164Cache = {};

String normalizePhoneDigits(String? phoneNumber) {
  if (phoneNumber == null) return '';
  return phoneNumber.replaceAll(RegExp(r'[^0-9]'), '');
}

PhoneNumber? phoneNumberFromData({
  String? phoneNumber,
  String? e164,
  IsoCode defaultCountry = kDefaultPhoneIsoCode,
}) {
  final normalizedE164 = e164?.trim();
  if (normalizedE164 != null && normalizedE164.isNotEmpty) {
    return PhoneNumber.parse(normalizedE164);
  }

  final trimmedPhone = phoneNumber?.trim();
  if (trimmedPhone == null || trimmedPhone.isEmpty) return null;

  // If the raw input is already in E.164 format (starts with '+'),
  // parse it directly so the country code is preserved.
  if (trimmedPhone.startsWith('+')) {
    try {
      return PhoneNumber.parse(trimmedPhone);
    } catch (_) {
      // Fall through to default-country fallback below.
    }
  }

  final digits = normalizePhoneDigits(trimmedPhone);
  if (digits.isEmpty) return null;

  return PhoneNumber(isoCode: defaultCountry, nsn: digits);
}

String? phoneNumberToE164(PhoneNumber? phoneNumber) {
  final digits = normalizePhoneDigits(phoneNumber?.nsn);
  if (digits.isEmpty) return null;

  return phoneNumber?.international.replaceAll(RegExp(r'[^0-9+]'), '');
}

void cachePhoneE164({
  required String rawPhoneNumber,
  required String? e164,
}) {
  final digits = normalizePhoneDigits(rawPhoneNumber);
  final normalizedE164 = e164?.trim();
  if (digits.isEmpty || normalizedE164 == null || normalizedE164.isEmpty) {
    return;
  }
  _phoneE164Cache[digits] = normalizedE164;
}

String? toPhone1E164(
  String? phoneNumber, {
  String? fallbackE164,
  IsoCode defaultCountry = kDefaultPhoneIsoCode,
}) {
  final digits = normalizePhoneDigits(phoneNumber);
  final cachedE164 = digits.isNotEmpty ? _phoneE164Cache[digits] : null;
  final phone = phoneNumberFromData(
    phoneNumber: phoneNumber,
    e164: cachedE164 ?? fallbackE164,
    defaultCountry: defaultCountry,
  );

  return phoneNumberToE164(phone);
}

String extractPhoneFromE164(String? e164) {
  final phone = phoneNumberFromData(e164: e164);
  if (phone == null) return '';
  return normalizePhoneDigits(phone.nsn);
}
