import 'dart:typed_data';

import 'package:collection/collection.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'print_ticket_entity.freezed.dart';

/// Paper size, width in dots — mirrors the mobile app's
/// `PrinterPaperSize` (`thermal_printer/domain/entities/print_ticket_entity`)
/// so receipt layout code can eventually be shared/ported unchanged.
enum PrinterPaperSize {
  mm58(value: 1, widthMM: 58, widthPixels: 384),
  mm72(value: 2, widthMM: 72, widthPixels: 512),
  mm80(value: 3, widthMM: 80, widthPixels: 576);

  final int value;
  final int widthMM;
  final int widthPixels;

  const PrinterPaperSize({
    required this.value,
    required this.widthMM,
    required this.widthPixels,
  });

  @override
  String toString() => '${widthMM}mm (${widthPixels}px)';
}

/// One printer operation — a plain Command-pattern value, not a domain
/// entity (no business identity). Hand-written sealed class rather than
/// @freezed for the same reason as mobile: small, iterates often with the
/// receipt design, and a native `switch` already gives exhaustiveness.
///
/// Domain never touches Flutter/rendering or `esc_pos_utils_plus` types —
/// [PrintTicketImageCommand] just carries already-rendered, already-
/// monochrome raw RGBA pixels, produced by the presentation-layer
/// `ReceiptCanvas` (mirrors mobile's `presentation/receipt_design/`). The
/// data layer (`QzPrinterRepositoryImpl`) is the only place that turns
/// this into actual ESC/POS bytes — keeps domain/presentation decoupled
/// from the specific printer-command library, same as mobile is decoupled
/// from `unified_esc_pos_printer`'s `Ticket` type.
sealed class PrintTicketCommand {
  const PrintTicketCommand();
}

/// One rasterized section of the receipt (header, everything else) — not
/// the whole receipt as a single image, so an async logo fetch stays
/// isolated from the rest. [rgba] is [width] × [height] pixels, 4 bytes
/// each (RGBA, already thresholded to pure black/white).
class PrintTicketImageCommand extends PrintTicketCommand {
  const PrintTicketImageCommand({
    required this.rgba,
    required this.width,
    required this.height,
  });

  final Uint8List rgba;
  final int width;
  final int height;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PrintTicketImageCommand &&
          other.width == width &&
          other.height == height &&
          const ListEquality<int>().equals(other.rgba, rgba));

  @override
  int get hashCode =>
      Object.hash(width, height, const ListEquality<int>().hash(rgba));
}

class PrintTicketFeedCommand extends PrintTicketCommand {
  const PrintTicketFeedCommand({this.lines = 1});

  final int lines;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PrintTicketFeedCommand && other.lines == lines);

  @override
  int get hashCode => lines.hashCode;
}

/// [linesBefore] feeds extra blank lines immediately before the physical
/// cut — most printers' cutter blade sits a few line-heights below the
/// print head, so cutting without enough clearance can slice through (or
/// above) the last printed line. Default of 4 mirrors mobile.
class PrintTicketCutCommand extends PrintTicketCommand {
  const PrintTicketCutCommand({this.linesBefore = 4});

  final int linesBefore;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PrintTicketCutCommand && other.linesBefore == linesBefore);

  @override
  int get hashCode => linesBefore.hashCode;
}

/// A fully built, ready-to-print ticket — an ordered list of commands with
/// no knowledge of what content they represent or which transport sends
/// them (here: always QZ Tray). Keeps its `Entity` suffix and stays
/// `@freezed`: it's "the print job" referenced across the repository and
/// usecases, and its shape is stable.
///
/// [paperSize] must match the width the commands' images were actually
/// rendered at — the repository builds the ESC/POS raster using this
/// value, so a mismatch means images sized for one paper width get printed
/// against bytes built for another.
@freezed
abstract class PrintTicketEntity with _$PrintTicketEntity {
  const factory PrintTicketEntity({
    required List<PrintTicketCommand> commands,
    @Default(PrinterPaperSize.mm80) PrinterPaperSize paperSize,
  }) = _PrintTicketEntity;
}
