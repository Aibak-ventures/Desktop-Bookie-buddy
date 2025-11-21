import 'dart:developer';
import 'dart:io';

import 'package:bookie_buddy_web/core/constants/app_assets.dart';
import 'package:bookie_buddy_web/core/enums/service_type_enums.dart';
import 'package:bookie_buddy_web/core/extensions/number_extensions.dart';
import 'package:bookie_buddy_web/core/extensions/string_extensions.dart';
import 'package:bookie_buddy_web/core/models/booking_details_model/booking_details_model.dart';
import 'package:bookie_buddy_web/core/models/product_info_model/product_info_model.dart';
import 'package:bookie_buddy_web/core/models/user_shop_model/user_shop_model.dart';
import 'package:bookie_buddy_web/core/ui/widgets/global_loading_overlay.dart';
import 'package:bookie_buddy_web/core/utils/download_file.dart';
import 'package:bookie_buddy_web/core/utils/share_file.dart';
import 'package:bookie_buddy_web/utils/get_pdf_image_provider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:url_launcher/url_launcher.dart';

class GenerateBookingPdf {
  static Future<void> shareInvoice({
    required BuildContext context,
    required BookingDetailsModel bookingDetails,
    required UserShopModel shopDetails,
  }) async {
    try {
      GlobalLoadingOverlay.show(context, text: 'Generating PDF...');

      // Generate PDF locally instead of downloading from server
      final pdfBytes = await generateInvoice(bookingDetails, shopDetails);

      GlobalLoadingOverlay.hide();

      if (kIsWeb) {
        // On web, trigger browser download
        final fileName = 'invoice_${bookingDetails.invoiceId}.pdf';
        downloadFileWeb(pdfBytes, fileName);

        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Invoice downloaded successfully'),
              backgroundColor: Colors.green,
            ),
          );
        }
      } else {
        // On mobile/desktop, save to file
        final fileName = 'invoice_${bookingDetails.invoiceId}.pdf';

        // For Windows desktop, save to Downloads folder and open
        if (Platform.isWindows) {
          // Get Downloads folder path
          final downloadsDir =
              Directory('${Platform.environment['USERPROFILE']}\\Downloads');
          if (!downloadsDir.existsSync()) {
            downloadsDir.createSync(recursive: true);
          }

          final filePath = '${downloadsDir.path}\\$fileName';
          final file = File(filePath);
          await file.writeAsBytes(pdfBytes);

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
                content: Text('Invoice saved to Downloads\\$fileName'),
                backgroundColor: Colors.green,
                action: SnackBarAction(
                  label: 'Open Folder',
                  textColor: Colors.white,
                  onPressed: () async {
                    try {
                      // Open Downloads folder
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
          // For mobile, use the share functionality
          final dir = await getTemporaryDirectory();
          final filePath = '${dir.path}/$fileName';
          final file = File(filePath);
          await file.writeAsBytes(pdfBytes);
          await shareFile(context: context, filePath: filePath);
        }
      }
    } catch (e, stack) {
      log('Error sharing invoice: $e', stackTrace: stack);
      rethrow;
    } finally {
      GlobalLoadingOverlay.hide();
    }
  }

  static Future<void> printInvoice({
    required BuildContext context,
    required BookingDetailsModel bookingDetails,
    required UserShopModel shopDetails,
  }) async {
    try {
      GlobalLoadingOverlay.show(context, text: 'Generating PDF for print...');

      // For web, we'll use the share functionality
      // You could also implement a web-specific print dialog here
      await shareInvoice(
        context: context,
        bookingDetails: bookingDetails,
        shopDetails: shopDetails,
      );
    } catch (e, stack) {
      log('Error printing invoice: $e', stackTrace: stack);
      rethrow;
    } finally {
      GlobalLoadingOverlay.hide();
    }
  }

  // Cached unknown product image (lazy)
  static pw.ImageProvider? _cachedUnknownImage;
  static pw.ImageProvider get _unknownProductImage => _cachedUnknownImage ??=
      pw.MemoryImage(File(AppAssets.unknownProduct).readAsBytesSync());

  // Common text styles
  static final pw.TextStyle _boldStyle = pw.TextStyle(
    fontWeight: pw.FontWeight.bold,
  );

  static final pw.TextStyle _sectionTitleStyle = pw.TextStyle(
    fontWeight: pw.FontWeight.bold,
    color: _customColor,
    fontSize: 14,
    letterSpacing: _letterSpacing,
  );

  static const double _letterSpacing = 0.5;

  static final _pdfGreyColor = PdfColor.fromHex('D9D9D9');

  // static late pw.Font _baseFont;
  static final _customColor = const PdfColor.fromInt(0xFF6C5CE7);

  static Future<Uint8List> generateInvoice(
    BookingDetailsModel bookingDetails,
    UserShopModel shopDetails,
  ) async {
    // Font loading logic
    final fontRegular = await rootBundle.load(AppAssets.interRegularFont);
    final fontSemiBold = await rootBundle.load(AppAssets.interSemiBoldFont);
    final fontExtraBold = await rootBundle.load(AppAssets.interExtraBoldFont);
    final fontMalayalam = await rootBundle.load(
      AppAssets.notoSansMalayalamFont,
    );
    final ttfRegular = pw.Font.ttf(fontRegular);
    final ttfMedium = pw.Font.ttf(fontSemiBold);
    final ttfExtraBold = pw.Font.ttf(fontExtraBold);
    final ttfMalayalam = pw.Font.ttf(fontMalayalam);

    // Load the SVG header graphic
    final headerSvg = await rootBundle.loadString(
      AppAssets.bookingPdfLayoutHeaderSvg,
    );
    final footerSvg = await rootBundle.loadString(
      AppAssets.bookingPdfLayoutFooterSvg,
    );

    final pdf = pw.Document(
      creator: 'Bookie Buddy',
      author: 'AFNAN P',
      theme: pw.ThemeData.withFont(
        base: ttfRegular,
        bold: ttfMedium,
        fontFallback: [ttfMalayalam],
      ),
    );

    final dio = Dio();
    final businessImage = await getPdfImageProvider(
      imagePath: shopDetails.image,
      isAsset: false,
      dio: dio,
    );
    final productImages = await Future.wait<pw.ImageProvider>(
      bookingDetails.bookedItems
          .map(
            (product) async => getPdfImageProvider(
              imagePath: product.image,
              isAsset: product.image == null,
              dio: dio,
            ),
          )
          .toList(),
    );

    pdf.addPage(
      pw.MultiPage(
        // Page theme with background SVG used as header background
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
        // Footer for every page
        footer: (context) => context.pagesCount == context.pageNumber
            ? _buildTermsAndConditions(shopDetails.termsAndConditions)
            : pw.SizedBox.shrink(),

        build: (context) => [
          _buildShopDetails(
            businessImage,
            shopDetails.name,
            shopDetails.phone,
            shopDetails.phone2,
            shopDetails.fullAddress,
            ttfExtraBold,
          ),
          pw.SizedBox(height: 30),
          _buildInvoiceDetails(bookingDetails),
          pw.SizedBox(height: 20),
          _buildItemsTable(bookingDetails, productImages),
          pw.SizedBox(height: 30),
          _buildSummaryAndTerms(bookingDetails, ttfExtraBold),
        ],
      ),
    );

    return pdf.save();
  }

  // Shop details
  static pw.Row _buildShopDetails(
    pw.ImageProvider shopImage,
    String shopName,
    String shopPhone,
    String? shopPhone2,
    String shopAddress,
    pw.Font fontBold,
  ) =>
      pw.Row(
        children: [
          pw.Image(shopImage, width: 60, height: 60),
          pw.SizedBox(width: 12),
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                shopName,
                style: pw.TextStyle(
                  fontWeight: pw.FontWeight.bold,
                  color: _customColor,
                  fontSize: 16,
                  fontBold: fontBold,
                ),
              ),
              pw.Text(shopPhone),
              if (shopPhone2.isNotNullOrEmpty) pw.Text(shopPhone2!),
              ...shopAddress.splitByWords(4).map(pw.Text.new),
            ],
          ),
        ],
      );

  // Invoice details
  static pw.Widget _buildInvoiceDetails(BookingDetailsModel bookingDetails) {
    pw.RichText text(String text, String secondText) => pw.RichText(
          text: pw.TextSpan(
            text: text,
            children: [
              pw.TextSpan(
                text: secondText,
                style: const pw.TextStyle(color: PdfColors.grey500),
              ),
            ],
            style: pw.TextStyle(
              fontWeight: pw.FontWeight.bold,
              color: PdfColors.grey800,
              letterSpacing: _letterSpacing,
            ),
          ),
        );

    return pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      children: [
        pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            text('INVOICE NO: ', bookingDetails.invoiceId),
            pw.SizedBox(height: 4),
            text('DATE: ', bookingDetails.bookedDate.formatToUiDate()),
          ],
        ),
        _buildClientBlock(bookingDetails),
      ],
    );
  }

  // Client block
  static pw.Widget _buildClientBlock(BookingDetailsModel bookingDetails) {
    final client = bookingDetails.client;
    final clientAddress = bookingDetails.address;
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.end,
      children: [
        pw.Text('BILL TO', style: _sectionTitleStyle),
        pw.SizedBox(height: 4),
        pw.Text(client.name, style: _boldStyle.copyWith(fontSize: 14)),
        if (client.phone1 != 0) pw.Text(client.phone1.toString()),
        if ((clientAddress ?? '').isNotEmpty)
          ...clientAddress!.splitByWords().map(
                (line) =>
                    pw.Text(line, style: const pw.TextStyle(lineSpacing: 2)),
              ),
      ],
    );
  }

  /// Splits a string into chunks of a specific length.

  // Product items table
  static pw.Widget _buildItemsTable(
    BookingDetailsModel bookingDetails,
    List<pw.ImageProvider> productImages,
  ) {
    pw.Text tableHeadingText(
      String text, {
      pw.TextAlign textAlign = pw.TextAlign.left,
    }) =>
        pw.Text(
          text,
          style: pw.TextStyle(
            fontWeight: pw.FontWeight.bold,
            color: PdfColors.black,
            letterSpacing: _letterSpacing,
          ),
          textAlign: textAlign,
        );

    return pw.Container(
      decoration: pw.BoxDecoration(border: pw.Border.all(color: _pdfGreyColor)),
      child: pw.Column(
        children: [
          // Table header
          pw.Container(
            padding: const pw.EdgeInsets.all(12),
            decoration: pw.BoxDecoration(color: _pdfGreyColor),
            child: pw.Row(
              children: [
                pw.Expanded(child: tableHeadingText('NO')),
                pw.Expanded(flex: 5, child: tableHeadingText('ITEM NAME')),
                pw.Expanded(
                  child: tableHeadingText(
                    'QTY',
                    textAlign: pw.TextAlign.center,
                  ),
                ),
                pw.Expanded(
                  flex: 2,
                  child: tableHeadingText(
                    'AMOUNT',
                    textAlign: pw.TextAlign.right,
                  ),
                ),
              ],
            ),
          ),
          // products rows
          if (bookingDetails.bookedItems.isNotEmpty)
            ...List.generate(bookingDetails.bookedItems.length, (index) {
              final product = bookingDetails.bookedItems[index];
              final productImage = index < productImages.length
                  ? productImages[index]
                  : _unknownProductImage;
              return pw.Container(
                padding: const pw.EdgeInsets.all(12),
                decoration: pw.BoxDecoration(
                  color: index % 2 == 0 ? PdfColors.white : PdfColors.grey50,
                ),
                child: pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.center,
                  children: [
                    pw.Expanded(child: pw.Text((index + 1).toString())),
                    pw.Expanded(
                      flex: 5,
                      child: _itemBuilder(productImage, product),
                    ),
                    pw.Expanded(
                      child: pw.Text(
                        product.quantity.toString(),
                        textAlign: pw.TextAlign.center,
                      ),
                    ),
                    pw.Expanded(
                      flex: 2,
                      child: pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.end,
                        crossAxisAlignment: pw.CrossAxisAlignment.end,
                        children: [
                          pw.Center(
                            child: pw.Text(
                              product.amount.toCurrency(),
                              style: pw.TextStyle(
                                fontWeight: pw.FontWeight.bold,
                              ),
                              textAlign: pw.TextAlign.right,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }),
        ],
      ),
    );
  }

  static pw.Row _itemBuilder(
    pw.ImageProvider productImage,
    ProductInfoModel product,
  ) {
    final mainServiceType = product.mainServiceType;
    const textStyle = const pw.TextStyle(
      fontSize: 12,
      color: PdfColors.grey600,
    );
    return pw.Row(
      children: [
        pw.ClipRRect(
          horizontalRadius: 5,
          verticalRadius: 5,
          child: pw.Image(
            productImage,
            width: 50,
            height: 50,
            fit: pw.BoxFit.cover,
          ),
        ),
        pw.SizedBox(width: 10),
        pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text(
              product.name,
              style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
            ),
            if (mainServiceType.isDress)
              pw.Text(
                'Size: ${product.variantAttribute ?? '-'}',
                style: textStyle,
              ),
            if (mainServiceType.isDress || mainServiceType.isOthers)
              pw.Text('Color: ${product.color ?? '-'}', style: textStyle),
            if (mainServiceType.isVehicle)
              pw.Text('Model: ${product.model ?? '-'}', style: textStyle),
            if (mainServiceType.isVehicle ||
                mainServiceType.isOthers ||
                mainServiceType.isEquipment)
              pw.Text(
                '${mainServiceType.isVehicle ? 'Brand' : 'Category'} : ${product.category ?? '-'}',
                style: textStyle,
              ),
          ],
        ),
      ],
    );
  }

  /// Builds the summary and terms section of the PDF.
  static pw.Widget _buildSummaryAndTerms(
    BookingDetailsModel bookingDetails,
    pw.Font? fontBold,
  ) {
    final locationStart = bookingDetails.otherDetails.locationStart ?? '';
    final locationFrom = bookingDetails.otherDetails.locationFrom ?? '';
    final locationTo = bookingDetails.otherDetails.locationTo ?? '';
    const double lineSpacing = 3;
    return pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      children: [
        // Left side: Booking info
        pw.Expanded(
          flex: 2,
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.RichText(
                text: pw.TextSpan(
                  text: 'BOOKING ',
                  children: const [
                    pw.TextSpan(
                      text: 'INFO:',
                      style: pw.TextStyle(color: PdfColors.black),
                    ),
                  ],
                  style: pw.TextStyle(
                    fontWeight: pw.FontWeight.bold,
                    color: _customColor,
                    letterSpacing: _letterSpacing,
                  ),
                ),
              ),
              pw.SizedBox(height: 4),
              if (bookingDetails.pickupDate != null) ...[
                pw.Text(
                  'Pickup : ${bookingDetails.pickupDate!.formatToUiDate()}, ${bookingDetails.pickupDate!.formatToUiTime()}',
                ),
                pw.SizedBox(height: lineSpacing),
              ],
              pw.Text(
                'Return : ${bookingDetails.returnDate.formatToUiDate()}, ${bookingDetails.returnDate.formatToUiTime()}',
              ),
              pw.SizedBox(height: lineSpacing),
              if (bookingDetails.bookedItems.isNotEmpty &&
                  bookingDetails
                      .bookedItems.first.mainServiceType.isVehicle) ...[
                if (locationStart.isNotEmpty)
                  pw.Padding(
                    padding: const pw.EdgeInsets.only(bottom: lineSpacing),
                    child: pw.Text(
                      'Start Location: ${locationStart.isNotEmpty ? locationStart : 'Not available'}',
                      textAlign: pw.TextAlign.end,
                    ),
                  ),
                if (locationFrom.isNotEmpty)
                  pw.Padding(
                    padding: const pw.EdgeInsets.only(bottom: lineSpacing),
                    child: pw.Text(
                      'Pickup Location: ${locationFrom.isNotEmpty ? locationFrom : 'Not available'}',
                      textAlign: pw.TextAlign.end,
                    ),
                  ),
                if (locationTo.isNotEmpty)
                  pw.Padding(
                    padding: const pw.EdgeInsets.only(bottom: lineSpacing),
                    child: pw.Text(
                      'Destination: ${locationTo.isNotEmpty ? locationTo : 'Not available'}',
                      textAlign: pw.TextAlign.end,
                    ),
                  ),
              ],
              // pw.SizedBox(height: 20),
              // _buildTermsAndConditions(termsAndConditions),
            ],
          ),
        ),
        // Right side: Totals and Signature
        pw.Expanded(
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.end,
            children: [
              if ((bookingDetails.securityAmount ?? 0) > 0)
                _buildTotalRow(
                  'SECURITY AMOUNT',
                  bookingDetails.securityAmount!.toCurrency(),
                ),
              if (bookingDetails.additionalCharges.isNotEmpty)
                ...bookingDetails.additionalCharges.map(
                  (e) => _buildTotalRow(
                    e.name?.toUpperCase() ?? '-----',
                    e.amount?.toCurrency() ?? '0',
                  ),
                ),
              if ((bookingDetails.discountAmount ?? 0) > 0)
                _buildTotalRow(
                  'DISCOUNT TOTAL',
                  bookingDetails.discountAmount!.toCurrency(),
                ),
              _buildTotalRow(
                'PAID AMOUNT',
                bookingDetails.paidAmount.toCurrency(),
                fontBold: fontBold,
              ),
              pw.Divider(),
              _buildTotalRow(
                'GRAND TOTAL',
                bookingDetails.totalAmount.toCurrency(),
                fontBold: fontBold,
              ),
              if (bookingDetails.totalAmount > bookingDetails.paidAmount)
                pw.Padding(
                  padding: const pw.EdgeInsets.only(top: 6),
                  child: _buildTotalRow(
                    'BALANCE DUE',
                    isBalanceDue: true,
                    (bookingDetails.totalAmount -
                            (bookingDetails.paidAmount +
                                (bookingDetails.discountAmount ?? 0)))
                        .toCurrency(),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }

  static pw.Widget _buildTotalRow(
    String title,
    String value, {
    pw.Font? fontBold,
    bool isBalanceDue = false,
  }) {
    final styleTitle = pw.TextStyle(
      fontWeight: isBalanceDue || fontBold != null
          ? pw.FontWeight.bold
          : pw.FontWeight.normal,
      color: isBalanceDue ? PdfColors.red : _customColor,
      letterSpacing: _letterSpacing,
      fontBold: fontBold,
    );

    final styleAmount = pw.TextStyle(
      fontWeight: pw.FontWeight.bold,
      letterSpacing: _letterSpacing,
      color: isBalanceDue ? PdfColors.red : PdfColors.black,
    );
    return pw.Padding(
      padding: const pw.EdgeInsets.symmetric(vertical: 2),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Expanded(
            child: pw.Text(
              title,
              style: styleTitle,
              textAlign: pw.TextAlign.start,
            ),
          ),
          pw.Text(value, style: styleAmount, textAlign: pw.TextAlign.end),
        ],
      ),
    );
  }

  // Terms and conditions
  static pw.Widget _buildTermsAndConditions(List<String> termsAndConditions) =>
      pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.RichText(
            text: pw.TextSpan(
              text: 'TERMS AND ',
              children: [
                pw.TextSpan(
                  text: 'CONDITIONS',
                  style: pw.TextStyle(color: _customColor),
                ),
              ],
              style: pw.TextStyle(
                fontWeight: pw.FontWeight.bold,
                color: PdfColors.black,
                letterSpacing: _letterSpacing,
              ),
            ),
          ),
          pw.SizedBox(height: 4),
          ..._generateTermsAndConditions(termsAndConditions),
        ],
      );

  static Iterable<pw.Padding> _generateTermsAndConditions(
    List<String> termsAndConditions,
  ) =>
      termsAndConditions.map(
        (e) => pw.Padding(
          padding: const pw.EdgeInsets.only(bottom: 3),
          child: pw.Text(
            '- $e',
            style: const pw.TextStyle(fontSize: 10, color: PdfColors.grey600),
          ),
        ),
      );
}
