import 'package:flutter/foundation.dart';

class AppInputValidators {
  static String? name(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Name is required';
    }

    final nameRegex =
        RegExp(r'^[A-Za-z\s]{3,}$'); // only letters & spaces, min 3 chars
    if (!nameRegex.hasMatch(value.trim())) {
      return 'Enter a valid name (letters only, min 3 chars)';
    }

    return null;
  }

  static String? productName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Product name is required';
    }

    // Allow letters, numbers, spaces, hyphens, slashes, commas, dots
    final nameRegex = RegExp(r'^[A-Za-z0-9\s\-,./]{3,}$');

    if (!nameRegex.hasMatch(value.trim())) {
      return 'Enter a valid product name (min 3 chars, no special symbols)';
    }

    return null;
  }

  static String? phoneNumber(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Phone number is required';
    }

    // Basic international or 10-digit Indian-style format
    final phoneRegex = RegExp(r'^(?:\+?\d{1,3})?[3-9]\d{9}$');

    if (!phoneRegex.hasMatch(value.trim())) {
      return 'Enter a valid phone number';
    }

    return null;
  }

  static String? numberOnly(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'This field is required';
    }

    final numberRegex = RegExp(r'^\d+$');
    if (!numberRegex.hasMatch(value.trim())) {
      return 'Enter a valid number';
    }

    return null;
  }

  static String? address(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Address is required';
    }

    // Min 5 non-whitespace characters
    if (value.trim().length < 3) {
      return 'Address must be at least 3 characters';
    }

    return null;
  }

  static String? description(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Description is required';
    }

    // Min 5 non-whitespace characters
    if (value.trim().length < 5) {
      return 'Description must be at least 5 characters';
    }

    return null;
  }

  static String? amount(
    String? value, {
    bool allowZero = false,
    bool allowDecimal = false,
    String fieldName = 'Amount',
    int? maxValue,
  }) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }

    value = value.trim();

    final amountRegex = allowDecimal
        ? RegExp(r'^\d+(\.\d{1,2})?$') // 123 or 123.45
        : RegExp(r'^\d+$'); //  Only integers like 100, 350

    if (!amountRegex.hasMatch(value)) {
      return allowDecimal
          ? 'Enter a valid amount (e.g., 100 or 300.25)'
          : 'Enter a valid whole number (e.g., 100 or 300)';
    }

    final amount = double.tryParse(value);
    if (amount == null) {
      return 'Invalid number format';
    }

    if (allowZero && amount < 0) {
      return '$fieldName must be greater than or equal to zero';
    } else if (!allowZero && amount <= 0) {
      return '$fieldName must be greater than zero';
    }

    if (maxValue != null && amount > maxValue) {
      return '$fieldName must be less than or equal to $maxValue';
    }

    if (value.replaceAll('.', '').length > 7) {
      // avoids counting dot in length
      return '$fieldName must be less than 7 digits';
    }

    return null;
  }

  static String? quantity(
    String? value, {
    int? maxValue,
    bool allowZero = false,
  }) {
    if (value == null || value.trim().isEmpty) {
      return 'Quantity is required';
    }

    final quantityRegex = RegExp(r'^\d+$'); // Only whole numbers allowed
    if (!quantityRegex.hasMatch(value.trim())) {
      return 'Enter a valid whole number';
    }

    if (!allowZero && int.parse(value) <= 0) {
      return 'Quantity can\'t be 0';
    } else if (allowZero && int.parse(value) < 0) {
      return 'Quantity can\'t be negative';
    }

    if (maxValue != null && int.parse(value) > maxValue) {
      return 'Max quantity is $maxValue';
    }

    if (value.length > 5) {
      // Example: max 99,999 quantity
      return 'Must be below 100,000';
    }

    return null;
  }

  static String? color(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Color is required';
    }

    // Allow only letters and spaces
    final colorRegex = RegExp(r'^[A-Za-z\s]{3,}$');

    if (!colorRegex.hasMatch(value.trim())) {
      return 'Enter a valid color name (min 3 letters)';
    }

    return null;
  }

  static String? model(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Model is required';
    }

    // Allow letters, numbers, hyphens, slashes, dots, spaces
    final modelRegex = RegExp(r'^[A-Za-z0-9\s\-/_.]{2,}$');

    if (!modelRegex.hasMatch(value.trim())) {
      return 'Enter a valid model (min 2 characters, no special symbols)';
    }

    return null;
  }

  static String? category(String? value, [String fieldName = 'Category']) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }

    // Allow only letters and spaces
    final categoryRegex = RegExp(r'^[A-Za-z\s]{3,}$');

    if (!categoryRegex.hasMatch(value.trim())) {
      return 'Enter a valid category (min 3 letters)';
    }

    return null;
  }

  static String? search(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter a search term';
    }

    // You can optionally restrict to certain characters
    final searchRegex = RegExp(r'^[a-zA-Z0-9\s]+$');
    if (!searchRegex.hasMatch(value.trim())) {
      return 'Search can only contain letters and numbers';
    }

    return null;
  }

  static String? password(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }

    const passLength = kDebugMode ? 3 : 4;

    // Accept any characters, but minimum length
    final passwordRegex = RegExp(r'^.{' + passLength.toString() + r',}$');

    if (!passwordRegex.hasMatch(value)) {
      return 'Password must be at least $passLength characters';
    }

    return null;
  }

  static String? basicText(
    String? value, {
    bool isRequired = true,
    int minLength = 1,
    String fieldName = 'This field',
  }) {
    if ((value == null || value.trim().isEmpty)) {
      return isRequired ? '$fieldName is required' : null;
    }

    // Only allow printable ASCII characters (no emojis or other unicode)
    final regex = RegExp(r'^[\x20-\x7E]{' + minLength.toString() + r',}$');

    if (!regex.hasMatch(value)) {
      return 'Emojis are not allowed and must be at least $minLength characters';
    }

    return null;
  }

  static String? onEmpty(String? value, String fieldName) {
    if (isEmpty(value)) {
      return '$fieldName is required';
    }
    return null;
  }

  static bool isEmpty(String? value) {
    return value == null || value.trim().isEmpty;
  }
}
