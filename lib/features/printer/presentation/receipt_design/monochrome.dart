import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/foundation.dart' show compute;
import 'package:image/image.dart' as img;

/// Raw thresholded RGBA pixels for one rasterized receipt section, plus the
/// dimensions needed to reconstruct an [img.Image] from them.
///
/// Deliberately *not* PNG-encoded: the only consumer is
/// [ThermalPrinterRepositoryImpl], which immediately needs an [img.Image]
/// again to hand to the printer package's `imageRaster()` — encoding to PNG
/// just to decode it straight back was pure round-trip cost (compression +
/// decompression) for bytes that never leave the process.
class MonochromeBitmap {
  const MonochromeBitmap({
    required this.rgba,
    required this.width,
    required this.height,
  });

  final Uint8List rgba;
  final int width;
  final int height;
}

/// Converts a rendered [ui.Image] into pure black/white pixels.
///
/// Thermal printers are 1-bit — every pixel is either heated (black) or
/// not (white paper), no greyscale. Anything softer than pure black/white
/// behaves unpredictably once the printer itself thresholds it, so this
/// does the thresholding ourselves ahead of time using a plain luminance
/// cutoff (no dithering — this is solid text/rules, not photography,
/// where dithering would actually help).
///
/// The threshold loop is genuinely CPU-heavy (one Dart-level operation per
/// pixel, hundreds of thousands of pixels per receipt section) — running
/// that on the main isolate would jank the UI thread mid-print. [compute]
/// spawns a background isolate for that part; only [ui.Image.toByteData]
/// (a GPU→CPU readback) has to stay on the main isolate, since [ui.Image]
/// itself can't cross isolates — that step is comparatively fast,
/// native-backed engine code, not the bottleneck.
Future<MonochromeBitmap> toMonochromeBitmap(
  ui.Image image, {
  int threshold = 200,
}) async {
  final byteData = await image.toByteData();
  // `byteData.buffer` is the *entire* underlying ArrayBuffer the engine
  // allocated — not necessarily just this ByteData's own bytes (it may be
  // a view with a non-zero offset into a larger/pooled buffer, especially
  // under heavy concurrent allocation like right after a fresh app load).
  // Slicing to [offsetInBytes, lengthInBytes) is required to get exactly
  // the width*height*4 RGBA bytes this image claims to have — without it,
  // the pixel payload can silently mismatch the width/height baked into
  // the ESC/POS raster header downstream, which desyncs the printer's
  // parser and prints garbage until it's power-cycled.
  final rgba = Uint8List.fromList(
    byteData!.buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes),
  );

  final thresholded = await compute(
    _threshold,
    _MonochromeArgs(
      rgba: rgba,
      width: image.width,
      height: image.height,
      threshold: threshold,
    ),
  );

  return MonochromeBitmap(
    rgba: thresholded,
    width: image.width,
    height: image.height,
  );
}

class _MonochromeArgs {
  const _MonochromeArgs({
    required this.rgba,
    required this.width,
    required this.height,
    required this.threshold,
  });

  final Uint8List rgba;
  final int width;
  final int height;
  final int threshold;
}

/// Runs in a background isolate via [compute] — must be a top-level (or
/// static) function since isolate entry points can't close over state.
Uint8List _threshold(_MonochromeArgs args) {
  final decoded = img.Image.fromBytes(
    width: args.width,
    height: args.height,
    bytes: args.rgba.buffer,
    order: img.ChannelOrder.rgba,
    numChannels: 4,
  );

  for (final pixel in decoded) {
    final luminance = img.getLuminance(pixel);
    final value = luminance < args.threshold ? 0 : 255;
    pixel
      ..r = value
      ..g = value
      ..b = value;
  }

  return decoded.toUint8List();
}
