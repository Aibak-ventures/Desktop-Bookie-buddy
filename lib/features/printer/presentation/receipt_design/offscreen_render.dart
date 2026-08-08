import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

/// Renders [child] off-screen at exactly [width] logical pixels and
/// captures it as a [ui.Image] — no visible screen needed.
///
/// Technique: briefly insert a [RepaintBoundary]-wrapped copy of [child]
/// into the app's root [Overlay] positioned far outside the visible
/// viewport, wait a couple of frames so layout/paint (and any network
/// images inside [child]) settle, capture via
/// [RenderRepaintBoundary.toImage], then remove the overlay entry. This is
/// the standard "widget to image" pattern — it doesn't require [child] to
/// ever be visible to the user.
///
/// [pixelRatio] is deliberately left at 1.0 by default: the printer needs
/// an exact pixel width (e.g. 576 for 80mm), so upscaling here would just
/// inflate the image with no print-quality benefit — thermal print
/// resolution is fixed by the printer's own DPI, not by our capture ratio.
Future<ui.Image> renderWidgetOffscreen({
  required BuildContext context,
  required Widget child,
  required double width,
  double pixelRatio = 1.0,
}) async {
  final repaintKey = GlobalKey();
  late OverlayEntry entry;

  entry = OverlayEntry(
    builder: (context) => Positioned(
      left: -100000,
      top: 0,
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Material(
          color: Colors.white,
          child: RepaintBoundary(
            key: repaintKey,
            child: SizedBox(width: width, child: child),
          ),
        ),
      ),
    ),
  );

  Overlay.of(context, rootOverlay: true)..insert(entry);

  try {
    // Two frames: the first lays out/paints; the second gives any async
    // content inside `child` (e.g. a network logo image) a chance to have
    // resolved and triggered a repaint before we capture.
    await WidgetsBinding.instance.endOfFrame;
    await WidgetsBinding.instance.endOfFrame;

    final renderObject = repaintKey.currentContext!.findRenderObject();
    final boundary = renderObject! as RenderRepaintBoundary;
    return await boundary.toImage(pixelRatio: pixelRatio);
  } finally {
    entry.remove();
  }
}
