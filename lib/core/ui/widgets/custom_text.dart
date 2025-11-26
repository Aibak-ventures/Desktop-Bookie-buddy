import 'package:bookie_buddy_web/core/extensions/context_extensions.dart';
import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final double size;
  final String text;
  final Color color;
  final FontWeight? weight;
  final TextAlign? textAlign;
  final TextOverflow? textOverflow;
  final int? maxLines;
  const CustomText({
    required this.text,
    required this.size,
    required this.color,
    super.key,
    this.textOverflow,
    this.textAlign,
    this.weight,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) => Text(
        text,
        textAlign: textAlign,
        style: TextStyle(
          fontWeight: weight,
          overflow: textOverflow,
          color: color,
          fontSize: context.mediaQueryWidth(size),
        ),
        softWrap: true,
        maxLines: maxLines,
        overflow: textOverflow,
      );
}
