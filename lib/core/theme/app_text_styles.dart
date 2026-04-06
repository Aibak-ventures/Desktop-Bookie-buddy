import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:bookie_buddy_web/core/theme/app_sizes.dart';
import 'package:flutter/material.dart';

/// Centralized text styles for Bookie Buddy.
///
/// Use these in new code instead of raw [TextStyle] literals.
/// Variables are named by semantic role so the intent is clear at the call site:
///
/// ```dart
/// Text('Recent Bookings', style: AppTextStyles.sectionTitle)
/// Text('Sale date',        style: AppTextStyles.fieldLabel)
/// Text('John Doe',         style: AppTextStyles.bodyPrimary)
/// ```
///
/// Do NOT wire these into ThemeData.textTheme until a full audit pass is done —
/// adding them to ThemeData would silently affect all un-styled Text widgets in
/// existing screens.
class AppTextStyles {
  // ---------------------------------------------------------------------------
  // Display / Hero
  // ---------------------------------------------------------------------------

  /// Page-level greeting or hero text  — 32sp / w600
  /// e.g. "Hello, Owner!"
  static TextStyle get display => TextStyle(
    fontSize: AppSizes.displayFontSize,
    fontWeight: FontWeight.w600,
    color: AppColors.black,
  );

  /// Large metric/stat value shown in dashboard cards  — 28sp / bold
  /// e.g. "128" in a booking count card
  static TextStyle get statValue => TextStyle(
    fontSize: AppSizes.statFontSize,
    fontWeight: FontWeight.bold,
    color: AppColors.black,
  );

  // ---------------------------------------------------------------------------
  // Headings
  // ---------------------------------------------------------------------------

  /// Screen title shown in app bar or at the top of a page  — 22sp / w600
  static TextStyle get pageTitle => TextStyle(
    fontSize: AppSizes.pageTitleFontSize,
    fontWeight: FontWeight.w600,
    color: AppColors.black,
  );

  /// Section heading, card title, dialog title  — 20sp / w600
  /// e.g. "Recent Bookings", "Customer Details"
  static TextStyle get sectionTitle => TextStyle(
    fontSize: AppSizes.sectionTitleFontSize,
    fontWeight: FontWeight.w600,
    color: AppColors.black,
  );

  /// Sub-heading inside a form or card  — 15sp / w600
  /// e.g. "Payment Method", "Sale Date"
  static TextStyle get subheading => TextStyle(
    fontSize: AppSizes.subheadingFontSize,
    fontWeight: FontWeight.w600,
    color: AppColors.black,
  );

  // ---------------------------------------------------------------------------
  // Body
  // ---------------------------------------------------------------------------

  /// Primary body text — item names, main content in lists/tables  — 14sp / w600
  static TextStyle get bodyPrimary => TextStyle(
    fontSize: AppSizes.bodyFontSize,
    fontWeight: FontWeight.w600,
    color: AppColors.black,
  );

  /// Regular body text — descriptive content, detail values  — 14sp / w400
  static TextStyle get body => TextStyle(
    fontSize: AppSizes.bodyFontSize,
    fontWeight: FontWeight.w400,
    color: AppColors.black87,
  );

  /// Secondary body text — paired labels, table row values  — 13sp / w500
  static TextStyle get bodySecondary => TextStyle(
    fontSize: AppSizes.bodySecondaryFontSize,
    fontWeight: FontWeight.w500,
    color: AppColors.black87,
  );

  // ---------------------------------------------------------------------------
  // Buttons
  // ---------------------------------------------------------------------------

  /// Primary action button label  — 14sp / w600
  static TextStyle get buttonPrimary => TextStyle(
    fontSize: AppSizes.buttonFontSize,
    fontWeight: FontWeight.w600,
    color: AppColors.white,
  );

  /// Secondary / outlined button label  — 14sp / w500
  static TextStyle get buttonSecondary => TextStyle(
    fontSize: AppSizes.buttonFontSize,
    fontWeight: FontWeight.w500,
    color: AppColors.purple,
  );

  // ---------------------------------------------------------------------------
  // Form / Input
  // ---------------------------------------------------------------------------

  /// Label displayed above an input field  — 12sp / w600
  static TextStyle get fieldLabel => TextStyle(
    fontSize: AppSizes.labelFontSize,
    fontWeight: FontWeight.w600,
    color: AppColors.black,
  );

  /// Text inside an input field (entered value or placeholder)  — 13sp / w500
  static TextStyle get inputText => TextStyle(
    fontSize: AppSizes.inputFontSize,
    fontWeight: FontWeight.w500,
    color: AppColors.black87,
  );

  // ---------------------------------------------------------------------------
  // Tables
  // ---------------------------------------------------------------------------

  /// Table column header  — 12sp / w600
  static TextStyle get tableHeader => TextStyle(
    fontSize: AppSizes.labelFontSize,
    fontWeight: FontWeight.w600,
    color: AppColors.black,
  );

  /// Table data cell text  — 13sp / w500
  static TextStyle get tableData => TextStyle(
    fontSize: AppSizes.bodySecondaryFontSize,
    fontWeight: FontWeight.w500,
    color: AppColors.black87,
  );

  // ---------------------------------------------------------------------------
  // Labels, Chips, Captions
  // ---------------------------------------------------------------------------

  /// Small label — field meta, secondary attribute  — 12sp / w400
  static TextStyle get label => TextStyle(
    fontSize: AppSizes.labelFontSize,
    fontWeight: FontWeight.w400,
    color: AppColors.grey600,
  );

  /// Chip or badge text  — 12sp / w600
  static TextStyle get chip => TextStyle(
    fontSize: AppSizes.labelFontSize,
    fontWeight: FontWeight.w600,
    color: AppColors.black,
  );

  /// Timestamp, helper text, de-emphasized metadata  — 11sp / w400
  static TextStyle get caption => TextStyle(
    fontSize: AppSizes.captionFontSize,
    fontWeight: FontWeight.w400,
    color: AppColors.grey500,
  );
}
