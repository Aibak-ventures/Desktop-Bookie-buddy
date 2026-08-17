import 'package:bookie_buddy_web/core/constants/enums/print_output_preference_enum.dart';
import 'package:bookie_buddy_web/features/auth/presentation/bloc/user_cubit/user_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../utils/extensions/color_extensions.dart';
import '../../../../utils/extensions/context_extensions.dart';
import '../../../../utils/extensions/number_extensions.dart';
import '../../../theme/app_colors.dart';

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

/// Compact chooser between the two [PrintOutputPreference] formats. A
/// dialog rather than a bottom sheet on purpose — the print action always
/// starts from a top app bar button, so a centered dialog lands right next
/// to the tap instead of making the user's thumb travel to the bottom of
/// the screen.
Future<PrintOutputPreference?> _askPrintOutput(BuildContext context) {
  return showDialog<PrintOutputPreference>(
    context: context,
    builder: (dialogContext) => AlertDialog(
      contentPadding: 10.padding,
      shape: RoundedRectangleBorder(borderRadius: 16.radiusBorder),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          10.height,
          const Text('What do you want to print?'),
          10.height,
          _PrintOutputOption(
            icon: Icons.receipt_long_outlined,
            label: PrintOutputPreference.receipt.label,
            color: AppColors.purple,
            onTap: () => dialogContext.pop(PrintOutputPreference.receipt),
          ),
          _PrintOutputOption(
            icon: Icons.picture_as_pdf_outlined,
            label: PrintOutputPreference.pdfInvoice.label,
            color: AppColors.redTomato,
            onTap: () => dialogContext.pop(PrintOutputPreference.pdfInvoice),
          ),
        ],
      ),
    ),
  );
}

class _PrintOutputOption extends StatelessWidget {
  const _PrintOutputOption({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: (20, 12).padding,
        child: Row(
          children: [
            Container(
              padding: 8.padding,
              decoration: BoxDecoration(
                color: color.changeOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 20.sp, color: color),
            ),
            12.width,
            Text(
              label,
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}
