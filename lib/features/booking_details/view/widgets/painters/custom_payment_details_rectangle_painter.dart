import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class CustomPaymentDetailsRectanglePainter extends CustomPainter {
  // final Size buttonSize;
  final Size? Function() getSize;
  CustomPaymentDetailsRectanglePainter(this.getSize);

  @override
  void paint(Canvas canvas, Size size) {
    final h = size.height;
    final w = size.width;
    final radius = 10.0;
    final buttonSize = getSize();
    final bh = (buttonSize?.height ?? (h * 0.275)) + 8; // Adding 8 for padding
    final bw = (buttonSize?.width ?? (w * 0.45)) + 12; // Adding 12 for padding

    final path = Path()
      ..moveTo(0 + radius, 0)
      ..lineTo(w - radius, 0)
      ..arcToPoint(Offset(w, radius), radius: Radius.circular(radius))
      ..lineTo(w, h - bh - radius)
      ..arcToPoint(Offset(w - radius, h - bh), radius: Radius.circular(radius))
      ..lineTo(w - bw + radius, h - bh)
      ..quadraticBezierTo(w - bw, h - bh, w - bw, h - bh + radius)
      ..lineTo(w - bw, h - radius)
      ..arcToPoint(Offset(w - bw - radius, h), radius: Radius.circular(radius))
      ..lineTo(radius, h)
      ..arcToPoint(Offset(0, h - radius), radius: Radius.circular(radius))
      ..lineTo(0, radius)
      ..arcToPoint(Offset(radius, 0), radius: Radius.circular(radius))
      ..close();

    // Shadow Paint (soft like Container)
    final shadowPaint = Paint()
      ..color = AppColors.grey200
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8);

    // Fill Paint
    final fillPaint = Paint()
      ..color = AppColors.white
      ..style = PaintingStyle.fill;

    // Border Paint
    final borderPaint = Paint()
      ..color = AppColors.greyBorder
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    // Draw shadow behind
    canvas
      ..save()
      ..translate(0, 2) // Mimic Container's shadow offset
      ..drawPath(path, shadowPaint)
      ..restore()
      // Fill
      ..drawPath(path, fillPaint)
      // Border
      ..drawPath(path, borderPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
