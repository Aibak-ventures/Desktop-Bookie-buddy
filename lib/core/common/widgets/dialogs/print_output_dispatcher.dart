import 'package:bookie_buddy_web/core/constants/enums/print_output_preference_enum.dart';
import 'package:bookie_buddy_web/features/auth/presentation/bloc/user_cubit/user_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Single "Print" entry point for any feature that offers both a thermal
/// receipt and a PDF invoice (booking today, sales/custom-work later).
///
/// Reads Settings > Print Output (`PrintOutputPreference`) and routes to
/// [printReceipt] or [printPdfInvoice] accordingly. On
/// [PrintOutputPreference.askEveryTime], asks via a small chooser dialog
/// first and does *not* persist that one-off pick — "ask every time" means
/// exactly that.
///
/// Callers only need to supply *how* to print each format — this function
/// owns the preference lookup and the ask-dialog, so it isn't duplicated
/// per feature the way the booking-only version used to be.
Future<void> printWithOutputPreference({
  required BuildContext context,
  required Future<void> Function() printReceipt,
  required Future<void> Function() printPdfInvoice,
}) async {
  final preference =
      context.read<UserCubit>().state?.shopSettings.printOutputPreference ??
      PrintOutputPreference.askEveryTime;

  final resolved = preference == PrintOutputPreference.askEveryTime
      ? await _askPrintOutput(context)
      : preference;
  if (resolved == null || !context.mounted) return; // user dismissed

  switch (resolved) {
    case PrintOutputPreference.receipt:
      await printReceipt();
    case PrintOutputPreference.pdfInvoice:
      await printPdfInvoice();
    case PrintOutputPreference.askEveryTime:
      break; // unreachable — _askPrintOutput never returns this value
  }
}

Future<PrintOutputPreference?> _askPrintOutput(BuildContext context) {
  return showDialog<PrintOutputPreference>(
    context: context,
    builder: (dialogContext) => AlertDialog(
      title: const Text('Print'),
      content: const Text('What would you like to print?'),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(dialogContext).pop(),
          child: const Text('Cancel'),
        ),
        OutlinedButton(
          onPressed: () => Navigator.of(
            dialogContext,
          ).pop(PrintOutputPreference.pdfInvoice),
          child: Text(PrintOutputPreference.pdfInvoice.label),
        ),
        ElevatedButton(
          onPressed: () =>
              Navigator.of(dialogContext).pop(PrintOutputPreference.receipt),
          child: Text(
            PrintOutputPreference.receipt.label,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ],
    ),
  );
}
