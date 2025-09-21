import 'package:flutter/material.dart';

extension NumberExtensions on num {
  // Height extensions (using static methods to avoid conflicts)
  Widget get height => SizedBox(height: toDouble());
  
  // Width extensions  
  Widget get width => SizedBox(width: toDouble());
  
  // Responsive extensions (percentage based)
  double get widthR => (this * WidgetsBinding.instance.platformDispatcher.views.first.physicalSize.width / 100);
  double get heightR => (this * WidgetsBinding.instance.platformDispatcher.views.first.physicalSize.height / 100);
  
  // Padding extensions
  EdgeInsets get paddingAll => EdgeInsets.all(toDouble());
  EdgeInsets get paddingHorizontal => EdgeInsets.symmetric(horizontal: toDouble());
  EdgeInsets get paddingVertical => EdgeInsets.symmetric(vertical: toDouble());
  
  EdgeInsets get paddingTop => EdgeInsets.only(top: toDouble());
  EdgeInsets get paddingBottom => EdgeInsets.only(bottom: toDouble());
  EdgeInsets get paddingLeft => EdgeInsets.only(left: toDouble());
  EdgeInsets get paddingRight => EdgeInsets.only(right: toDouble());
  
  // Margin extensions (using Container for margins)
  EdgeInsets get marginAll => EdgeInsets.all(toDouble());
  EdgeInsets get marginHorizontal => EdgeInsets.symmetric(horizontal: toDouble());
  EdgeInsets get marginVertical => EdgeInsets.symmetric(vertical: toDouble());
  
  // Border radius extensions
  BorderRadius get radius => BorderRadius.circular(toDouble());
  Radius get circularRadius => Radius.circular(toDouble());
  
  // Duration extensions
  Duration get milliseconds => Duration(milliseconds: toInt());
  Duration get seconds => Duration(seconds: toInt());
  Duration get minutes => Duration(minutes: toInt());
}
