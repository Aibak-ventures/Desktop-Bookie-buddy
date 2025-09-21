import 'package:flutter/material.dart';

extension WidgetExtensions on Widget {
  // Padding extensions
  Widget paddingAll(double padding) {
    return Padding(
      padding: EdgeInsets.all(padding),
      child: this,
    );
  }
  
  Widget paddingSymmetric({double vertical = 0, double horizontal = 0}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: vertical, horizontal: horizontal),
      child: this,
    );
  }
  
  Widget paddingOnly({
    double top = 0,
    double bottom = 0,
    double left = 0,
    double right = 0,
  }) {
    return Padding(
      padding: EdgeInsets.only(top: top, bottom: bottom, left: left, right: right),
      child: this,
    );
  }
  
  // Margin extensions (using Container)
  Widget marginAll(double margin) {
    return Container(
      margin: EdgeInsets.all(margin),
      child: this,
    );
  }
  
  Widget marginSymmetric({double vertical = 0, double horizontal = 0}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: vertical, horizontal: horizontal),
      child: this,
    );
  }
  
  Widget marginOnly({
    double top = 0,
    double bottom = 0,
    double left = 0,
    double right = 0,
  }) {
    return Container(
      margin: EdgeInsets.only(top: top, bottom: bottom, left: left, right: right),
      child: this,
    );
  }
  
  // Tap gesture
  Widget onTap(VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: this,
    );
  }
  
  // InkWell with ripple effect
  Widget onTapWithRipple(VoidCallback onTap, {BorderRadius? borderRadius}) {
    return InkWell(
      onTap: onTap,
      borderRadius: borderRadius,
      child: this,
    );
  }
  
  // Expanded widget
  Widget expanded({int flex = 1}) {
    return Expanded(
      flex: flex,
      child: this,
    );
  }
  
  // Flexible widget
  Widget flexible({int flex = 1, FlexFit fit = FlexFit.loose}) {
    return Flexible(
      flex: flex,
      fit: fit,
      child: this,
    );
  }
  
  // Center widget
  Widget get center => Center(child: this);
  
  // Align widget
  Widget align(Alignment alignment) {
    return Align(
      alignment: alignment,
      child: this,
    );
  }
  
  // Visibility
  Widget visible(bool isVisible) {
    return Visibility(
      visible: isVisible,
      child: this,
    );
  }
  
  // Opacity
  Widget opacity(double opacity) {
    return Opacity(
      opacity: opacity,
      child: this,
    );
  }
  
  // Positioned
  Widget positioned({
    double? top,
    double? bottom,
    double? left,
    double? right,
    double? width,
    double? height,
  }) {
    return Positioned(
      top: top,
      bottom: bottom,
      left: left,
      right: right,
      width: width,
      height: height,
      child: this,
    );
  }
  
  // Container with decoration
  Widget container({
    Color? color,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
    BoxDecoration? decoration,
    double? width,
    double? height,
  }) {
    return Container(
      width: width,
      height: height,
      padding: padding,
      margin: margin,
      decoration: decoration ?? (color != null ? BoxDecoration(color: color) : null),
      child: this,
    );
  }
  
  // ClipRRect
  Widget clipRRect({required BorderRadius borderRadius}) {
    return ClipRRect(
      borderRadius: borderRadius,
      child: this,
    );
  }
  
  // Card
  Widget card({
    Color? color,
    double? elevation,
    EdgeInsetsGeometry? margin,
    ShapeBorder? shape,
  }) {
    return Card(
      color: color,
      elevation: elevation,
      margin: margin,
      shape: shape,
      child: this,
    );
  }
}
