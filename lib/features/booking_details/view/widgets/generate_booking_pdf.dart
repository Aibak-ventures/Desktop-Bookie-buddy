import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

// Your models
import 'package:bookie_buddy_web/core/models/booking_details_model/booking_details_model.dart';
import 'package:bookie_buddy_web/core/models/user_shop_model/user_shop_model.dart';

class GenerateBookingPdf {
  /// 🖨️ Print (opens directly in system PDF viewer)
  static Future<void> printInvoice({
    required BuildContext context,
    required BookingDetailsModel bookingDetails,
    required UserShopModel shopDetails,
  }) async {
    try {
      final pdfBytes = await generateInvoice(bookingDetails, shopDetails);
      final dir = await getDownloadsFolder(); // use shared folder
      final file = File('${dir.path}/invoice_${bookingDetails.invoiceId}.pdf');
      await file.writeAsBytes(pdfBytes);

      await OpenFile.open(file.path); // ✅ Opens in PDF viewer (user can print)
    } catch (e) {
      debugPrint('Error printing PDF: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error opening invoice: $e')),
      );
    }
  }

  /// 💾 Download (saves to Documents folder)
  static Future<void> shareInvoice({
    required BuildContext context,
    required BookingDetailsModel bookingDetails,
    required UserShopModel shopDetails,
  }) async {
    try {
      final pdfBytes = await generateInvoice(bookingDetails, shopDetails);
      final dir = await getDocumentsFolder(); // visible folder
      final folder = Directory('${dir.path}/Invoices');
      if (!await folder.exists()) await folder.create(recursive: true);

      final file = File('${folder.path}/invoice_${bookingDetails.invoiceId}.pdf');
      await file.writeAsBytes(pdfBytes);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Invoice saved to: ${file.path}')),
      );
    } catch (e) {
      debugPrint('Error saving invoice: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to save invoice: $e')),
      );
    }
  }

  /// 🧾 Generate PDF
  static Future<Uint8List> generateInvoice(
    BookingDetailsModel bookingDetails,
    UserShopModel shopDetails,
  ) async {
    final pdf = pw.Document();
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (context) => pw.Padding(
          padding: const pw.EdgeInsets.all(24),
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text('Invoice #${bookingDetails.invoiceId}',
                  style: pw.TextStyle(
                    fontSize: 20,
                    fontWeight: pw.FontWeight.bold,
                  )),
              pw.SizedBox(height: 10),
              pw.Text('Customer: ${bookingDetails.client.name}'),
              pw.Text('Shop: ${shopDetails.name}'),
              pw.SizedBox(height: 20),
              pw.Text('Total Amount: ${bookingDetails.totalAmount}'),
              pw.SizedBox(height: 20),
              pw.Text('Thank you for your business!'),
            ],
          ),
        ),
      ),
    );
    return pdf.save();
  }

  /// 🧭 Helper: Get Downloads folder
  static Future<Directory> getDownloadsFolder() async {
    if (Platform.isWindows) {
      final downloadsPath =
          '${Platform.environment['USERPROFILE']}\\Downloads';
      return Directory(downloadsPath);
    }
    return getApplicationDocumentsDirectory();
  }

  /// 🧭 Helper: Get Documents folder
  static Future<Directory> getDocumentsFolder() async {
    if (Platform.isWindows) {
      final documentsPath =
          '${Platform.environment['USERPROFILE']}\\Documents';
      return Directory(documentsPath);
    }
    return getApplicationDocumentsDirectory();
  }
}
