import 'package:bookie_buddy_web/core/extensions/string_extensions.dart';
import 'package:characters/characters.dart';
import 'package:flutter/foundation.dart';

class AppInputValidators {
  static String? name(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Name is required';
    }

    final nameRegex = RegExp(
      r'^[A-Za-z\s]{3,}$',
    ); // only letters & spaces, min 3 chars
    if (!nameRegex.hasMatch(value.trim())) {
      return 'Enter a valid name (letters only, min 3 chars)';
    }

    return null;
  }

  static String? productName(String? value) {
    if (value.isNullOrEmpty) {
      return 'Product name is required';
    }

    return basicText(value, fieldName: 'Product name', minLength: 3);
  }

static String? phoneNumber(String? value, {bool isRequired = true}) {
    // If not required and empty, return null
    if (!isRequired && (value == null || value.trim().isEmpty)) {
      return null;
    }

    if (value == null || value.trim().isEmpty) {
      return 'Phone number is required';
    }
    // Allow optional leading '+' and digits only, any length
    final phoneRegex = RegExp(r'^\+?\d+$');

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

  static String? address(String? value, {bool isRequired = true}) => basicText(
        value,
        fieldName: 'Place',
        minLength: 3,
        isRequired: isRequired,
      );

  static String? description(String? value) =>
      basicText(value, fieldName: 'Description', isRequired: false);

  static String? amount(
    String? value, {
    bool allowZero = false,
    bool allowDecimal = false,
    String fieldName = 'Amount',
    int? maxValue,
    bool isRequired = true,
  }) {
    // If not required and empty, return null
    if (!isRequired && (value == null || value.trim().isEmpty)) {
      return null;
    }

    // Required check
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
    bool allowDecimal = false,
  }) {
    if (value == null || value.trim().isEmpty) {
      return 'Quantity is required';
    }

    final trimmed = value.trim();

    // Allow integers or decimals (up to 2 places) based on allowDecimal
    final quantityRegex =
        allowDecimal ? RegExp(r'^\d+(\.\d{1,2})?$') : RegExp(r'^\d+$');

    if (!quantityRegex.hasMatch(trimmed)) {
      return allowDecimal
          ? 'Enter a valid number (e.g., 5 or 3.5)'
          : 'Enter a valid number';
    }

    final parsed = double.tryParse(trimmed);
    if (parsed == null) {
      return 'Invalid number format';
    }

    if (!allowZero && parsed <= 0) {
      return 'Quantity can\'t be 0 or less';
    } else if (allowZero && parsed < 0) {
      return 'Quantity can\'t be negative';
    }

    if (maxValue != null && parsed > maxValue) {
      return 'Max quantity is $maxValue';
    }

    // Enforce upper bound: must be below 100,000
    if (parsed >= 100000) {
      return 'Must be below 100,000';
    }

    return null;
  }

  static String? color(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Color is required';
    }

    // Allow letters, numbers, and spaces, min 3 chars
    final colorRegex = RegExp(r'^[A-Za-z0-9\s]{3,}$');

    if (!colorRegex.hasMatch(value.trim())) {
      return 'Enter a valid color (only letters or numbers, min 3 characters)';
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

  static String? category(
    String? value, {
    String fieldName = 'Category',
    bool isRequired = false,
  }) =>
      basicText(
        value,
        fieldName: fieldName,
        minLength: 3,
        isRequired: isRequired,
      );
  // if (value == null || value.trim().isEmpty) {
  //   return '$fieldName is required';
  // }

  // // Allow only letters and spaces
  // final categoryRegex = RegExp(r'^[A-Za-z\s]{3,}$');

  // if (!categoryRegex.hasMatch(value.trim())) {
  //   return 'Enter a valid category (min 3 letters)';
  // }

  // return null;

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
    final trimmed = value?.trim() ?? '';

    // Required check
    if (trimmed.isEmpty) {
      return isRequired ? '$fieldName is required' : null;
    }

    if (trimmed.characters.length < minLength &&
        trimmed.runes.length < minLength) {
      return '$fieldName must be at least $minLength characters';
    }

    // Emoji check
    if (_containsEmoji(trimmed)) {
      return 'Emojis are not allowed in ${fieldName.toLowerCase()}.';
    }

    return null;
  }

  // Detects most emojis, including multi-codepoint ones
  static bool _containsEmoji(String text) {
    for (final rune in text.runes) {
      if (_isEmojiRune(rune)) return true;
    }
    return false;
  }

  static bool _isEmojiRune(int rune) =>
      (rune >= 0x1F600 && rune <= 0x1F64F) || // Emoticons
      (rune >= 0x1F300 && rune <= 0x1F5FF) || // Symbols & pictographs
      (rune >= 0x1F680 && rune <= 0x1F6FF) || // Transport & map
      (rune >= 0x2600 && rune <= 0x26FF) || // Misc symbols
      (rune >= 0x2700 && rune <= 0x27BF) || // Dingbats
      (rune >= 0x1F1E6 && rune <= 0x1F1FF) || // Flags
      (rune >= 0x1F900 && rune <= 0x1F9FF) || // Supplemental pictographs
      (rune >= 0x1FA70 && rune <= 0x1FAFF) || // Extended pictographs
      rune == 0x200D || // Zero-width joiner (part of multi-emoji)
      rune == 0xFE0F; // Variation selector

  // Detects most emojis using a regular expression.
  // static bool _containsEmojiRegex(String text) {
  //   final emojiRegex = RegExp(
  //       r'[\u{1F600}-\u{1F64F}]|' // Emoticons
  //       r'[\u{1F300}-\u{1F5FF}]|' // Symbols & Pictographs
  //       r'[\u{1F680}-\u{1F6FF}]|' // Transport & Map Symbols
  //       r'[\u{2600}-\u{26FF}]|' // Miscellaneous Symbols
  //       r'[\u{2700}-\u{27BF}]|' // Dingbats
  //       r'[\u{1F1E6}-\u{1F1FF}]|' // Regional Indicator Symbols (Flags)
  //       r'[\u{1F900}-\u{1F9FF}]|' // Supplemental Symbols and Pictographs
  //       r'[\u{1FA70}-\u{1FAFF}]|' // Symbols and Pictographs Extended-A
  //       r'[\u{200D}]|' // Zero Width Joiner
  //       r'[\u{FE0F}]', // Variation Selector-16
  //       unicode: true);
  //   return emojiRegex.hasMatch(text);
  // }

  static String? onEmpty(String? value, String fieldName) {
    if (isEmpty(value)) {
      return '$fieldName is required';
    }
    return null;
  }

  static bool isEmpty(String? value) => value == null || value.trim().isEmpty;
}
