import 'dart:io';
import 'dart:typed_data';

import 'package:bookie_buddy_web/core/common/widgets/dialogs/print_output_dispatcher.dart';
import 'package:bookie_buddy_web/core/common/widgets/global_loading_overlay.dart';
import 'package:bookie_buddy_web/core/di/app_dependencies.dart';
import 'package:bookie_buddy_core/features/booking/domain/entities/booking_details_entity/booking_details_entity.dart';
import 'package:bookie_buddy_web/features/booking/domain/usecases/get_booking_invoice_pdf_bytes_usecase.dart';
import 'package:bookie_buddy_web/features/printer/presentation/print/print_receipt_with_overlay.dart';
import 'package:bookie_buddy_ui/features/thermal_printer/presentation/receipt_design/builders/booking_receipt_canvas_builder.dart';
import 'package:bookie_buddy_web/utils/extensions/context_extensions.dart';
import 'package:bookie_buddy_web/utils/open_pdf_in_new_tab.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:printing/printing.dart';

/// Print/invoice actions for [BookingDetailsEntity] — booking's wiring
/// around the generic printer feature (`printer/presentation/print/`) and
/// this app's PDF-invoice handling (`printing`/`open_file` packages).
///
/// [printReceipt] is the single "Print" entry point exposed to the action
/// bar; [openInvoicePdf]/[printInvoicePdf] are the PDF-only half of that
/// dispatch, also usable standalone (e.g. the always-visible download
/// button). None of this is generic — a future sales equivalent gets its
/// own sibling class, reusing [ReceiptWithOverlay] and
/// [printWithOutputPreference] the same way this one does.
class BookingInvoiceActions {
  /// Single "Print" entry point — dispatches between the thermal receipt
  /// and the PDF invoice per Settings > Print Output preference (see
  /// [printWithOutputPreference]); this method is just the booking-specific
  /// wiring (which ticket builder, which invoice fetcher) around that
  /// shared dispatcher.
  static Future<void> printReceipt(
    BuildContext context,
    BookingDetailsEntity booking,
  ) {
    return printWithOutputPreference(
      context: context,
      printReceipt: () => ReceiptWithOverlay.printReceipt(
        context: context,
        buildTicket: (shop) => const BookingReceiptCanvasBuilder()(
          context: context,
          booking: booking,
          shop: shop,
        ),
      ),
      printPdfInvoice: () =>
          BookingInvoiceActions.printInvoicePdf(context, booking),
    );
  }

  /// Dev-only: renders the same ticket [printReceipt] would print and
  /// pushes a preview screen instead — see [ReceiptWithOverlay.previewReceipt].
  /// Callers must gate the button that triggers this behind
  /// `kIsDevelopment` themselves.
  static Future<void> previewReceipt(
    BuildContext context,
    BookingDetailsEntity booking,
  ) {
    return ReceiptWithOverlay.previewReceipt(
      context: context,
      buildTicket: (shop) => const BookingReceiptCanvasBuilder()(
        context: context,
        booking: booking,
        shop: shop,
      ),
    );
  }

  /// Opens the invoice PDF for [booking] — a new browser tab on web, or the
  /// OS's default PDF viewer via a temp file elsewhere.
  static Future<void> openInvoicePdf(
    BuildContext context,
    BookingDetailsEntity booking,
  ) async {
    final pdfBytes = await _fetchInvoicePdfBytes(context, booking);
    if (pdfBytes == null) return;

    try {
      if (kIsWeb) {
        openPdfInNewTab(pdfBytes, 'booking_invoice_${booking.id}.pdf');
        return;
      }

      final dir = await getTemporaryDirectory();
      final file = File('${dir.path}/booking_invoice_${booking.id}.pdf');
      await file.writeAsBytes(pdfBytes);
      await OpenFile.open(file.path);
    } catch (e) {
      if (context.mounted) {
        context.showSnackBar('Failed to open invoice: $e', isError: true);
      }
    }
  }

  /// Print-output-preference path for PDF invoices: skips the open-in-a-tab
  /// step entirely and hands the bytes straight to `Printing.layoutPdf`,
  /// which opens the browser's native print dialog on web (and the OS
  /// print/share sheet on other platforms) for the PDF itself — one click
  /// instead of "open, then print from there".
  static Future<void> printInvoicePdf(
    BuildContext context,
    BookingDetailsEntity booking,
  ) async {
    final pdfBytes = await _fetchInvoicePdfBytes(context, booking);
    if (pdfBytes == null) return;

    await Printing.layoutPdf(
      onLayout: (_) async => pdfBytes,
      name: 'booking_invoice_${booking.id}.pdf',
    );
  }

  /// Fetches the invoice PDF for [booking], wrapping the call with a loading
  /// overlay and a shared error snackbar — the bit [openInvoicePdf]
  /// and [printInvoicePdf] would otherwise duplicate. Returns `null`
  /// (after already showing the error) on failure, so callers can just bail.
  static Future<Uint8List?> _fetchInvoicePdfBytes(
    BuildContext context,
    BookingDetailsEntity booking,
  ) async {
    GlobalLoadingOverlay.show(context, text: 'Preparing invoice...');
    try {
      final pdfBytes = await getIt<GetBookingInvoicePdfBytesUseCase>()(
        booking.id,
      );
      GlobalLoadingOverlay.hide();
      return pdfBytes;
    } catch (e) {
      GlobalLoadingOverlay.hide();
      if (context.mounted) {
        context.showSnackBar('Failed to prepare invoice: $e', isError: true);
      }
      return null;
    }
  }
}
