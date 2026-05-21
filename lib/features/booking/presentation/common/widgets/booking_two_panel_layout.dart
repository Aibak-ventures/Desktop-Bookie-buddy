import 'package:flutter/material.dart';

/// A two-column layout used by both the add-booking and edit-booking screens.
///
/// The left panel expands to fill available space (flex [leftFlex]).
/// The right panel has a fixed width ([rightWidth]).
class BookingTwoPanelLayout extends StatelessWidget {
  final Widget left;
  final Widget right;
  final int leftFlex;
  final double rightWidth;
  final double gap;

  const BookingTwoPanelLayout({
    super.key,
    required this.left,
    required this.right,
    this.leftFlex = 7,
    this.rightWidth = 340,
    this.gap = 16,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(flex: leftFlex, child: left),
        SizedBox(width: gap),
        SizedBox(width: rightWidth, child: right),
      ],
    );
  }
}
