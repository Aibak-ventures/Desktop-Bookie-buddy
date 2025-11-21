import 'package:flutter/material.dart';

extension WidgetX on Widget {
  Widget onTap(VoidCallback? onTap) =>
      GestureDetector(onTap: onTap, child: this);

  Widget onTapInkWell(
    VoidCallback? onTap, {
    BorderRadius? borderRadius,
    Color? splashColor,
    Color? highlightColor,
  }) =>
      InkWell(
        borderRadius: borderRadius,
        onTap: onTap,
        splashColor: splashColor ?? Colors.transparent,
        highlightColor: highlightColor ?? Colors.transparent,
        child: this,
      );

  Widget absorbPointer({bool absorbing = true}) =>
      AbsorbPointer(absorbing: absorbing, child: this);
}

extension PaddingX on Widget {
  Widget padding(EdgeInsetsGeometry padding) =>
      Padding(padding: padding, child: this);
}
