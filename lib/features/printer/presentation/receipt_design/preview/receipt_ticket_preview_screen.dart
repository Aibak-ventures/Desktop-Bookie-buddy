import 'dart:async';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

import 'package:bookie_buddy_core/features/thermal_printer/domain/entities/print_ticket_entity/print_ticket_entity.dart';

/// Decodes each [PrintTicketImageCommand]'s raw RGBA bytes straight from
/// the built [PrintTicketEntity] and renders them stacked on a paper-width canvas.
///
/// Deliberately reads the *already-monochrome, already-thresholded* pixels
/// the printer itself would receive, not the pre-threshold widget tree —
/// so this also catches threshold artifacts (a thin dashed line vanishing,
/// a logo going full black/white) that a "live" widget preview wouldn't
/// show. Never wire this behind a real print action; it's for checking a
/// design change without burning paper while iterating.
class ReceiptTicketPreviewScreen extends StatelessWidget {
  const ReceiptTicketPreviewScreen({super.key, required this.ticket});

  final PrintTicketEntity ticket;

  @override
  Widget build(BuildContext context) {
    final images = ticket.commands.whereType<PrintTicketImageCommand>();
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        title: const Text('Receipt Preview'),
        backgroundColor: Colors.white,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 24),
          child: Container(
            width: ticket.paperSize.widthPixels.toDouble(),
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [for (final image in images) _RasterSection(image)],
            ),
          ),
        ),
      ),
    );
  }
}

/// One rasterized section — matches exactly what [flushSection] handed the
/// ticket builder, so the seams between sections (header vs. body, an
/// items-list split) are visible here too.
class _RasterSection extends StatelessWidget {
  const _RasterSection(this.command);

  final PrintTicketImageCommand command;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ui.Image>(
      future: _decode(command),
      builder: (context, snapshot) {
        final image = snapshot.data;
        if (image == null) {
          return SizedBox(
            height: command.height.toDouble(),
            child: const Center(
              child: Padding(
                padding: EdgeInsets.all(12),
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            ),
          );
        }
        return RawImage(image: image, fit: BoxFit.fitWidth);
      },
    );
  }

  Future<ui.Image> _decode(PrintTicketImageCommand command) {
    final completer = Completer<ui.Image>();
    ui.decodeImageFromPixels(
      command.rgba,
      command.width,
      command.height,
      ui.PixelFormat.rgba8888,
      completer.complete,
    );
    return completer.future;
  }
}
