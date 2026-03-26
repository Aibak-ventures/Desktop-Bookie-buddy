import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppSizes {
  // ---------------------------------------------------------------------------
  // Font sizes — semantic names based on actual UI usage
  // ---------------------------------------------------------------------------

  /// Page-level greeting or hero text  (e.g. "Hello Owner!")
  static double get displayFontSize => 32.sp;

  /// Large stat/metric value in dashboard cards  (e.g. "128")
  static double get statFontSize => 28.sp;

  /// Screen title in app bar or top of page
  static double get pageTitleFontSize => 22.sp;

  /// Section heading, card title, dialog title  (e.g. "Recent Bookings")
  static double get sectionTitleFontSize => 20.sp;

  /// Form section label or sub-heading inside a card  (e.g. "Payment Method")
  static double get subheadingFontSize => 15.sp;

  /// Primary body text — item names, main content in lists/tables
  static double get bodyFontSize => 14.sp;

  /// Button label text
  static double get buttonFontSize => 14.sp;

  /// Secondary body text — paired labels, input field values, table rows
  static double get bodySecondaryFontSize => 13.sp;

  /// Input field placeholder and entered text
  static double get inputFontSize => 13.sp;

  /// Field labels above inputs, table column headers, chips/tags, small captions
  static double get labelFontSize => 12.sp;

  /// Timestamps, helper text, de-emphasized metadata
  static double get captionFontSize => 11.sp;

  // ---------------------------------------------------------------------------
  // Padding — semantic names based on actual web UI usage
  // ---------------------------------------------------------------------------

  /// Outermost screen/page padding — wraps the entire page content
  static const double screenPadding = 24.0;

  /// Padding inside a primary card or dashboard overview card
  static const double cardPadding = 20.0;

  /// Padding inside a section container, detail panel, or drawer block
  static const double sectionPadding = 16.0;

  /// Padding inside a form group, date section, or compact container
  static const double formPadding = 12.0;

  /// Padding for list/table rows — vertical tight, horizontal standard
  static const double rowPaddingVertical = 12.0;
  static const double rowPaddingHorizontal = 16.0;

  /// Tight inner padding for small elements (chips, badges, icon buttons)
  static const double innerPadding = 8.0;

  // ---------------------------------------------------------------------------
  // Spacing / Gaps — for SizedBox, Column/Row gap, between sections
  // ---------------------------------------------------------------------------

  /// Between major page sections (e.g. header → content, section → section)
  static const double spacingXL = 24.0;

  /// Between a section title and its content, or between cards
  static const double spacingL = 16.0;

  /// Between rows within a section or between form fields
  static const double spacingM = 12.0;

  /// Between inline elements — icon + text, label + value
  static const double spacingS = 8.0;

  /// Tight spacing — label above a field, stacked text lines
  static const double spacingXS = 4.0;

  // ---------------------------------------------------------------------------
  // Widget dimensions
  // ---------------------------------------------------------------------------

  static const double buttonHeight = 48.0;
  static const double appBarHeight = 56.0;
  static double get iconSize => 24.sp;
}
