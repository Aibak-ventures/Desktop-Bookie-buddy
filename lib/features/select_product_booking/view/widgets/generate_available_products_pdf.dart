import 'dart:developer';
import 'dart:io';

import 'package:bookie_buddy_web/core/constants/app_assets.dart';
import 'package:bookie_buddy_web/core/extensions/context_extensions.dart';
import 'package:bookie_buddy_web/core/models/product_model/product_model.dart';
import 'package:bookie_buddy_web/core/models/user_shop_model/user_shop_model.dart';
import 'package:bookie_buddy_web/core/ui/widgets/global_loading_overlay.dart';
import 'package:bookie_buddy_web/core/utils/download_file.dart';
import 'package:bookie_buddy_web/utils/get_pdf_image_provider.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:share_plus/share_plus.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class GenerateAvailableProductsPdf {
  static Future<void> shareInvoice({
    required BuildContext context,
    required List<ProductModel> products,
    required UserShopModel shopDetails,
    required String availabilityDate,
  }) async {
    try {
      GlobalLoadingOverlay.show(context, text: 'Generating PDF...');
      final pdf = await generateAvailableProductsPdf(
          products, shopDetails, availabilityDate);

      GlobalLoadingOverlay.hide();

      final fileName =
          'available_products_${DateTime.now().millisecondsSinceEpoch}.pdf';

      if (kIsWeb) {
        // On web, trigger browser download
        downloadFileWeb(pdf, fileName);

        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('PDF downloaded successfully'),
              backgroundColor: Colors.green,
            ),
          );
        }
      } else if (Platform.isWindows) {
        // For Windows desktop, save to Downloads folder and open
        final downloadsDir =
            Directory('${Platform.environment['USERPROFILE']}\\Downloads');
        if (!downloadsDir.existsSync()) {
          downloadsDir.createSync(recursive: true);
        }

        final filePath = '${downloadsDir.path}\\$fileName';
        final file = File(filePath);
        await file.writeAsBytes(pdf);

        log('PDF saved to: $filePath');

        // Open the PDF with default viewer
        try {
          await launchUrl(Uri.file(filePath));
        } catch (e) {
          log('Could not open PDF: $e');
        }

        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('PDF saved to Downloads\\$fileName'),
              backgroundColor: Colors.green,
              action: SnackBarAction(
                label: 'Open Folder',
                textColor: Colors.white,
                onPressed: () async {
                  try {
                    await launchUrl(Uri.file(downloadsDir.path));
                  } catch (e) {
                    log('Could not open folder: $e');
                  }
                },
              ),
            ),
          );
        }
      } else {
        // For mobile, save to temp and share
        final output = await getApplicationDocumentsDirectory();
        final box =
            context.isMobile ? null : context.findRenderObject() as RenderBox?;

        final file = File('${output.path}/$fileName');
        await file.writeAsBytes(pdf);
        final fileNameShort = file.path.split('/').last;

        await SharePlus.instance.share(
          ShareParams(
            title: fileNameShort,
            subject: fileNameShort,
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
      }
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

    // Load fonts
    final fontRegular = await rootBundle.load(AppAssets.interRegularFont);
    final fontSemiBold = await rootBundle.load(AppAssets.interSemiBoldFont);
    final ttfRegular = pw.Font.ttf(fontRegular);
    final ttfSemiBold = pw.Font.ttf(fontSemiBold);

    // Load the SVG header graphic for availability
    final headerSvg = await rootBundle.loadString(
      AppAssets.availabilityPdfLayoutHeaderSvg,
    );
    final footerSvg = await rootBundle.loadString(
      AppAssets.bookingPdfLayoutFooterSvg,
    );

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
        pageTheme: pw.PageTheme(
          margin: const pw.EdgeInsets.fromLTRB(24, 60, 24, 40),
          buildBackground: (context) {
            if (context.pageNumber == 1) {
              return pw.FullPage(
                ignoreMargins: true,
                child: pw.Column(
                  children: [
                    pw.SvgImage(
                      svg: headerSvg,
                      fit: pw.BoxFit.cover,
                      alignment: pw.Alignment.topCenter,
                    ),
                    pw.Spacer(),
                    pw.SvgImage(
                      svg: footerSvg,
                      alignment: pw.Alignment.bottomCenter,
                    ),
                  ],
                ),
              );
            }
            return pw.FullPage(
              ignoreMargins: true,
              child: pw.SvgImage(
                svg: footerSvg,
                alignment: pw.Alignment.bottomCenter,
              ),
            );
          },
        ),
        build: (pw.Context context) => [
          _buildHeader(shopDetails, logoProvider, ttfRegular, ttfSemiBold),
          pw.SizedBox(height: 20),
          _buildAvailabilityInfo(availabilityDate, ttfRegular, ttfSemiBold),
          pw.SizedBox(height: 20),
          _buildProductsTable(products, ttfRegular, ttfSemiBold),
          pw.SizedBox(height: 30),
          _buildFooter(ttfRegular),
        ],
      ),
    );

    return pdf.save();
  }

  static pw.Widget _buildHeader(
    UserShopModel shopDetails,
    pw.ImageProvider? logoProvider,
    pw.Font fontRegular,
    pw.Font fontSemiBold,
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
                  font: fontSemiBold,
                  fontSize: 24,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              if (shopDetails.address.isNotEmpty) ...[
                pw.SizedBox(height: 8),
                pw.Text(
                  shopDetails.address,
                  style: pw.TextStyle(font: fontRegular, fontSize: 12),
                ),
              ],
              if (shopDetails.phone.isNotEmpty) ...[
                pw.SizedBox(height: 4),
                pw.Text(
                  'Phone: ${shopDetails.phone}',
                  style: pw.TextStyle(font: fontRegular, fontSize: 12),
                ),
              ],
              if (shopDetails.email?.isNotEmpty == true) ...[
                pw.SizedBox(height: 4),
                pw.Text(
                  'Email: ${shopDetails.email}',
                  style: pw.TextStyle(font: fontRegular, fontSize: 12),
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

  static pw.Widget _buildAvailabilityInfo(
    String availabilityDate,
    pw.Font fontRegular,
    pw.Font fontSemiBold,
  ) {
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
              font: fontSemiBold,
              fontSize: 18,
              fontWeight: pw.FontWeight.bold,
            ),
          ),
          pw.SizedBox(height: 8),
          pw.Text(
            'Availability Date: ${DateFormat('dd/MM/yyyy').format(DateTime.parse(availabilityDate))}',
            style: pw.TextStyle(font: fontRegular, fontSize: 14),
          ),
          pw.Text(
            'Generated on: ${DateFormat('dd/MM/yyyy HH:mm').format(DateTime.now())}',
            style: pw.TextStyle(
                font: fontRegular, fontSize: 12, color: PdfColors.grey600),
          ),
        ],
      ),
    );
  }

  static pw.Widget _buildProductsTable(
    List<ProductModel> products,
    pw.Font fontRegular,
    pw.Font fontSemiBold,
  ) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          'Available Products (${products.length})',
          style: pw.TextStyle(
            font: fontSemiBold,
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
                _buildTableCell('S.No', fontRegular, fontSemiBold,
                    isHeader: true),
                _buildTableCell('Product Name', fontRegular, fontSemiBold,
                    isHeader: true),
                _buildTableCell('Category', fontRegular, fontSemiBold,
                    isHeader: true),
                _buildTableCell('Price', fontRegular, fontSemiBold,
                    isHeader: true),
              ],
            ),
            // Data rows
            ...products.asMap().entries.map((entry) {
              final index = entry.key;
              final product = entry.value;
              return pw.TableRow(
                children: [
                  _buildTableCell('${index + 1}', fontRegular, fontSemiBold),
                  _buildTableCell(product.name, fontRegular, fontSemiBold),
                  _buildTableCell(
                      product.category ?? 'N/A', fontRegular, fontSemiBold),
                  _buildTableCell(
                      '₹${product.price?.toStringAsFixed(2) ?? 'N/A'}',
                      fontRegular,
                      fontSemiBold),
                ],
              );
            }).toList(),
          ],
        ),
      ],
    );
  }

  static pw.Widget _buildTableCell(
      String text, pw.Font fontRegular, pw.Font fontSemiBold,
      {bool isHeader = false}) {
    return pw.Container(
      padding: const pw.EdgeInsets.all(8),
      child: pw.Text(
        text,
        style: pw.TextStyle(
          font: isHeader ? fontSemiBold : fontRegular,
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
