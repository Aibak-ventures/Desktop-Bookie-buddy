import 'dart:developer';

import 'package:bookie_buddy_web/core/common/widgets/global_loading_overlay.dart';
import 'package:bookie_buddy_web/core/di/app_dependencies.dart';
import 'package:bookie_buddy_core/features/thermal_printer/domain/entities/print_ticket_entity/print_ticket_entity.dart';
import 'package:bookie_buddy_web/features/printer/domain/entities/quick_print_result.dart';
import 'package:bookie_buddy_web/features/printer/domain/usecases/quick_print_receipt_usecase.dart';
import 'package:bookie_buddy_web/features/printer/presentation/print/pages/qz_print_screen.dart';
import 'package:bookie_buddy_web/utils/extensions/context_extensions.dart';
import 'package:flutter/material.dart';

const _logName = 'QuickPrint';

/// Single call-site for "print this receipt" from anywhere in the app
/// (booking/sale detail, etc.) — the fast path around [QzPrintScreen].
///
/// Tries [QuickPrintReceiptUseCase] against the last-used printer with a
/// loading overlay and no navigation. If nothing's configured yet or the
/// attempt fails, shows a snackbar explaining that and — unless
/// [showSetupOnFailure] is false — offers a "Set up" action that opens
/// [QzPrintScreen] so the user can pick/reconnect a printer and print from
/// there instead.
Future<void> printReceiptQuickly({
  required BuildContext context,
  required PrintTicketEntity ticket,
  bool showSetupOnFailure = true,
}) async {
  GlobalLoadingOverlay.show(context, text: 'Printing...');
  final result = await getIt<QuickPrintReceiptUseCase>()(ticket);
  GlobalLoadingOverlay.hide();
  if (!context.mounted) return;

  switch (result) {
    case QuickPrintSuccess():
      log('printReceiptQuickly() succeeded', name: _logName);
    case QuickPrintNoPrinterConfigured():
      log('printReceiptQuickly() — no printer configured', name: _logName);
      _showSetupPrompt(
        context,
        ticket,
        message: "You haven't set up a printer yet.",
        showSetupOnFailure: showSetupOnFailure,
      );
    case QuickPrintFailed(:final message):
      log('printReceiptQuickly() failed: $message', name: _logName);
      _showSetupPrompt(
        context,
        ticket,
        message: "Couldn't reach your printer. Make sure it's connected.",
        showSetupOnFailure: showSetupOnFailure,
      );
  }
}

void _showSetupPrompt(
  BuildContext context,
  PrintTicketEntity ticket, {
  required String message,
  required bool showSetupOnFailure,
}) {
  if (!showSetupOnFailure) {
    context.showSnackBar(message, isError: true, title: 'Not connected');
    return;
  }

  // A dialog (not a snackbar action) carries the "go set up a printer"
  // choice — this app's CustomSnackBar is a plain overlay toast with no
  // action-button slot, so a second control needs its own surface.
  showDialog<void>(
    context: context,
    builder: (dialogContext) => AlertDialog(
      title: const Text('Not connected to a printer'),
      content: Text('$message Go to printer setup to connect one.'),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(dialogContext).pop(),
          child: const Text('Later'),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(dialogContext).pop();
            Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => QzPrintScreen(ticket: ticket)),
            );
          },
          child: const Text(
            'Set up printer',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    ),
  );
}
