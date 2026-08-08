import 'dart:typed_data';

import 'package:bookie_buddy_web/features/printer/domain/entities/print_ticket_entity/print_ticket_entity.dart';

/// A helper class for building a [PrintTicketEntity] programmatically —
/// same shape as the mobile app's `PrintTicketBuilder`: a stateful
/// accumulator with imperative methods and one final [build] to retrieve
/// the result.
///
/// This is the low-level layer: it only knows about raw printer operations
/// (an image, a feed, a cut). `ReceiptCanvas` (presentation layer) is the
/// higher-level layer built on top of this one — it turns human-friendly
/// design commands (`.text()`, `.row()`, `.divider()`, ...) into rendered
/// images, then calls [image] here.
///
/// Typical usage:
/// ```dart
/// final builder = PrintTicketBuilder();
/// builder.image(headerRgba, width: headerWidth, height: headerHeight);
/// builder.image(bodyRgba, width: bodyWidth, height: bodyHeight);
/// builder.feed(2);
/// builder.cut();
///
/// final ticket = builder.build();
/// ```
class PrintTicketBuilder {
  PrintTicketBuilder({this.paperSize = PrinterPaperSize.mm80});

  /// Must match the width whatever renders [image]'s bytes actually used —
  /// see [PrintTicketEntity.paperSize] doc for why this matters.
  final PrinterPaperSize paperSize;

  final List<PrintTicketCommand> _commands = [];

  /// Adds one pre-rendered, already-monochrome raw RGBA section to the
  /// ticket.
  void image(Uint8List rgba, {required int width, required int height}) {
    _commands.add(
      PrintTicketImageCommand(rgba: rgba, width: width, height: height),
    );
  }

  void feed([int lines = 1]) {
    _commands.add(PrintTicketFeedCommand(lines: lines));
  }

  void cut({int linesBefore = 4}) {
    _commands.add(PrintTicketCutCommand(linesBefore: linesBefore));
  }

  /// Clears all accumulated commands. Call this before starting a new
  /// build cycle if reusing the same builder instance.
  void reset() => _commands.clear();

  /// Returns the final accumulated ticket, ready to hand to
  /// `PrintReceiptUseCase`.
  PrintTicketEntity build() => PrintTicketEntity(
    commands: List.unmodifiable(_commands),
    paperSize: paperSize,
  );
}
