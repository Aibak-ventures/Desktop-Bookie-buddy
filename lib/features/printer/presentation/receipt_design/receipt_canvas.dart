import 'package:bookie_buddy_web/features/printer/domain/entities/print_ticket_entity/print_ticket_entity.dart';
import 'package:bookie_buddy_web/features/printer/domain/print_ticket_builder.dart';
import 'package:bookie_buddy_web/features/printer/presentation/receipt_design/monochrome.dart';
import 'package:bookie_buddy_web/features/printer/presentation/receipt_design/offscreen_render.dart';
import 'package:flutter/material.dart';

/// One column inside a [ReceiptCanvas.row] — e.g. an item name, a qty, an
/// amount.
class ReceiptColumn {
  const ReceiptColumn(
    this.text, {
    this.flex = 1,
    this.align = TextAlign.left,
    this.bold = false,
  });

  final String text;
  final int flex;
  final TextAlign align;
  final bool bold;
}

/// High-level "design a receipt" wrapper — the receipt equivalent of
/// `ThreeColumnLabelPrintProgram` sitting on top of `ZPLCommandBuilder`.
///
/// Call the design commands below (`.text()`, `.row()`, `.divider()`,
/// `.numberedList()`, `.image()`) to accumulate content, call
/// `.flushSection()` at each logical section boundary (header, items,
/// totals, ...) so each becomes its own small rasterized image — mirrors
/// how the underlying printer package renders multi-script text
/// line-by-line rather than as one giant image — then call `.build()` to
/// get the finished [PrintTicketEntity].
///
/// This is the only place in the app that renders Flutter widgets purely
/// to turn them into printer bytes — nothing about *what* to print lives
/// here; that's up to whoever calls these commands (e.g.
/// `BookingReceiptCanvasBuilder`).
///
/// ```dart
/// final canvas = ReceiptCanvas(context: context);
/// canvas.text('LOVE BRIDAL', bold: true, center: true, size: 14);
/// canvas.divider();
/// await canvas.flushSection();
/// canvas.row([
///   ReceiptColumn('Item', flex: 3, bold: true),
///   ReceiptColumn('Amount', flex: 2, align: TextAlign.right, bold: true),
/// ]);
/// await canvas.flushSection();
/// await canvas.cut();
/// final ticket = canvas.build();
/// ```
class ReceiptCanvas {
  ReceiptCanvas({
    required this.context,
    this.paperSize = PrinterPaperSize.mm80,
  });

  final BuildContext context;

  /// Printable dot-width of the paper — 576 for 80mm at 203dpi.
  final PrinterPaperSize paperSize;

  late final PrintTicketBuilder _builder = PrintTicketBuilder(
    paperSize: paperSize,
  );
  final List<Widget> _pending = [];

  static const _mono = 'monospace';
  static const _ink = Colors.black;

  void text(
    String value, {
    bool bold = false,
    bool center = false,
    double size = 12.5,
    double topSpacing = 0,
    double bottomSpacing = 1,
  }) {
    _pending.add(
      Padding(
        padding: EdgeInsets.only(top: topSpacing, bottom: bottomSpacing),
        child: Text(
          value,
          textAlign: center ? TextAlign.center : TextAlign.left,
          style: TextStyle(
            fontFamily: _mono,
            fontSize: size,
            fontWeight: bold ? FontWeight.bold : FontWeight.normal,
            color: _ink,
            height: 1.3,
          ),
        ),
      ),
    );
  }

  void row(List<ReceiptColumn> columns, {bool bold = false, double size = 12}) {
    _pending.add(
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 1),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (final column in columns)
              Expanded(
                flex: column.flex,
                child: Text(
                  column.text,
                  textAlign: column.align,
                  style: TextStyle(
                    fontFamily: _mono,
                    fontSize: size,
                    fontWeight: (bold || column.bold)
                        ? FontWeight.bold
                        : FontWeight.normal,
                    color: _ink,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  /// [heavy] draws a solid double-weight rule (hard section break — items
  /// table header, totals); otherwise a dashed rule (soft break).
  void divider({bool heavy = false}) {
    _pending.add(
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: heavy
            ? Container(height: 1, color: _ink)
            : const CustomPaint(
                size: Size(double.infinity, 1),
                painter: _DashedLinePainter(),
              ),
      ),
    );
  }

  void spacer(double height) => _pending.add(SizedBox(height: height));

  void numberedList(List<String> items, {double size = 9.5}) {
    _pending.add(
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (var i = 0; i < items.length; i++)
            Padding(
              padding: const EdgeInsets.only(bottom: 3),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${i + 1}. ',
                    style: TextStyle(
                      fontFamily: _mono,
                      fontSize: size,
                      color: _ink,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      items[i],
                      style: TextStyle(
                        fontFamily: _mono,
                        fontSize: size,
                        color: _ink,
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  /// Inserts a widget you built yourself — an escape hatch for anything the
  /// commands above don't cover (e.g. a logo image already loaded into a
  /// widget).
  void widget(Widget child) => _pending.add(child);

  /// Rasterizes everything accumulated since the last flush into one image
  /// section and appends it to the ticket. Call this at each logical
  /// boundary that genuinely needs its own image (e.g. isolating the
  /// header's async logo fetch) — not after every design command. Each
  /// call pays for an offscreen render + a background isolate spawn for
  /// monochrome conversion, so fewer, larger flushes print faster,
  /// especially over Bluetooth.
  Future<void> flushSection() async {
    if (_pending.isEmpty) return;
    final children = List<Widget>.of(_pending);
    _pending.clear();

    final section = Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: children,
      ),
    );

    final uiImage = await renderWidgetOffscreen(
      context: context,
      width: paperSize.widthPixels.toDouble(),
      child: section,
    );
    final bitmap = await toMonochromeBitmap(uiImage);
    _builder.image(bitmap.rgba, width: bitmap.width, height: bitmap.height);
  }

  Future<void> feed([int lines = 1]) async {
    await flushSection();
    _builder.feed(lines);
  }

  Future<void> cut({int linesBefore = 4}) async {
    await flushSection();
    _builder.cut(linesBefore: linesBefore);
  }

  Future<PrintTicketEntity> build() async {
    await flushSection();
    return _builder.build();
  }
}

class _DashedLinePainter extends CustomPainter {
  const _DashedLinePainter();

  @override
  void paint(Canvas canvas, Size size) {
    const dashWidth = 4.0;
    const dashSpace = 3.0;
    final paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 1;

    var x = 0.0;
    while (x < size.width) {
      canvas.drawLine(Offset(x, 0), Offset(x + dashWidth, 0), paint);
      x += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant _DashedLinePainter oldDelegate) => false;
}
