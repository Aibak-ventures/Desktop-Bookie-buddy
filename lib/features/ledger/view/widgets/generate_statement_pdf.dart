import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

import 'package:bookie_buddy_web/core/app_dependencies.dart';
import 'package:bookie_buddy_web/core/constants/app_assets.dart';
import 'package:bookie_buddy_web/core/enums/invoice_enums.dart';
import 'package:bookie_buddy_web/core/extensions/context_extensions.dart';
import 'package:bookie_buddy_web/core/extensions/number_extensions.dart';
import 'package:bookie_buddy_web/core/extensions/string_extensions.dart';
import 'package:bookie_buddy_web/core/models/user_model/user_model.dart';
import 'package:bookie_buddy_web/core/models/user_shop_model/user_shop_model.dart';
import 'package:bookie_buddy_web/core/ui/widgets/global_loading_overlay.dart';
import 'package:bookie_buddy_web/core/utils/share_file.dart';
import 'package:bookie_buddy_web/core/view_model/cubit_client/client_cubit.dart';
import 'package:bookie_buddy_web/features/ledger/models/ledger_invoice_entry_model/ledger_invoice_entry_model.dart';
import 'package:bookie_buddy_web/features/ledger/models/ledger_summary_model.dart';
import 'package:bookie_buddy_web/features/ledger/repository/ledger_repository.dart';
import 'package:bookie_buddy_web/utils/get_pdf_image_provider.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

// Usage service class
class LedgerPDFService {
  // Share directly
  static Future<void> shareLedgerInvoice({
    required BuildContext context,
    required UserModel user,
    required String fromDate,
    required String toDate,
    bool includePayments = false,
    bool includeExpense = false,
    bool includeSecurity = false,
    bool includePendings = false,
    bool includeBookings = false,
    bool includeSales = false,
    required bool isExcel,
    List<LedgerInvoiceEntryModel>? invoiceData,
  }) async {
    GlobalLoadingOverlay.show(
      context,
      text: 'Generating Ledger ${isExcel ? 'Excel' : 'PDF'}...',
    );
    LedgerType type;
    if (includePayments && includeExpense) {
      type = LedgerType.all;
    } else if (includePayments) {
      type = LedgerType.payments;
    } else if (includeExpense) {
      type = LedgerType.expense;
    } else if (includePendings) {
      type = LedgerType.pendings;
    } else if (includeSecurity) {
      type = LedgerType.security;
    } else if (includeBookings) {
      type = LedgerType.bookings;
    } else if (includeSales) {
      type = LedgerType.sales;
    } else {
      GlobalLoadingOverlay.hide();
      return;
    }
    log('statement type: $type');

    final clientId = context.read<ClientCubit>().state.selectedClient?.id;

    debugPrint('pdf clientId: $clientId');

    final typeValue = type == LedgerType.all
        ? '${LedgerType.payments.value},${LedgerType.expense.value}'
        : type.value;

    // Download Excel
    if (isExcel) {
      try {
        final filePath = await getIt
            .get<LedgerRepository>()
            .downloadLedgerInvoice(
              fromDate: fromDate,
              toDate: toDate,
              type: typeValue,
              clientId: clientId,
              ledgerType: type,
            );
        GlobalLoadingOverlay.hide();
        await shareFile(context: context, filePath: filePath);
      } catch (e, stack) {
        log('Error downloading ledger invoice: $e', stackTrace: stack);
        context.showSnackBar(e.toString(), isError: true);
      } finally {
        GlobalLoadingOverlay.hide();
      }
      return;
    }

    // Download PDF
    try {
      final entries =
          invoiceData ??
          await getIt.get<LedgerRepository>().getLedgerInvoiceData(
            fromDate: fromDate,
            toDate: toDate,
            type: typeValue,
            clientId: clientId,
          );

      double totalReceived = 0;
      double totalExpense = 0;
      double total = 0;

      entries.forEach((entry) {
        if (entry.type.isPayments) {
          totalReceived += entry.amount;
        } else {
          totalExpense += entry.amount;
        }
        total += entry.amount;
      });
      final balance = totalReceived - totalExpense;
      final shop = user.shopDetails;
      final ledgerData = LedgerSummaryModel(
        shopDetails: shop,
        fromDate: fromDate,
        toDate: toDate,
        isSinglePdf: !(includePayments && includeExpense),
        total: total,
        totalReceived: totalReceived,
        totalExpense: totalExpense,
        balance: balance,
        entries: entries,
        pdfName: type == LedgerType.all ? 'ledger' : type.value,
      );

      await _shareStatement(ledgerData: ledgerData, context: context);
    } catch (e, stack) {
      log('Error generating ledger PDF: $e', stackTrace: stack);
      context.showSnackBar(e.toString(), isError: true);
    } finally {
      GlobalLoadingOverlay.hide();
    }
  }

  // Share PDF directly
  static Future<void> _shareStatement({
    required LedgerSummaryModel ledgerData,
    required BuildContext context,
  }) async {
    try {
      if (kIsWeb) {
        // Web-specific PDF generation and download
        await LedgerPDFGenerator.generateAndDownloadLedgerStatementWeb(
          ledgerData,
          context,
        );
        GlobalLoadingOverlay.hide();
      } else {
        // Mobile/Desktop PDF generation
        final filePath = await LedgerPDFGenerator.generateLedgerStatement(
          ledgerData,
        );
        GlobalLoadingOverlay.hide();
        await shareFile(context: context, filePath: filePath);
      }
    } catch (e) {
      debugPrint('Error sharing ledger PDF: $e');
      rethrow;
    }
  }
}

//======================LedgerPDFGenerator======================//

class LedgerPDFGenerator {
  static pw.Font? _malayalamFont;
  static pw.Font? _fallbackFont;
  static pw.Font? materialIconFont;

  // Initialize fonts
  static Future<void> _initializeFonts() async {
    if (_malayalamFont == null || _fallbackFont == null) {
      try {
        final malayalamFontData = await rootBundle.load(
          AppAssets.notoSansMalayalamFont,
        );
        _malayalamFont = pw.Font.ttf(malayalamFontData);
      } catch (e) {
        debugPrint('Malayalam font not found: $e');
      }

      try {
        final fallbackFontData = await rootBundle.load(AppAssets.interFont);
        _fallbackFont = pw.Font.ttf(fallbackFontData);
      } catch (e) {
        debugPrint('Fallback font not found: $e');
      }
    }
    if (materialIconFont == null) {
      try {
        final materialIconData = await rootBundle.load(
          AppAssets.materialIconFont,
        );
        materialIconFont = pw.Font.ttf(materialIconData);
      } catch (e) {
        debugPrint('Material icon font not found: $e');
      }
    }
  }

  // Get font with fallback
  static pw.Font? _getFont({bool isFallback = false}) {
    if (!isFallback && _malayalamFont != null) {
      return _malayalamFont;
    }
    return _fallbackFont;
  }

  // Reusable text styles
  static pw.TextStyle _getTitleStyle() => pw.TextStyle(
    fontSize: 24,
    fontWeight: pw.FontWeight.bold,
    font: _getFont(),
  );

  static pw.TextStyle _getHeaderStyle() => pw.TextStyle(
    fontSize: 16,
    fontWeight: pw.FontWeight.bold,
    font: _getFont(),
  );

  static pw.TextStyle _getSubHeaderStyle() => pw.TextStyle(
    fontSize: 13,
    fontWeight: pw.FontWeight.bold,
    font: _getFont(),
  );

  static pw.TextStyle _getBodyStyle() =>
      pw.TextStyle(fontSize: 12, font: _getFont());

  static pw.TextStyle _getSmallStyle() =>
      pw.TextStyle(fontSize: 13, font: _getFont(), color: PdfColors.grey600);

  static pw.TextStyle _getAmountStyle({PdfColor? color}) => pw.TextStyle(
    fontSize: 12,
    fontWeight: pw.FontWeight.bold,
    font: _getFont(),
    color: color ?? PdfColors.black,
  );

  static pw.TextStyle _getSummaryAmountStyle() => pw.TextStyle(
    fontSize: 12,
    fontWeight: pw.FontWeight.bold,
    font: _getFont(),
  );

  static pw.Text upArrowIcon() => pw.Text(
    String.fromCharCode(0xE5D8), // ↑ arrow_upward
    style: pw.TextStyle(
      font: materialIconFont,
      fontSize: 16,
      color: PdfColors.red,
    ),
  );

  static pw.Text downArrowIcon() => pw.Text(
    String.fromCharCode(0xE5DB), // ↓ arrow_downward
    style: pw.TextStyle(
      font: materialIconFont,
      fontSize: 16,
      color: PdfColors.green,
    ),
  );

  static PdfColor greyColor = const PdfColor.fromInt(0xFFEDEEFF); // Grey color

  // Web-specific function to generate and download ledger PDF
  static Future<void> generateAndDownloadLedgerStatementWeb(
    LedgerSummaryModel ledgerData,
    BuildContext context,
  ) async {
    try {
      await _initializeFonts();
      final pdf = pw.Document();

      final businessImage = await getPdfImageProvider(
        imagePath: ledgerData.shopDetails.image,
        isAsset: false,
        assetImagePath: AppAssets.appLogoLight,
      );

      pdf.addPage(
        pw.MultiPage(
          pageFormat: PdfPageFormat.a4,
          margin: const pw.EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          crossAxisAlignment: pw.CrossAxisAlignment.center,
          build: (pw.Context context) => [
            _buildHeader(ledgerData, businessImage),
            pw.SizedBox(height: 2),
            _buildDateRange(ledgerData),
            pw.SizedBox(height: 10),
            _buildSummarySection(ledgerData),
            pw.SizedBox(height: 10),
            _buildEntriesTable(ledgerData),
          ],
          footer: (pw.Context context) => pw.Align(
            alignment: pw.Alignment.centerRight,
            child: pw.Text(
              'Powered by www.bookiebuddy.in',
              style: const pw.TextStyle(fontSize: 10, color: PdfColors.grey600),
            ),
          ),
        ),
      );

      // Generate PDF bytes
      final Uint8List pdfBytes = await pdf.save();

      // Create filename
      final fileName =
          '${ledgerData.pdfName}_report_${ledgerData.fromDate}_to_${ledgerData.toDate}.pdf';

      // Trigger download in browser
      final blob = html.Blob([pdfBytes], 'application/pdf');
      final url = html.Url.createObjectUrlFromBlob(blob);
      html.AnchorElement(href: url)
        ..setAttribute('download', fileName)
        ..click();
      html.Url.revokeObjectUrl(url);

      if (context.mounted) {
        context.showSnackBar('PDF downloaded successfully');
      }
    } catch (e, stack) {
      debugPrint('Error generating PDF for web: $e');
      debugPrint('Stack trace: $stack');
      rethrow;
    }
  }

  // Main function to generate ledger PDF (for mobile/desktop)
  static Future<String> generateLedgerStatement(
    LedgerSummaryModel ledgerData,
  ) async {
    await _initializeFonts();
    final pdf = pw.Document();

    final businessImage = await getPdfImageProvider(
      imagePath: ledgerData.shopDetails.image,
      isAsset: false,
      assetImagePath: AppAssets.appLogoLight,
    );

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        crossAxisAlignment: pw.CrossAxisAlignment.center,
        build: (pw.Context context) => [
          _buildHeader(ledgerData, businessImage),
          pw.SizedBox(height: 2),
          _buildDateRange(ledgerData),
          pw.SizedBox(height: 10),
          _buildSummarySection(ledgerData),
          pw.SizedBox(height: 10),
          _buildEntriesTable(ledgerData),
        ],
        footer: (pw.Context context) => pw.Align(
          alignment: pw.Alignment.centerRight,
          child: pw.Text(
            'Powered by www.bookiebuddy.in',
            style: const pw.TextStyle(fontSize: 10, color: PdfColors.grey600),
          ),
        ),
      ),
    );

    // Save PDF to device
    final output = await getApplicationDocumentsDirectory();
    final file = File(
      '${output.path}/${ledgerData.pdfName}_report_${ledgerData.fromDate}_to_${ledgerData.toDate}.pdf',
    );
    await file.writeAsBytes(await pdf.save());

    return file.path;
  }

  // Share PDF function
  // static Future<void> shareLedgerStatement(LedgerSummary ledgerData) async {}

  // Header section with business info and title
  static pw.Widget _buildHeader(
    LedgerSummaryModel ledgerData,
    pw.ImageProvider businessImage,
  ) => pw.Container(
    width: double.infinity,
    child: pw.Column(
      children: [
        // Title with underline
        pw.Text(
          'Ledger Book Statements',
          style: _getTitleStyle().copyWith(
            decorationStyle: pw.TextDecorationStyle.solid,
            decorationColor: PdfColors.black,
            decorationThickness: 1.5,
            decoration: pw.TextDecoration.underline,
          ),
        ),
        pw.SizedBox(),

        // Business info with image
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            // Business name and location
            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(ledgerData.shopDetails.name, style: _getHeaderStyle()),
                pw.Text(ledgerData.shopDetails.phone, style: _getSmallStyle()),
                if (ledgerData.shopDetails.phone2.isNotNullOrEmpty)
                  pw.Text(
                    ledgerData.shopDetails.phone2!,
                    style: _getSmallStyle(),
                  ),
                ...ledgerData.shopDetails.fullAddress
                    .splitByWords(5)
                    .map((e) => pw.Text(e, style: _getSmallStyle())),
              ],
            ),

            // Business image
            pw.Padding(
              padding: const pw.EdgeInsets.all(4),
              child: pw.Image(businessImage, width: 100, height: 100),
            ),
          ],
        ),
      ],
    ),
  );

  // Date range section
  static pw.Widget _buildDateRange(LedgerSummaryModel ledgerData) => pw.Row(
    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
    children: [
      pw.Text(
        'Statements from ${ledgerData.fromDate} - ${ledgerData.toDate}',
        style: _getSubHeaderStyle(),
      ),
      if (!ledgerData.isSinglePdf)
        pw.Row(
          children: [
            pw.Container(
              padding: const pw.EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 4,
              ),
              decoration: pw.BoxDecoration(
                color: PdfColors.red50,
                borderRadius: pw.BorderRadius.circular(4),
              ),
              child: pw.Row(
                children: [
                  upArrowIcon(),
                  pw.Text(
                    ' Expense',
                    style: _getSmallStyle().copyWith(
                      color: PdfColors.red,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            pw.SizedBox(width: 10),
            pw.Container(
              padding: const pw.EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 4,
              ),
              decoration: pw.BoxDecoration(
                color: PdfColors.green50,
                borderRadius: pw.BorderRadius.circular(4),
              ),
              child: pw.Row(
                children: [
                  downArrowIcon(),
                  pw.Text(
                    ' Received',
                    style: _getSmallStyle().copyWith(
                      color: PdfColors.green,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
    ],
  );

  // Summary section with total amounts
  static pw.Widget _buildSummarySection(LedgerSummaryModel ledgerData) {
    final Map<String, int> expenseCategories = {};
    ledgerData.entries.forEach((entry) {
      if (entry.type.isExpense) {
        final category = entry.description.toLowerCase();
        if (expenseCategories.containsKey(category)) {
          expenseCategories[category] =
              expenseCategories[category]! + entry.amount;
        } else {
          expenseCategories[category] = entry.amount;
        }
      }
    });
    return pw.Column(
      children: [
        // Title with grey background, no extra padding inside
        pw.Container(
          width: double.infinity,
          color: greyColor,
          child: pw.Padding(
            padding: const pw.EdgeInsets.symmetric(vertical: 4, horizontal: 16),
            child: pw.Text('Summary', style: _getSubHeaderStyle()),
          ),
        ),

        pw.Container(
          padding: const pw.EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              if (expenseCategories.isNotEmpty) ...[
                pw.SizedBox(height: 8),

                // Add your dynamic list here
                ...expenseCategories.entries.map(
                  (entry) => pw.Column(
                    children: [
                      _buildSummaryRow(
                        '${entry.key} :',
                        entry.value.toCurrency(),
                      ),
                      pw.SizedBox(height: 8),
                    ],
                  ),
                ),
              ],
              // If isSinglePdf, show only total
              if (ledgerData.isSinglePdf) ...[
                _buildSummaryRow('Total :', ledgerData.total.toCurrency()),
              ] else ...[
                _buildSummaryRow(
                  'Total received :',
                  ledgerData.totalReceived.toCurrency(),
                ),
                pw.SizedBox(height: 8),
                _buildSummaryRow(
                  'Total Expense :',
                  ledgerData.totalExpense.toCurrency(),
                ),
                pw.SizedBox(height: 8),
                _buildSummaryRow(
                  'Balance :',
                  ledgerData.balance.toCurrency(),
                  overrideStyle: _getSummaryAmountStyle().copyWith(
                    color: ledgerData.balance >= 0
                        ? PdfColors.green
                        : PdfColors.red,
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }

  static pw.Widget _buildSummaryRow(
    String label,
    String value, {
    pw.TextStyle? overrideStyle,
  }) => pw.Row(
    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
    children: [
      pw.Text(label, style: _getBodyStyle()),
      pw.Text(value, style: overrideStyle ?? _getSummaryAmountStyle()),
    ],
  );

  // Entries table section
  static pw.Widget _buildEntriesTable(LedgerSummaryModel ledgerData) {
    debugPrint(
      'isBooking: ${ledgerData.entries.firstOrNull?.type.isBookings ?? false}, type: ${ledgerData.entries.firstOrNull?.type}',
    );
    final isBookings = ledgerData.entries.firstOrNull?.type.isBookings ?? false;
    final isSales = ledgerData.entries.firstOrNull?.type.isSales ?? false;
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        // Table header with grey background like summary
        pw.Container(
          width: double.infinity,
          color: greyColor,
          padding: const pw.EdgeInsets.symmetric(vertical: 6, horizontal: 16),
          child: pw.Row(
            children: [
              pw.Expanded(
                flex: 2,
                child: pw.Text('Date', style: _getSubHeaderStyle()),
              ),
              if (isBookings)
                pw.Expanded(
                  flex: 2,
                  child: pw.Text('Id', style: _getSubHeaderStyle()),
                ),
              pw.Expanded(
                flex: isBookings ? 4 : 2,
                child: pw.Text('Name', style: _getSubHeaderStyle()),
              ),
              if (!isBookings)
                pw.Expanded(
                  flex: 4,
                  child: pw.Text(
                    isSales ? 'Items' : 'Description',
                    style: _getSubHeaderStyle(),
                  ),
                ),
              pw.Expanded(
                flex: 2,
                child: pw.Text(
                  'Amount',
                  style: _getSubHeaderStyle(),
                  textAlign: pw.TextAlign.right,
                ),
              ),
            ],
          ),
        ),

        // Entries rows (flat layout, no box)
        ...ledgerData.entries.asMap().entries.map((entry) {
          final int index = entry.key;
          final LedgerInvoiceEntryModel ledgerEntry = entry.value;

          return pw.Container(
            color: index % 2 == 0 ? PdfColors.white : PdfColors.grey50,
            padding: const pw.EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: pw.Row(
              children: [
                pw.Expanded(
                  flex: 2,
                  child: pw.Text(ledgerEntry.date, style: _getBodyStyle()),
                ),
                if (isBookings)
                  pw.Expanded(
                    flex: 2,
                    child: pw.Text(
                      ledgerEntry.description,
                      style: _getBodyStyle(),
                    ),
                  ),
                pw.Expanded(
                  flex: isBookings ? 4 : 2,
                  child: pw.Text(ledgerEntry.user, style: _getBodyStyle()),
                ),
                if (!isBookings)
                  pw.Expanded(
                    flex: 4,
                    child: pw.Text(
                      isSales
                          ? ledgerEntry.products.isNotEmpty
                                ? ledgerEntry.products.join(', ')
                                : 'N/A'
                          : ledgerEntry.description,
                      style: _getBodyStyle(),
                    ),
                  ),
                pw.Expanded(
                  flex: 2,
                  child: pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.end,
                    children: [
                      if (!ledgerData.isSinglePdf)
                        ledgerEntry.type.isPayments
                            ? downArrowIcon()
                            : upArrowIcon(),
                      if (!ledgerData.isSinglePdf) pw.SizedBox(width: 4),
                      pw.Text(
                        ledgerEntry.amount.toCurrency(),
                        style: _getAmountStyle(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ],
    );
  }
}
