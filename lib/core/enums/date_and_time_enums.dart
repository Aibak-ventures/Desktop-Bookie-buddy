import 'package:bookie_buddy_web/core/extensions/string_extensions.dart';

enum Month {
  january,
  february,
  march,
  april,
  may,
  june,
  july,
  august,
  september,
  october,
  november,
  december;

  /// Get the corresponding integer representation of the month.
  int get number => index + 1;

  /// Get the display name of the month with the first letter capitalized.
  String get value => name.capitalizeFirstLetter();

  /// Get the short name of the month (first three letters).
  String get shortName => value.substring(0, 3);

  static String shortNameFromInt(int month) {
    if (month > 12) return december.shortName;
    if (month < 1) return january.shortName;
    return fromInt(month).shortName;
  }

  /// Convert integer to the corresponding Month enum value.
  static Month fromInt(int month) => Month.values[month - 1];
}
