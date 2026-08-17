import 'package:flutter/material.dart';

import '../../../domain/entities/print_ticket_entity/print_ticket_entity.dart';
import '../../../domain/print_ticket_builder.dart';
import 'monochrome.dart';
import 'offscreen_render.dart';

/// One column inside a [ReceiptCanvas.row] — e.g. an item name, a qty, an
/// amount.
class ReceiptColumn {
  const ReceiptColumn(
    this.text, {
    this.flex = 1,
    this.align = TextAlign.left,
    this.bold = false,
    this.subtitle,
    this.subtitleSize = 15,
  });

  final String text;
  final int flex;
  final TextAlign align;
  final bool bold;

  /// An optional second line rendered under [text], confined to this same
  /// column's width — e.g. an item's category/color/variant line under its
  /// name. Deliberately *inside* the column's own `Expanded` cell rather
  /// than a separate full-width line below the row: a full-width line
  /// starts flush at the row's left edge regardless of which column it's
  /// meant to belong to, so on a multi-column row it visually runs under
  /// whatever earlier columns (e.g. a serial number) happen to sit above
  /// it instead of staying under its own column.
  final String? subtitle;
  final double subtitleSize;
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

  static const _fontFamily = 'Inter';
  static const _ink = Colors.black;

  static const _fontWeightBold = FontWeight.w600;
  static const _fontWeightNormal = FontWeight.normal;

  static const double defaultSectionTitleSize = 18;

  /// Extra gap after one row in a list of similar rows (item rows, line
  /// items, ...), on top of [row]'s own default vertical spacing — set
  /// apart so a dense list doesn't read as one solid block. A constant
  /// rather than a per-call default since it's specific to *lists* of
  /// rows, not every `row()` call.
  static const double defaultListRowSpacing = 4;

  static const double defaultSpaceAfterList = 30;

  void text(
    String value, {
    bool bold = false,
    bool center = false,
    double size = 12.5,
    double topSpacing = 0,
    double bottomSpacing = 5,
  }) {
    _pending.add(
      Padding(
        padding: EdgeInsets.only(top: topSpacing, bottom: bottomSpacing),
        child: Text(
          value,
          textAlign: center ? TextAlign.center : TextAlign.left,
          style: TextStyle(
            fontFamily: _fontFamily,
            fontSize: size,
            fontWeight: bold ? _fontWeightBold : _fontWeightNormal,
            color: _ink,
            height: 1.3,
          ),
        ),
      ),
    );
  }

  void textTitle(String value, {bool bold = true}) =>
      text(value, center: true, bold: bold, size: 20);

  void row(
    List<ReceiptColumn> columns, {
    bool bold = false,
    double size = 19,
    double verticalSpacing = 3,
  }) {
    _pending.add(
      Padding(
        padding: EdgeInsets.symmetric(vertical: verticalSpacing),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (final column in columns)
              Expanded(
                flex: column.flex,
                child: Column(
                  crossAxisAlignment: column.align == TextAlign.right
                      ? CrossAxisAlignment.end
                      : CrossAxisAlignment.start,
                  children: [
                    Text(
                      column.text,
                      textAlign: column.align,
                      style: TextStyle(
                        fontFamily: _fontFamily,
                        fontSize: size,
                        fontWeight: (bold || column.bold)
                            ? _fontWeightBold
                            : _fontWeightNormal,
                        color: _ink,
                      ),
                    ),
                    if (column.subtitle != null &&
                        column.subtitle!.trim().isNotEmpty)
                      Text(
                        column.subtitle!,
                        textAlign: column.align,
                        style: TextStyle(
                          fontFamily: _fontFamily,
                          fontSize: column.subtitleSize,
                          color: _ink,
                        ),
                      ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  /// [heavy] draws a solid double-weight rule (hard section break — items
  /// table header, totals); otherwise a dashed rule (soft break). [topSpacing]
  /// / [bottomSpacing] let a caller tighten the gap around one specific
  /// divider (e.g. the one right under the header) without affecting the
  /// default spacing used everywhere else.
  void divider({
    bool heavy = false,
    double topSpacing = 5,
    double bottomSpacing = 14,
  }) {
    _pending.add(
      Padding(
        padding: EdgeInsets.only(top: topSpacing, bottom: bottomSpacing),
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

  void numberedList(
    List<String> items, {
    double size = 9.5,
    double bottomSpacing = 4,
  }) {
    _pending.add(
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (var i = 0; i < items.length; i++)
            Padding(
              padding: EdgeInsets.only(bottom: bottomSpacing),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${i + 1}. ',
                    style: TextStyle(
                      fontFamily: _fontFamily,
                      fontSize: size,
                      color: _ink,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      items[i],
                      style: TextStyle(
                        fontFamily: _fontFamily,
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

  /// Appends a native ESC/POS text command straight to the ticket, bypassing
  /// the widget/image pipeline entirely — unlike every other command here,
  /// this isn't rasterized, so it goes directly to [_builder] rather than
  /// [_pending]. Prints in the printer's own built-in font rather than
  /// whatever's set via `ReceiptCanvas.text()`'s Flutter styling, so it
  /// won't visually match the rest of a raster-built receipt — reach for
  /// this when you specifically need a native (non-image) line, e.g.
  /// probing printer/firmware behavior in isolation from anything this
  /// canvas rasterizes. See [PrintTicketTextCommand].
  void rawText(String value) => _builder.text(value);

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

  /// Builds one row/section per element of [items] via [buildItem], with an
  /// extra [flushSection] partway through once the list passes
  /// [splitThreshold] — so an unusually long list (many booking items,
  /// many sale line items, ...) doesn't force one single raster image to
  /// hold the entire thing. Purely an internal rendering detail: the
  /// printed paper is one continuous strip either way, so there's no
  /// visible seam or repeated header for the customer to see.
  ///
  /// Generic over what "an item" even is — [buildItem] is just however the
  /// caller wants to queue up commands (`row()`, `text()`, ...) for one
  /// element; this only owns the split/flush mechanics.
  Future<void> buildLongList<T>(
    List<T> items,
    void Function(T item, int index) buildItem, {
    int splitThreshold = 40,
  }) async {
    for (var i = 0; i < items.length; i++) {
      buildItem(items[i], i);
      final isSplitPoint = i == splitThreshold - 1;
      if (isSplitPoint && items.length > splitThreshold) {
        await flushSection();
      }
    }
  }

  /// The single big "divider — bold centered total — divider" banner every
  /// receipt with a payable total wants somewhere between its items and
  /// its payment breakdown — no receipt-type-specific data involved, just
  /// [totalText] already formatted the way the caller wants it printed
  /// (e.g. `'TOTAL: Rs. 1,234.00'`).
  void buildGrandTotal(
    String totalText, {
    double size = 30,
    double verticalSpacing = 6,
    double dividerSpaceAround = 8,
  }) {
    divider(bottomSpacing: dividerSpaceAround);
    text(
      totalText,
      bold: true,
      center: true,
      size: size,
      topSpacing: verticalSpacing,
      bottomSpacing: verticalSpacing,
    );
    divider(topSpacing: dividerSpaceAround);
  }

  // Blank feed before the cut, so the cutter blade (typically a few
  // line-heights below the print head) doesn't slice through the last
  // printed line — this becomes trailing space at the *bottom* of this
  // receipt, not leading space at the top of the next one.
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
    const dashWidth = 6.0;
    const dashSpace = 3.0;
    final paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 0;

    var x = 0.0;
    while (x < size.width) {
      canvas.drawLine(Offset(x, 0), Offset(x + dashWidth, 0), paint);
      x += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant _DashedLinePainter oldDelegate) => false;
}
