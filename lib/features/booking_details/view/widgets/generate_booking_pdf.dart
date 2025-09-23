import 'dart:developer';
import 'dart:io';

import 'package:bookie_buddy_web/core/app_icons.dart';
import 'package:bookie_buddy_web/core/enums/enums.dart';
import 'package:bookie_buddy_web/core/extensions/context_extensions.dart';
import 'package:bookie_buddy_web/core/extensions/number_extensions.dart';
import 'package:bookie_buddy_web/core/extensions/string_extensions.dart';
import 'package:bookie_buddy_web/core/models/booking_details_model/booking_details_model.dart';
import 'package:bookie_buddy_web/core/ui/widgets/global_loading_overlay.dart';
import 'package:bookie_buddy_web/utils/get_pdf_image_provider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:share_plus/share_plus.dart';

class GenerateBookingPdf {
  static late pw.Font _baseFont;
  static final customColor = const PdfColor.fromInt(0xFF6C5CE7);
  static Future<pw.Font?> _loadFont([bool isFallback = false]) async {
    if (!isFallback) {
      final fontData = await rootBundle.load(
        'assets/fonts/NotoSansMalayalam.ttf',
      );
      _baseFont = pw.Font.ttf(fontData);
    } else {
      return pw.Font.ttf(
        await rootBundle.load(
          'assets/fonts/Poppins-Regular.ttf',
        ),
      );
    }
    return null;
  }

  // Main function to generate and save PDF using BookingDetailsModel
  static Future<String> generateBookingInvoice(
    BookingDetailsModel bookingDetails,
    String businessImageUrl,
    String businessName,
    String businessPhone,
    String businessLocation,
    List<String> termsAndConditions,
  ) async {
    await _loadFont();
    final pdf = pw.Document(
      theme: pw.ThemeData.withFont(
          base: _baseFont,
          bold: _baseFont,
          italic: _baseFont,
          boldItalic: _baseFont,
          fontFallback: [
            await _loadFont(true) ?? _baseFont,
          ]),
    );
    final dio = Dio();
    final businessImage = await getPdfImageProvider(
      imagePath: businessImageUrl,
      isAsset: false,
      dio: dio,
    );
    final productImages = await Future.wait<pw.ImageProvider>(
      bookingDetails.bookedItems.map((product) async {
        return await getPdfImageProvider(
          imagePath: product.image,
          isAsset: product.image != null ? false : true,
          dio: dio,
        );
      }).toList(),
    );

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.symmetric(
          horizontal: 40,
          vertical: 30,
        ),
        build: (pw.Context context) {
          return [
            _buildHeader(
              businessImage,
              businessName,
              businessPhone,
              businessLocation,
            ),
            pw.SizedBox(height: 10),
            _buildBillToAndBookingInfo(bookingDetails),
            pw.SizedBox(height: 15),
            _buildItemsTable(
              bookingDetails,
              productImages,
            ),
            pw.SizedBox(height: 20),
            _buildTotalSection(bookingDetails),
            pw.SizedBox(height: 30),
            _buildTermsAndConditions(termsAndConditions),
          ];
        },
        footer: (pw.Context context) {
          return pw.Align(
            alignment: pw.Alignment.centerRight,
            child: pw.Text(
              'Powered by www.bookiebuddy.in',
              style: const pw.TextStyle(
                fontSize: 10,
                color: PdfColors.grey600,
              ),
            ),
          );
        },
      ),
    );

    // Save PDF to device
    final output = await getApplicationDocumentsDirectory();
    final file = File('${output.path}/invoice_${bookingDetails.invoiceId}.pdf');
    await file.writeAsBytes(await pdf.save());

    return file.path;
  }

  // Share PDF function
  static Future<void> shareInvoice({
    required BuildContext context,
    required BookingDetailsModel bookingDetails,
    required String businessImageUrl,
    required String businessName,
    required String businessPhone,
    required String businessLocation,
    required List<String> termsAndConditions,
  }) async {
    GlobalLoadingOverlay.show(
      context,
      text: 'Generating invoice...',
    );
    try {
      final filePath = await generateBookingInvoice(
        bookingDetails,
        businessImageUrl,
        businessName,
        businessPhone,
        businessLocation,
        termsAndConditions,
      );
      GlobalLoadingOverlay.hide();
      final box =
          context.isMobile ? null : context.findRenderObject() as RenderBox?;
      await Share.shareXFiles(
        [XFile(filePath)],
        subject: 'invoice_${bookingDetails.invoiceId}',
        sharePositionOrigin:
            box == null ? null : box.localToGlobal(Offset.zero) & box.size,
      );
    } catch (e, stack) {
      GlobalLoadingOverlay.hide();
      log('Error generating invoice: $e', stackTrace: stack);
      rethrow;
    }
  }

  //=======================================
  // Helper functions to build PDF sections
  //=======================================

  // Header section with business info
  static pw.Widget _buildHeader(
    pw.ImageProvider businessImage,
    String businessName,
    String businessPhone,
    String businessLocation,
  ) {
    return pw.Container(
      width: double.infinity,
      child: pw.Column(
        children: [
          // Purple decorative bars and title
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Expanded(
                child: pw.Container(
                  height: 8,
                  color: customColor,
                ),
              ),
              pw.Padding(
                padding: const pw.EdgeInsets.symmetric(horizontal: 24),
                child: pw.Text(
                  'Invoice',
                  style: pw.TextStyle(
                    fontSize: 32,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              ),
              pw.Expanded(
                child: pw.Container(
                  height: 8,
                  color: customColor,
                ),
              )
            ],
          ),
          pw.SizedBox(height: 25),

          // Business info row
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            crossAxisAlignment: pw.CrossAxisAlignment.center,
            children: [
              // Business logo section

              pw.Image(
                businessImage,
                width: 100,
                height: 100,
              ),

              // Business contact info
              pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.end,
                children: [
                  pw.Text(
                    businessName,
                    style: pw.TextStyle(
                      fontSize: 14,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                  pw.Text(
                    businessPhone,
                    style: pw.TextStyle(
                      fontSize: 14,
                      color: customColor,
                    ),
                  ),
                  pw.Text(
                    businessLocation,
                    style: const pw.TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  static pw.TextStyle _textStyleSizeSubHead() {
    return const pw.TextStyle(
      fontSize: 12,
    );
  }

  // Bill To and Booking Info section
  static pw.Widget _buildBillToAndBookingInfo(
      BookingDetailsModel bookingDetails) {
    final locationStart =
        bookingDetails.otherDetails['location_start'] as String? ?? '';
    final locationFrom =
        bookingDetails.otherDetails['location_from'] as String? ?? '';
    final locationTo =
        bookingDetails.otherDetails['location_to'] as String? ?? '';
    return pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      crossAxisAlignment: pw.CrossAxisAlignment.center,
      children: [
        // Bill To section
        pw.Expanded(
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Container(
                padding: const pw.EdgeInsets.only(bottom: 5),
                decoration: pw.BoxDecoration(
                  border: pw.Border(
                    bottom: pw.BorderSide(color: customColor, width: 2),
                  ),
                ),
                child: pw.Text(
                  'Bill to',
                  style: pw.TextStyle(
                    fontSize: 14,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              ),
              pw.SizedBox(height: 10),
              pw.Text(
                bookingDetails.client.name,
                style: _textStyleSizeSubHead(),
              ),
              if (bookingDetails.address != null &&
                  bookingDetails.address!.isNotEmpty)
                pw.Text(
                  bookingDetails.address!,
                  style: _textStyleSizeSubHead(),
                ),
              pw.Text(
                bookingDetails.client.phone1.toString(),
                style: _textStyleSizeSubHead(),
              ),
            ],
          ),
        ),

        // Booking Info section
        pw.Expanded(
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.end,
            children: [
              pw.Container(
                padding: const pw.EdgeInsets.only(bottom: 5),
                decoration: pw.BoxDecoration(
                  border: pw.Border(
                    bottom: pw.BorderSide(color: customColor, width: 2),
                  ),
                ),
                child: pw.Text(
                  'Booking info',
                  style: pw.TextStyle(
                    fontSize: 14,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              ),
              pw.SizedBox(height: 10),
              pw.Text(
                'Invoice ID : ${bookingDetails.invoiceId}',
                style: _textStyleSizeSubHead(),
              ),
              pw.Text(
                'Booked on : ${formatDate(bookingDetails.bookedDate)}',
                style: _textStyleSizeSubHead(),
              ),
              if (bookingDetails.pickupDate != null)
                pw.Text(
                  'Pickup : ${formatDate(bookingDetails.pickupDate)}, ${bookingDetails.pickupDate!.formatToUiTime()}',
                  style: _textStyleSizeSubHead(),
                ),
              pw.Text(
                'Return : ${formatDate(bookingDetails.returnDate)}, ${bookingDetails.returnDate.formatToUiTime()}',
                style: _textStyleSizeSubHead(),
              ),
              if (bookingDetails
                  .bookedItems.first.mainServiceType.isVehicle) ...[
                if (locationStart.isNotEmpty)
                  pw.Text(
                    'Start Location: ${locationStart.isNotEmpty ? locationStart : 'Not available'}',
                    style: _textStyleSizeSubHead(),
                    textAlign: pw.TextAlign.end,
                  ),
                if (locationFrom.isNotEmpty)
                  pw.Text(
                    'Pickup Location: ${locationFrom.isNotEmpty ? locationFrom : 'Not available'}',
                    style: _textStyleSizeSubHead(),
                    textAlign: pw.TextAlign.end,
                  ),
                if (locationTo.isNotEmpty)
                  pw.Text(
                    'Destination: ${locationTo.isNotEmpty ? locationTo : 'Not available'}',
                    style: _textStyleSizeSubHead(),
                    textAlign: pw.TextAlign.end,
                  ),
              ]
            ],
          ),
        ),
      ],
    );
  }

  static String formatDate(String? date) {
    if (date == null) return 'Date not available';
    final parsedDate = date.parseToDateTime();
    return '${parsedDate.day}/${parsedDate.month}/${parsedDate.year}';
  }

  // Items table
  static pw.Widget _buildItemsTable(
    BookingDetailsModel bookingDetails,
    List<pw.ImageProvider> productImages,
  ) {
    return pw.Container(
      decoration: pw.BoxDecoration(
        border: pw.Border.all(color: PdfColors.grey300),
        borderRadius: pw.BorderRadius.circular(8),
      ),
      child: pw.Column(
        children: [
          // Table header
          pw.Container(
            padding: const pw.EdgeInsets.all(12),
            decoration: const pw.BoxDecoration(
              color: PdfColors.grey200,
              borderRadius:
                  pw.BorderRadius.vertical(top: pw.Radius.circular(8)),
            ),
            child: pw.Row(
              children: [
                pw.Expanded(
                  flex: 1,
                  child: pw.Text(
                    'Sl.no',
                    style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                  ),
                ),
                pw.Expanded(
                  flex: 4,
                  child: pw.Text(
                    'Product',
                    style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                  ),
                ),
                pw.Expanded(
                  flex: 2,
                  child: pw.Text(
                    'Amount',
                    style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                    textAlign: pw.TextAlign.right,
                  ),
                ),
              ],
            ),
          ),
          // products rows
          if (bookingDetails.bookedItems.isNotEmpty)
            ...bookingDetails.bookedItems.asMap().entries.map((entry) {
              final index = entry.key;
              final product = entry.value;
              final productImage = index < productImages.length
                  ? productImages[index]
                  : pw.MemoryImage(
                      File(AppIcons.unknownProduct).readAsBytesSync(),
                    );
              return pw.Container(
                padding: const pw.EdgeInsets.all(12),
                decoration: const pw.BoxDecoration(
                  border: pw.Border(
                    top: pw.BorderSide(
                      color: PdfColors.grey300,
                    ),
                  ),
                ),
                child: pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.center,
                  crossAxisAlignment: pw.CrossAxisAlignment.center,
                  children: [
                    pw.Expanded(
                      flex: 1,
                      child: pw.Text('${index + 1}'),
                    ),
                    pw.Expanded(
                      flex: 4,
                      child: pw.Row(
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
                                style: pw.TextStyle(
                                    fontWeight: pw.FontWeight.bold),
                              ),
                              pw.Text(
                                'Size: ${product.variantAttribute ?? '-'}',
                                style: const pw.TextStyle(
                                    fontSize: 12, color: PdfColors.grey600),
                              ),
                              pw.Text(
                                'Color: ${product.color ?? '-'}',
                                style: const pw.TextStyle(
                                    fontSize: 12, color: PdfColors.grey600),
                              ),
                            ],
                          ),
                        ],
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
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
        ],
      ),
    );
  }

  // Total section
  static pw.Widget _buildTotalSection(BookingDetailsModel bookingDetails) {
    return pw.Container(
      alignment: pw.Alignment.centerRight,
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.end,
        children: [
          // Security amount paid
          if ((bookingDetails.securityAmount ?? 0) > 0)
            pw.Container(
              width: 220,
              padding:
                  const pw.EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text(
                    'Security amount:',
                    style: const pw.TextStyle(fontSize: 14),
                  ),
                  pw.Text(
                    bookingDetails.securityAmount!.toCurrency(),
                    style: pw.TextStyle(
                      fontSize: 14,
                      color: PdfColors.black,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          // Discount amount paid
          if ((bookingDetails.discountAmount ?? 0) > 0)
            pw.Container(
              width: 220,
              padding:
                  const pw.EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text(
                    'Discount amount:',
                    style: const pw.TextStyle(fontSize: 14),
                  ),
                  pw.Text(
                    bookingDetails.discountAmount!.toCurrency(),
                    style: pw.TextStyle(
                      fontSize: 14,
                      color: customColor,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          // Advance amount paid
          pw.Container(
            width: 220,
            padding: const pw.EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Text(
                  'Paid amount:',
                  style: const pw.TextStyle(fontSize: 14),
                ),
                pw.Text(
                  bookingDetails.paidAmount.toCurrency(),
                  style: pw.TextStyle(
                    fontSize: 14,
                    color: customColor,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          // Grand total
          pw.Container(
            width: 220,
            padding: const pw.EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            decoration: pw.BoxDecoration(
              border: pw.Border(
                top: pw.BorderSide(
                  color: customColor,
                  width: 1.5,
                ),
              ),
            ),
            child: pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Text(
                  'Grand total:',
                  style: pw.TextStyle(
                    fontSize: 14,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.Text(
                  bookingDetails.totalAmount.toCurrency(),
                  style: pw.TextStyle(
                    fontSize: 14,
                    fontWeight: pw.FontWeight.bold,
                    color: customColor,
                  ),
                ),
              ],
            ),
          ),
          // Balance amount (if any)
          if (bookingDetails.totalAmount > bookingDetails.paidAmount)
            pw.Container(
              width: 220,
              padding: const pw.EdgeInsets.symmetric(
                vertical: 8,
                horizontal: 16,
              ),
              child: pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text(
                    'Balance due:',
                    style: pw.TextStyle(
                      fontSize: 14,
                      fontWeight: pw.FontWeight.bold,
                      color: PdfColors.red,
                    ),
                  ),
                  pw.Text(
                    (bookingDetails.totalAmount -
                            (bookingDetails.paidAmount +
                                (bookingDetails.discountAmount ?? 0)))
                        .toCurrency(),
                    style: pw.TextStyle(
                      fontSize: 14,
                      fontWeight: pw.FontWeight.bold,
                      color: PdfColors.red,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  // Terms and conditions
  static pw.Widget _buildTermsAndConditions(
    List<String> termsAndConditions,
  ) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          'Terms & condition',
          style: pw.TextStyle(
            fontSize: 14,
            fontWeight: pw.FontWeight.bold,
          ),
        ),
        pw.SizedBox(height: 8),
        ...termsAndConditions.map(
          (e) {
            return pw.Bullet(
              text: e,
              style: const pw.TextStyle(fontSize: 12),
            );
          },
        ),
        if (termsAndConditions.isEmpty) ...[
          pw.Bullet(
            text: 'No refund will be given after Booking cancellation.',
            style: const pw.TextStyle(fontSize: 12),
          ),
          pw.Bullet(
            text:
                'Products should be returned on the exact return date, without any damages.',
            style: const pw.TextStyle(fontSize: 12),
          ),
          pw.Bullet(
            text: 'Any damages must be paid by the customer',
            style: const pw.TextStyle(fontSize: 12),
          ),
          pw.Bullet(
            text: 'Confirm your Pickup and return dates properly.',
            style: const pw.TextStyle(fontSize: 12),
          ),
          pw.Bullet(
            text: 'Make sure all your needs are clear before booking.',
            style: const pw.TextStyle(fontSize: 12),
          ),
          pw.Bullet(
            text:
                'Security deposit (if applicable) will be refunded after return.',
            style: const pw.TextStyle(fontSize: 12),
          ),
        ]
      ],
    );
  }
}
