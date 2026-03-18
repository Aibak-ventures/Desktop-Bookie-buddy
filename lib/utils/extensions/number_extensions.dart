import 'package:bookie_buddy_web/utils/extensions/context_extensions.dart';
import 'package:bookie_buddy_web/core/app/my_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

extension NumX on num {
  /// Formats the number as a currency string in Indian Rupees with the symbol
  /// "₹".
  ///
  /// Example: 12345.toCurrency() => "₹12,345"
  String toCurrency({int decimalDigits = 0, bool symbol = true}) =>
      NumberFormat.currency(
        locale: 'en_IN',
        symbol: symbol ? '₹' : '',
        decimalDigits: decimalDigits,
      ).format(this);

  /// Returns a [Widget] that represents a vertical space of the specified height.
  Widget get height =>
      SizedBox(height: h); // h is from ScreenUtil  (this.h == h)

  /// Returns a [Widget] that represents a horizontal space of the specified width.
  Widget get width => SizedBox(width: w); // w is from ScreenUtil (this.w == w)

  /// Returns a [Widget] that represents a vertical space of the specified height relative to the screen height.
  Widget get heightCustom =>
      SizedBox(height: navigatorKey.currentContext!.screenHeight * toDouble());

  /// Returns double value relative to screen width
  double get widthR => navigatorKey.currentContext!.mediaQueryWidth(toDouble());

  /// Returns double value relative to screen height
  double get heightR =>
      navigatorKey.currentContext!.mediaQueryHeight(toDouble());

  /// Returns a [BorderRadius] with the specified corner radius.
  BorderRadius get radiusBorder => BorderRadius.circular(toDouble());

  /// Returns a [Radius] with the specified corner radius.
  Radius get radius => Radius.circular(toDouble());

  double percentageOf(num total) {
    if (total == 0) return 0;
    return ((this / total) * 100).roundToDouble();
  }
}

extension IntX on int {
  Duration days() {
    //* use const  on common values to increase performance
    if (this == 1) return const Duration(days: 1);
    return Duration(days: this);
  }

  Duration hours() => Duration(hours: this);

  Duration minutes() => Duration(minutes: this);

  Duration seconds() => Duration(seconds: this);

  Duration milliSeconds() => Duration(milliseconds: this);
}

extension NumPadding on num {
  /// Returns a [Widget] that represents a padding with the specified value for all sides.
  EdgeInsets get padding => EdgeInsets.all(w);

  /// Returns a [Widget] that represents a horizontal padding with the specified value for horizontal sides.
  EdgeInsetsGeometry get paddingHorizontal =>
      EdgeInsets.symmetric(horizontal: w);

  /// Returns a [Widget] that represents a vertical padding with the specified value for vertical sides.
  EdgeInsetsGeometry get paddingVertical => EdgeInsets.symmetric(vertical: w);

  /// Returns a [Widget] that represents a padding with the specified value for each side.
  EdgeInsetsGeometry paddingOnly({
    bool left = false,
    bool right = false,
    bool top = false,
    bool bottom = false,
  }) =>
      EdgeInsets.only(
        left: left ? w : 0,
        right: right ? w : 0,
        top: top ? w : 0,
        bottom: bottom ? w : 0,
      );
}

extension RecordX on (num, num) {
  /// First value is horizontal, second is vertical
  ///
  ///Example:
  ///```
  /// (20, 10).padding => EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.w)
  /// ```
  EdgeInsetsGeometry get padding =>
      EdgeInsets.symmetric(horizontal: this.$1.w, vertical: this.$2.w);
}

extension NumXNullable on num? {
  bool get isNullOrZero => this == null || this == 0;

  bool get isNotNullOrZero => !isNullOrZero;
}
