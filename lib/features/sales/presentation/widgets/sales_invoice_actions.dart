import 'dart:io';
import 'dart:typed_data';

import 'package:bookie_buddy_web/core/common/widgets/dialogs/print_output_dispatcher.dart';
import 'package:bookie_buddy_web/core/common/widgets/global_loading_overlay.dart';
import 'package:bookie_buddy_web/core/di/app_dependencies.dart';
import 'package:bookie_buddy_web/features/printer/presentation/print/print_receipt_with_overlay.dart';
import 'package:bookie_buddy_web/features/printer/presentation/receipt_design/builders/sales_receipt_canvas_builder.dart';
import 'package:bookie_buddy_web/features/sales/domain/entities/sale_details_entity/sale_details_entity.dart';
import 'package:bookie_buddy_web/features/sales/domain/usecases/get_sale_invoice_pdf_usecase.dart';
import 'package:bookie_buddy_web/utils/extensions/context_extensions.dart';
import 'package:bookie_buddy_web/utils/open_pdf_in_new_tab.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:printing/printing.dart';

/// Print/invoice actions for [SaleDetailsEntity] — sales' sibling of
/// `BookingInvoiceActions`, same shape and split of responsibilities:
/// [printReceipt] is the single "Print" entry point exposed to the action
/// bar; [openInvoicePdf]/[printInvoicePdf] are the PDF-only half of that
/// dispatch, also usable standalone (e.g. the always-visible download
/// button); [previewReceipt] is the dev-only receipt-design preview.
class SalesInvoiceActions {
  /// Single "Print" entry point — dispatches between the thermal receipt
  /// and the PDF invoice per Settings > Print Output preference (see
  /// [printWithOutputPreference]); this method is just the sales-specific
  /// wiring (which ticket builder, which invoice fetcher) around that
  /// shared dispatcher.
  static Future<void> printReceipt(
    BuildContext context,
    SaleDetailsEntity sale,
  ) {
    return printWithOutputPreference(
      context: context,
      printReceipt: () => ReceiptWithOverlay.printReceipt(
        context: context,
        buildTicket: (shop) => const SalesReceiptCanvasBuilder()(
          context: context,
          sale: sale,
          shop: shop,
        ),
      ),
      printPdfInvoice: () => SalesInvoiceActions.printInvoicePdf(
        context,
        sale,
      ),
    );
  }

  /// Dev-only: renders the same ticket [printReceipt] would print and
  /// pushes a preview screen instead — see [ReceiptWithOverlay.previewReceipt].
  /// Callers must gate the button that triggers this behind
  /// `kIsDevelopment` themselves.
  static Future<void> previewReceipt(
    BuildContext context,
    SaleDetailsEntity sale,
  ) {
    return ReceiptWithOverlay.previewReceipt(
      context: context,
      buildTicket: (shop) => const SalesReceiptCanvasBuilder()(
        context: context,
        sale: sale,
        shop: shop,
      ),
    );
  }

  /// Opens the invoice PDF for [sale] — a new browser tab on web, or the
  /// OS's default PDF viewer via a temp file elsewhere.
  static Future<void> openInvoicePdf(
    BuildContext context,
    SaleDetailsEntity sale,
  ) async {
    final pdfBytes = await _fetchInvoicePdfBytes(context, sale);
    if (pdfBytes == null) return;

    try {
      if (kIsWeb) {
        openPdfInNewTab(pdfBytes, 'sales_invoice_${sale.id}.pdf');
        return;
      }

      final dir = await getTemporaryDirectory();
      final file = File('${dir.path}/sales_invoice_${sale.id}.pdf');
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
    SaleDetailsEntity sale,
  ) async {
    final pdfBytes = await _fetchInvoicePdfBytes(context, sale);
    if (pdfBytes == null) return;

    await Printing.layoutPdf(
      onLayout: (_) async => pdfBytes,
      name: 'sales_invoice_${sale.id}.pdf',
    );
  }

  /// Fetches the invoice PDF for [sale], wrapping the call with a loading
  /// overlay and a shared error snackbar — the bit [openInvoicePdf]
  /// and [printInvoicePdf] would otherwise duplicate. Returns `null`
  /// (after already showing the error) on failure, so callers can just bail.
  static Future<Uint8List?> _fetchInvoicePdfBytes(
    BuildContext context,
    SaleDetailsEntity sale,
  ) async {
    GlobalLoadingOverlay.show(context, text: 'Preparing invoice...');
    try {
      final pdfBytes = await getIt<GetSaleInvoicePdfUseCase>()(sale.id);
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
