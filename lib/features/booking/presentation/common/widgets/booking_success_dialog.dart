import 'dart:developer';
import 'dart:io';
import 'package:bookie_buddy_web/core/common/widgets/global_loading_overlay.dart';
import 'package:bookie_buddy_web/core/di/app_dependencies.dart';
import 'package:bookie_buddy_web/features/booking/domain/repositories/i_booking_repository.dart';
import 'package:bookie_buddy_web/features/booking/presentation/common/booking_form/booking_type_enum.dart';
import 'package:bookie_buddy_web/features/sales/domain/repositories/i_sales_repository.dart';
import 'package:bookie_buddy_web/utils/extensions/context_extensions.dart';
import 'package:bookie_buddy_web/utils/open_pdf_in_new_tab_web.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void showBookingSuccessDialog({
  required BuildContext context,
  required int id,
  required BookingType type,
  required bool sendPdfToWhatsApp,
  required bool Function() isMounted,
  VoidCallback? onClose,
}) {
  final isSale = type == BookingType.sales;

  if (!isSale) {
    Future.delayed(Duration.zero, () async {
      try {
        final repo = getIt<IBookingRepository>();
        await repo.sendInvoice(id, sendPdfToWhatsApp);
      } catch (e) {
        log('Error sending invoice: $e');
      }
    });
  }

  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (dialogContext) {
      Future.delayed(const Duration(seconds: 10), () {
        if (isMounted()) {
          Navigator.of(dialogContext).pop();
          if (onClose != null) {
            onClose();
          } else {
            Navigator.of(context).pop();
          }
        }
      });

      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.check_circle_rounded,
              color: Colors.green,
              size: 64,
            ),
            const SizedBox(height: 16),
            const Text(
              'Successful!',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              isSale
                  ? 'Sale has been successfully created.'
                  : 'Booking has been successfully created.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
            ),
            const SizedBox(height: 8),
            Text(
              'Auto-closing in 10 seconds...',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade500,
                fontStyle: FontStyle.italic,
              ),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.of(dialogContext).pop();
                      if (onClose != null) {
                        onClose();
                      } else {
                        Navigator.of(context).pop();
                      }
                    },
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      side: BorderSide(color: Colors.grey.shade300),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'Close',
                      style: TextStyle(color: Colors.grey.shade700),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () async {
                      try {
                        GlobalLoadingOverlay.show(
                          context,
                          text: 'Loading invoice...',
                        );

                        if (isSale) {
                          final repo = getIt<ISalesRepository>();
                          final pdfBytes = await repo.getInvoicePdfBytes(id);
                          GlobalLoadingOverlay.hide();
                          if (isMounted()) {
                            if (kIsWeb) {
                              openPdfInNewTab(pdfBytes, 'sale_invoice_$id.pdf');
                            } else {
                              final downloadsDir = Directory(
                                '${Platform.environment['USERPROFILE']}\\Downloads',
                              );
                              if (!downloadsDir.existsSync()) {
                                downloadsDir.createSync(recursive: true);
                              }
                              final fileName = 'sale_invoice_$id.pdf';
                              final filePath = '${downloadsDir.path}\\$fileName';
                              await File(filePath).writeAsBytes(pdfBytes);
                              await launchUrl(Uri.file(filePath));
                              context.showSnackBar(
                                'Invoice saved to Downloads\\$fileName',
                              );
                            }
                          }
                        } else {
                          final repo = getIt<IBookingRepository>();
                          final pdfBytes = await repo.getInvoicePdfBytes(id);
                          GlobalLoadingOverlay.hide();
                          if (isMounted()) {
                            if (kIsWeb) {
                              openPdfInNewTab(
                                pdfBytes,
                                'booking_invoice_$id.pdf',
                              );
                            } else {
                              final downloadsDir = Directory(
                                '${Platform.environment['USERPROFILE']}\\Downloads',
                              );
                              if (!downloadsDir.existsSync()) {
                                downloadsDir.createSync(recursive: true);
                              }
                              final fileName = 'booking_invoice_$id.pdf';
                              final filePath = '${downloadsDir.path}\\$fileName';
                              await File(filePath).writeAsBytes(pdfBytes);
                              await launchUrl(Uri.file(filePath));
                              context.showSnackBar(
                                'Invoice saved to Downloads\\$fileName',
                              );
                            }
                          }
                        }
                      } catch (e) {
                        GlobalLoadingOverlay.hide();
                        log('Error loading invoice: $e');
                        if (isMounted()) {
                          context.showSnackBar(
                            'Failed to load invoice: $e',
                            isError: true,
                          );
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF6132E4),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      isSale ? 'View Sale' : 'View Invoice',
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    },
  );
}
