import 'dart:developer';
import 'dart:io';

import 'package:bookie_buddy_web/core/extensions/context_extensions.dart';
import 'package:bookie_buddy_web/core/models/product_model/product_model.dart';
import 'package:bookie_buddy_web/core/models/user_shop_model/user_shop_model.dart';
import 'package:bookie_buddy_web/core/ui/widgets/global_loading_overlay.dart';
import 'package:bookie_buddy_web/utils/get_pdf_image_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:share_plus/share_plus.dart';
import 'package:intl/intl.dart';

class GenerateAvailableProductsPdf {
  static Future<void> shareInvoice({
    required BuildContext context,
    required List<ProductModel> products,
    required UserShopModel shopDetails,
    required String availabilityDate,
  }) async {
    try {
      GlobalLoadingOverlay.show(context, text: 'Generating PDF...');
      final pdf = await generateAvailableProductsPdf(products, shopDetails, availabilityDate);
      
      // Save PDF to device
      final output = await getApplicationDocumentsDirectory();

      final box = context.isMobile
          ? null
          : context.findRenderObject() as RenderBox?;

      final file = File(
        '${output.path}/available_products_${DateTime.now().millisecondsSinceEpoch}.pdf',
      );
      await file.writeAsBytes(pdf);
      final fileName = file.path.split('/').last;
      GlobalLoadingOverlay.hide();
      await SharePlus.instance.share(
        ShareParams(
          title: fileName,
          subject: fileName,
          previewThumbnail: XFile(file.path),
          files: [XFile(file.path)],
          sharePositionOrigin: box == null
              ? null
              : Rect.fromLTWH(
                  box.localToGlobal(Offset.zero).dx,
                  box.localToGlobal(Offset.zero).dy,
                  box.size.width,
                  box.size.height,
                ),
        ),
      );
    } catch (e, stackTrace) {
      GlobalLoadingOverlay.hide();
      log('Error sharing available products PDF: $e', stackTrace: stackTrace);
      if (context.mounted) {
        context.showSnackBar('Failed to generate PDF: $e');
      }
    }
  }

  static Future<Uint8List> generateAvailableProductsPdf(
    List<ProductModel> products,
    UserShopModel shopDetails,
    String availabilityDate,
  ) async {
    final pdf = pw.Document();

    // Load font
    final font = await rootBundle.load('assets/fonts/Roboto-Regular.ttf');
    final ttf = pw.Font.ttf(font);

    // Load logo
    pw.ImageProvider? logoProvider;
    try {
      if (shopDetails.image != null && shopDetails.image!.isNotEmpty) {
        logoProvider = await getPdfImageProvider(
          imagePath: shopDetails.image!,
          isAsset: false,
        );
      }
    } catch (e) {
      log('Failed to load logo: $e');
    }

    pdf.addPage(
      pw.MultiPage(
        build: (pw.Context context) => [
          _buildHeader(shopDetails, logoProvider, ttf),
          pw.SizedBox(height: 20),
          _buildAvailabilityInfo(availabilityDate, ttf),
          pw.SizedBox(height: 20),
          _buildProductsTable(products, ttf),
          pw.SizedBox(height: 30),
          _buildFooter(ttf),
        ],
      ),
    );

    return pdf.save();
  }

  static pw.Widget _buildHeader(
    UserShopModel shopDetails,
    pw.ImageProvider? logoProvider,
    pw.Font font,
  ) {
    return pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Expanded(
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                shopDetails.name,
                style: pw.TextStyle(
                  font: font,
                  fontSize: 24,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              if (shopDetails.address.isNotEmpty) ...[
                pw.SizedBox(height: 8),
                pw.Text(
                  shopDetails.address,
                  style: pw.TextStyle(font: font, fontSize: 12),
                ),
              ],
              if (shopDetails.phone.isNotEmpty) ...[
                pw.SizedBox(height: 4),
                pw.Text(
                  'Phone: ${shopDetails.phone}',
                  style: pw.TextStyle(font: font, fontSize: 12),
                ),
              ],
              if (shopDetails.email?.isNotEmpty == true) ...[
                pw.SizedBox(height: 4),
                pw.Text(
                  'Email: ${shopDetails.email}',
                  style: pw.TextStyle(font: font, fontSize: 12),
                ),
              ],
            ],
          ),
        ),
        if (logoProvider != null)
          pw.Container(
            width: 80,
            height: 80,
            child: pw.Image(logoProvider),
          ),
      ],
    );
  }

  static pw.Widget _buildAvailabilityInfo(String availabilityDate, pw.Font font) {
    return pw.Container(
      padding: const pw.EdgeInsets.all(16),
      decoration: pw.BoxDecoration(
        border: pw.Border.all(color: PdfColors.grey300),
        borderRadius: pw.BorderRadius.circular(8),
      ),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.center,
        children: [
          pw.Text(
            'Available Products Report',
            style: pw.TextStyle(
              font: font,
              fontSize: 18,
              fontWeight: pw.FontWeight.bold,
            ),
          ),
          pw.SizedBox(height: 8),
          pw.Text(
            'Availability Date: ${DateFormat('dd/MM/yyyy').format(DateTime.parse(availabilityDate))}',
            style: pw.TextStyle(font: font, fontSize: 14),
          ),
          pw.Text(
            'Generated on: ${DateFormat('dd/MM/yyyy HH:mm').format(DateTime.now())}',
            style: pw.TextStyle(font: font, fontSize: 12, color: PdfColors.grey600),
          ),
        ],
      ),
    );
  }

  static pw.Widget _buildProductsTable(List<ProductModel> products, pw.Font font) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          'Available Products (${products.length})',
          style: pw.TextStyle(
            font: font,
            fontSize: 16,
            fontWeight: pw.FontWeight.bold,
          ),
        ),
        pw.SizedBox(height: 12),
        pw.Table(
          border: pw.TableBorder.all(color: PdfColors.grey400),
          columnWidths: {
            0: const pw.FlexColumnWidth(1),
            1: const pw.FlexColumnWidth(3),
            2: const pw.FlexColumnWidth(2),
            3: const pw.FlexColumnWidth(1.5),
          },
          children: [
            // Header row
            pw.TableRow(
              decoration: const pw.BoxDecoration(color: PdfColors.grey200),
              children: [
                _buildTableCell('S.No', font, isHeader: true),
                _buildTableCell('Product Name', font, isHeader: true),
                _buildTableCell('Category', font, isHeader: true),
                _buildTableCell('Price', font, isHeader: true),
              ],
            ),
            // Data rows
            ...products.asMap().entries.map((entry) {
              final index = entry.key;
              final product = entry.value;
              return pw.TableRow(
                children: [
                  _buildTableCell('${index + 1}', font),
                  _buildTableCell(product.name, font),
                  _buildTableCell(product.category ?? 'N/A', font),
                  _buildTableCell('₹${product.price?.toStringAsFixed(2) ?? 'N/A'}', font),
                ],
              );
            }).toList(),
          ],
        ),
      ],
    );
  }

  static pw.Widget _buildTableCell(String text, pw.Font font, {bool isHeader = false}) {
    return pw.Container(
      padding: const pw.EdgeInsets.all(8),
      child: pw.Text(
        text,
        style: pw.TextStyle(
          font: font,
          fontSize: isHeader ? 12 : 10,
          fontWeight: isHeader ? pw.FontWeight.bold : pw.FontWeight.normal,
        ),
      ),
    );
  }

  static pw.Widget _buildFooter(pw.Font font) {
    return pw.Column(
      children: [
        pw.Divider(color: PdfColors.grey400),
        pw.SizedBox(height: 10),
        pw.Text(
          'This is a system-generated report',
          style: pw.TextStyle(
            font: font,
            fontSize: 10,
            color: PdfColors.grey600,
            fontStyle: pw.FontStyle.italic,
          ),
        ),
      ],
    );
  }
}