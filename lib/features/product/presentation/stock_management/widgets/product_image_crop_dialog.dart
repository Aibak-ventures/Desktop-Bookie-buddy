import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;

/// Full-screen crop dialog for product images (works on all platforms).
///
/// Pops with cropped [Uint8List] on confirm, or `null` on cancel.
class ImageCropDialog extends StatefulWidget {
  final Uint8List imageBytes;
  final img.Image image;

  const ImageCropDialog({
    super.key,
    required this.imageBytes,
    required this.image,
  });

  @override
  State<ImageCropDialog> createState() => _ImageCropDialogState();
}

class _ImageCropDialogState extends State<ImageCropDialog> {
  Rect? _cropRect;

  @override
  void initState() {
    super.initState();
    // Initialize with center square crop
    final size = widget.image.width < widget.image.height
        ? widget.image.width
        : widget.image.height;
    final left = (widget.image.width - size) / 2;
    final top = (widget.image.height - size) / 2;
    _cropRect = Rect.fromLTWH(left, top, size.toDouble(), size.toDouble());
  }

  void _cropAndReturn() async {
    if (_cropRect == null) return;

    final cropped = img.copyCrop(
      widget.image,
      x: _cropRect!.left.toInt(),
      y: _cropRect!.top.toInt(),
      width: _cropRect!.width.toInt(),
      height: _cropRect!.height.toInt(),
    );

    final jpegBytes = img.encodeJpg(cropped, quality: 90);
    Navigator.of(context).pop(Uint8List.fromList(jpegBytes));
  }

  void _onPanUpdate(DragUpdateDetails details, double displaySize) {
    if (_cropRect == null) return;

    setState(() {
      // Calculate scale to fit image in display
      final scaleX = displaySize / widget.image.width;
      final scaleY = displaySize / widget.image.height;
      final scale = scaleX < scaleY ? scaleX : scaleY;

      // Convert display delta to image coordinates
      final dx = details.delta.dx / scale;
      final dy = details.delta.dy / scale;

      // Calculate new position
      var newLeft = _cropRect!.left + dx;
      var newTop = _cropRect!.top + dy;

      // Keep crop rect within image bounds
      newLeft = newLeft.clamp(0.0, widget.image.width - _cropRect!.width);
      newTop = newTop.clamp(0.0, widget.image.height - _cropRect!.height);

      _cropRect = Rect.fromLTWH(
        newLeft,
        newTop,
        _cropRect!.width,
        _cropRect!.height,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final reservedHeight = 300.0;
    final availableHeight = screenSize.height * 0.8 - reservedHeight;
    final availableWidth = screenSize.width * 0.7;

    final maxDisplaySize =
        availableWidth < availableHeight ? availableWidth : availableHeight;
    final displaySize = maxDisplaySize < 300 ? 300.0 : maxDisplaySize;

    return Dialog(
      child: Container(
        constraints: BoxConstraints(
          maxWidth: displaySize + 100,
          maxHeight: screenSize.height * 0.85,
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Crop Image (1:1)',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.purple,
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(Icons.close),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Text(
                  'Drag the purple square to adjust the crop area.',
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
                const SizedBox(height: 16),

                // Image with crop overlay
                MouseRegion(
                  cursor: SystemMouseCursors.move,
                  child: GestureDetector(
                    onPanUpdate: (details) =>
                        _onPanUpdate(details, displaySize),
                    child: Container(
                      width: displaySize,
                      height: displaySize,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Stack(
                          children: [
                            Positioned.fill(
                              child: Image.memory(
                                widget.imageBytes,
                                fit: BoxFit.contain,
                              ),
                            ),
                            if (_cropRect != null)
                              CustomPaint(
                                size: Size(displaySize, displaySize),
                                painter: _CropOverlayPainter(
                                  cropRect: _cropRect!,
                                  imageSize: Size(
                                    widget.image.width.toDouble(),
                                    widget.image.height.toDouble(),
                                  ),
                                  displaySize: Size(displaySize, displaySize),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // Action buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('Cancel'),
                    ),
                    const SizedBox(width: 12),
                    ElevatedButton.icon(
                      onPressed: _cropAndReturn,
                      icon: const Icon(Icons.crop, size: 18),
                      label: const Text('Crop & Continue'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.purple,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _CropOverlayPainter extends CustomPainter {
  final Rect cropRect;
  final Size imageSize;
  final Size displaySize;

  _CropOverlayPainter({
    required this.cropRect,
    required this.imageSize,
    required this.displaySize,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Calculate scale to fit image in display
    final scaleX = displaySize.width / imageSize.width;
    final scaleY = displaySize.height / imageSize.height;
    final scale = scaleX < scaleY ? scaleX : scaleY;

    // Calculate scaled image position
    final scaledWidth = imageSize.width * scale;
    final scaledHeight = imageSize.height * scale;
    final offsetX = (displaySize.width - scaledWidth) / 2;
    final offsetY = (displaySize.height - scaledHeight) / 2;

    // Scale crop rect to display size
    final displayCropRect = Rect.fromLTWH(
      cropRect.left * scale + offsetX,
      cropRect.top * scale + offsetY,
      cropRect.width * scale,
      cropRect.height * scale,
    );

    // Draw dark overlay outside crop area
    final overlayPaint = Paint()
      ..color = Colors.black.withValues(alpha: 0.5)
      ..style = PaintingStyle.fill;

    // Top
    canvas.drawRect(
      Rect.fromLTWH(0, 0, displaySize.width, displayCropRect.top),
      overlayPaint,
    );
    // Bottom
    canvas.drawRect(
      Rect.fromLTWH(
        0,
        displayCropRect.bottom,
        displaySize.width,
        displaySize.height - displayCropRect.bottom,
      ),
      overlayPaint,
    );
    // Left
    canvas.drawRect(
      Rect.fromLTWH(
        0,
        displayCropRect.top,
        displayCropRect.left,
        displayCropRect.height,
      ),
      overlayPaint,
    );
    // Right
    canvas.drawRect(
      Rect.fromLTWH(
        displayCropRect.right,
        displayCropRect.top,
        displaySize.width - displayCropRect.right,
        displayCropRect.height,
      ),
      overlayPaint,
    );

    // Draw crop border
    final borderPaint = Paint()
      ..color = AppColors.purple
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;
    canvas.drawRect(displayCropRect, borderPaint);

    // Draw grid lines
    final gridPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.5)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    // Vertical lines
    canvas.drawLine(
      Offset(
        displayCropRect.left + displayCropRect.width / 3,
        displayCropRect.top,
      ),
      Offset(
        displayCropRect.left + displayCropRect.width / 3,
        displayCropRect.bottom,
      ),
      gridPaint,
    );
    canvas.drawLine(
      Offset(
        displayCropRect.left + displayCropRect.width * 2 / 3,
        displayCropRect.top,
      ),
      Offset(
        displayCropRect.left + displayCropRect.width * 2 / 3,
        displayCropRect.bottom,
      ),
      gridPaint,
    );

    // Horizontal lines
    canvas.drawLine(
      Offset(
        displayCropRect.left,
        displayCropRect.top + displayCropRect.height / 3,
      ),
      Offset(
        displayCropRect.right,
        displayCropRect.top + displayCropRect.height / 3,
      ),
      gridPaint,
    );
    canvas.drawLine(
      Offset(
        displayCropRect.left,
        displayCropRect.top + displayCropRect.height * 2 / 3,
      ),
      Offset(
        displayCropRect.right,
        displayCropRect.top + displayCropRect.height * 2 / 3,
      ),
      gridPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
