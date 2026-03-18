import 'package:bookie_buddy_web/utils/extensions/context_extensions.dart';
import 'package:flutter/material.dart';

class CustomSizedBoxHeight extends StatelessWidget {
  final double _height;

  const CustomSizedBoxHeight(this._height, {super.key});

  @override
  Widget build(BuildContext context) => SizedBox(
        height: context.screenHeight * _height,
      );
}

class CustomSizedBoxWidth extends StatelessWidget {
  final double width;

  const CustomSizedBoxWidth(this.width, {super.key});

  @override
  Widget build(BuildContext context) => SizedBox(
        width: context.getProportionateScreenWidth(width),
      );
}
