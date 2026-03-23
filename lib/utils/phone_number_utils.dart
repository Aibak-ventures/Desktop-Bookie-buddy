String? toPhone1E164(String? phoneNumber) {
  if (phoneNumber == null) return null;

  var digits = phoneNumber.replaceAll(RegExp(r'[^0-9]'), '');
  if (digits.isEmpty) return null;

  if (digits.length > 10) {
    if (digits.startsWith('91') && digits.length == 12) {
      digits = digits.substring(2);
    } else {
      digits = digits.substring(digits.length - 10);
    }
  }

  if (digits.isEmpty) return null;

  return '+91$digits';
}
