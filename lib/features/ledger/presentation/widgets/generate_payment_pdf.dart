import 'dart:io';

import 'package:bookie_buddy_web/core/constants/app_assets.dart';
import 'package:bookie_buddy_web/utils/extensions/context_extensions.dart';
import 'package:bookie_buddy_web/utils/extensions/number_extensions.dart';
import 'package:bookie_buddy_web/utils/extensions/string_extensions.dart';
import 'package:bookie_buddy_web/core/models/user_shop_model/user_shop_model.dart';
import 'package:bookie_buddy_web/core/common/widgets/global_loading_overlay.dart';
import 'package:bookie_buddy_web/utils/get_pdf_image_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:share_plus/share_plus.dart';

// Payment Entry Model
class PaymentEntry {
  final String date;
  final String time;
  final String details;
  final int amount;

  PaymentEntry({
    required this.date,
    required this.time,
    required this.details,
    required this.amount,
  });
}

// Payment Summary Model
class PaymentSummary {
  final UserShopModel shopDetails;
  final String fromDate;
  final String toDate;
  final double totalAmount;
  final List<PaymentEntry> entries;

  PaymentSummary({
    required this.shopDetails,
    required this.fromDate,
    required this.toDate,
    required this.totalAmount,
    required this.entries,
  });
}

class PaymentPDFGenerator {
  static pw.Font? _defaultFont;
  static pw.Font? _fallbackFont;

  static PdfColor greyColor = const PdfColor.fromInt(0xFFEDEEFF); // Grey color

  static Future<void> _initializeFonts() async {
    if (_defaultFont == null) {
      final fontData = await rootBundle.load(AppAssets.notoSansMalayalamFont);
      _defaultFont = pw.Font.ttf(fontData);
    }

    if (_fallbackFont == null) {
      final fallbackFontData = await rootBundle.load(AppAssets.interFont);
      _fallbackFont = pw.Font.ttf(fallbackFontData);
    }
  }

  static pw.TextStyle _textStyle(
    double size, {
    pw.FontWeight? weight,
    PdfColor? color,
    bool isFallback = false,
  }) =>
      pw.TextStyle(
        fontSize: size,
        fontWeight: weight ?? pw.FontWeight.normal,
        font: isFallback ? _defaultFont : _fallbackFont,
        color: color ?? PdfColors.black,
      );

  static Future<String> generatePaymentStatement(
    PaymentSummary paymentData,
  ) async {
    await _initializeFonts();
    final pdf = pw.Document();

    final businessImage = await getPdfImageProvider(
      imagePath: paymentData.shopDetails.image,
      isAsset: false,
      assetImagePath: AppAssets.appLogoLight,
    );

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(20),
        build: (pw.Context context) => [
          _buildHeader(paymentData, businessImage),
          pw.SizedBox(height: 10),
          _buildDateRange(paymentData),
          pw.SizedBox(height: 10),
          _buildSummary(paymentData),
          pw.SizedBox(height: 10),
          _buildPaymentTable(paymentData.entries),
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

    final output = await getApplicationDocumentsDirectory();
    final file = File(
      '${output.path}/payment_statement_${paymentData.toDate}.pdf',
    );
    await file.writeAsBytes(await pdf.save());

    return file.path;
  }

  static pw.Widget _buildHeader(
    PaymentSummary paymentData,
    pw.ImageProvider? businessImage,
  ) =>
      pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                'Payment Statement',
                style: _textStyle(24, weight: pw.FontWeight.bold),
              ),
              pw.SizedBox(height: 5),
              pw.Text(paymentData.shopDetails.name, style: _textStyle(16)),
              pw.Text(
                paymentData.shopDetails.phone,
                style: _textStyle(12, color: PdfColors.grey700),
              ),
              if (paymentData.shopDetails.phone2.isNotNullOrEmpty)
                pw.Text(
                  paymentData.shopDetails.phone2!,
                  style: _textStyle(12, color: PdfColors.grey700),
                ),
              ...paymentData.shopDetails.fullAddress.splitByWords(5).map(
                    (line) => pw.Text(
                      line,
                      style: _textStyle(12, color: PdfColors.grey700),
                    ),
                  ),
            ],
          ),
          // Shop image
          if (businessImage != null)
            pw.Image(businessImage, width: 100, height: 100),
        ],
      );

  static pw.Widget _buildDateRange(PaymentSummary paymentData) => pw.Text(
        'Payments from ${paymentData.fromDate} to ${paymentData.toDate}',
        style: _textStyle(14, weight: pw.FontWeight.bold),
      );

  static pw.Widget _buildSummary(PaymentSummary paymentData) => pw.Container(
        width: double.infinity,
        color: greyColor,
        padding: const pw.EdgeInsets.all(10),
        child: pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Text('Total Payments:', style: _textStyle(14)),
            pw.Text(
              paymentData.totalAmount.toCurrency(),
              style: _textStyle(14, weight: pw.FontWeight.bold),
            ),
          ],
        ),
      );

  static pw.Widget _buildPaymentTable(List<PaymentEntry> entries) => pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Container(
            color: greyColor,
            padding: const pw.EdgeInsets.all(8),
            child: pw.Row(
              children: [
                pw.Expanded(
                  flex: 2,
                  child: pw.Text(
                    'Date',
                    style: _textStyle(12, weight: pw.FontWeight.bold),
                  ),
                ),
                pw.Expanded(
                  flex: 2,
                  child: pw.Text(
                    'Time',
                    style: _textStyle(12, weight: pw.FontWeight.bold),
                  ),
                ),
                pw.Expanded(
                  flex: 4,
                  child: pw.Text(
                    'Details',
                    style: _textStyle(12, weight: pw.FontWeight.bold),
                  ),
                ),
                pw.Expanded(
                  flex: 2,
                  child: pw.Text(
                    'Amount',
                    style: _textStyle(12, weight: pw.FontWeight.bold),
                    textAlign: pw.TextAlign.right,
                  ),
                ),
              ],
            ),
          ),
          ...entries.asMap().entries.map((entry) {
            final payment = entry.value;

            return pw.Container(
              color: PdfColors.white,
              padding:
                  const pw.EdgeInsets.symmetric(vertical: 8, horizontal: 8),
              child: pw.Row(
                children: [
                  pw.Expanded(
                    flex: 2,
                    child: pw.Text(payment.date, style: _textStyle(12)),
                  ),
                  pw.Expanded(
                    flex: 2,
                    child: pw.Text(payment.time, style: _textStyle(12)),
                  ),
                  pw.Expanded(
                    flex: 4,
                    child: pw.Text(payment.details, style: _textStyle(12)),
                  ),
                  pw.Expanded(
                    flex: 2,
                    child: pw.Text(
                      payment.amount.toCurrency(),
                      style: _textStyle(12),
                      textAlign: pw.TextAlign.right,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      );
}

class PaymentPDFService {
  static Future<String> generatePaymentStatementFile({
    required PaymentSummary paymentData,
  }) async {
    try {
      final filePath = await PaymentPDFGenerator.generatePaymentStatement(
        paymentData,
      );
      debugPrint('Payment PDF generated at: $filePath');
      return filePath;
    } catch (e) {
      debugPrint('Error generating payment PDF: $e');
      rethrow;
    }
  }

  static Future<void> sharePaymentStatement({
    required PaymentSummary paymentData,
    required BuildContext context,
  }) async {
    try {
      GlobalLoadingOverlay.show(context, text: 'Generating payment PDF...');
      final filePath = await PaymentPDFGenerator.generatePaymentStatement(
        paymentData,
      );
      GlobalLoadingOverlay.hide();
      final box =
          context.isMobile ? null : context.findRenderObject() as RenderBox?;

      final fileName = filePath.split('/').last;
      await SharePlus.instance.share(
        ShareParams(
          title: fileName,
          subject: fileName,
          previewThumbnail: XFile(filePath),
          files: [XFile(filePath)],
          sharePositionOrigin:
              box == null ? null : box.localToGlobal(Offset.zero) & box.size,
        ),
      );
    } catch (e) {
      debugPrint('Error sharing payment PDF: $e');
      rethrow;
    }
  }
}
