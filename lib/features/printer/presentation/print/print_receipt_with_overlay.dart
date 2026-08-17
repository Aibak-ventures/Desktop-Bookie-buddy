import 'dart:developer';

import 'package:bookie_buddy_web/core/common/entities/user_shop_entity/user_shop_entity.dart';
import 'package:bookie_buddy_web/core/common/widgets/global_loading_overlay.dart';
import 'package:bookie_buddy_web/core/constants/endpoints/baseurl.dart'
    show kIsDevelopment;
import 'package:bookie_buddy_web/features/auth/presentation/bloc/user_cubit/user_cubit.dart';
import 'package:bookie_buddy_web/features/printer/domain/entities/print_ticket_entity/print_ticket_entity.dart';
import 'package:bookie_buddy_web/features/printer/presentation/print/quick_print_receipt.dart';
import 'package:bookie_buddy_web/features/printer/presentation/receipt_design/preview/receipt_ticket_preview_screen.dart';
import 'package:bookie_buddy_web/utils/extensions/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

const _logName = 'QzPrinter';

/// Generic "build a receipt ticket for the current shop, then quick-print
/// it" flow — the orchestration every feature's receipt-print action needs
/// (booking today, sales/custom-work later), factored out so it isn't
/// copy-pasted per feature.
///
/// Handles, in order:
/// 1. Reading the current shop from [UserCubit] — bails with a snackbar if
///    it isn't loaded yet.
/// 2. Showing a loading overlay while `buildTicket` renders the ticket
///    (off-screen widget rendering, so it's genuinely async).
/// 3. Catching a `buildTicket` failure and showing an error snackbar —
///    [printReceiptQuickly] handles its own errors internally, so this is
///    the only failure point this helper needs to guard.
/// 4. Handing the built ticket to [printReceiptQuickly] for the actual
///    print (and its own "no printer configured" fallback).
///
/// Usage — a feature only needs to supply its own ticket builder:
/// ```dart
/// await ReceiptWithOverlay.printReceipt(
///   context: context,
///   buildTicket: (shop) => const BookingReceiptCanvasBuilder()(
///     context: context,
///     booking: booking,
///     shop: shop,
///   ),
/// );
/// ```
final class ReceiptWithOverlay {
  static Future<void> printReceipt({
    required BuildContext context,
    required Future<PrintTicketEntity> Function(UserShopEntity shop)
    buildTicket,
    String loadingText = 'Preparing receipt...',
  }) async {
    final ticket = await _buildTicketWithOverlay(
      context: context,
      buildTicket: buildTicket,
      loadingText: loadingText,
    );
    if (ticket == null || !context.mounted) return;

    log(
      'Built receipt ticket (${ticket.commands.length} commands) — '
      'quick-printing',
      name: _logName,
    );
    await printReceiptQuickly(context: context, ticket: ticket);
  }

  /// Same as [printReceipt] but for previewing the receipt before printing
  /// — never wire this behind a real print action; it's a dev-only tool for
  /// checking a design change without burning paper. Callers must gate the
  /// UI that triggers this behind [kIsDevelopment] themselves; the assert
  /// here is a backstop, not the actual gate (asserts are stripped in
  /// release builds).
  static Future<void> previewReceipt({
    required BuildContext context,
    required Future<PrintTicketEntity> Function(UserShopEntity shop)
    buildTicket,
  }) async {
    assert(kIsDevelopment, 'previewReceipt is a debug-only tool');
    final ticket = await _buildTicketWithOverlay(
      context: context,
      buildTicket: buildTicket,
      loadingText: 'Rendering preview...',
    );
    if (ticket == null || !context.mounted) return;

    log(
      'Built receipt ticket (${ticket.commands.length} commands) — previewing',
      name: _logName,
    );
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => ReceiptTicketPreviewScreen(ticket: ticket),
      ),
    );
  }

  /// Shared "load shop, show overlay, render ticket" steps behind both
  /// [printReceipt] and [previewReceipt] — `null` means it already handled
  /// telling the user why (missing shop, or a `buildTicket` failure) and
  /// the caller should just stop.
  static Future<PrintTicketEntity?> _buildTicketWithOverlay({
    required BuildContext context,
    required Future<PrintTicketEntity> Function(UserShopEntity shop)
    buildTicket,
    required String loadingText,
  }) async {
    final shop = context.read<UserCubit>().state?.shopDetails;
    if (shop == null) {
      context.showSnackBar(
        'Shop details not available. Please try again.',
        isError: true,
      );
      return null;
    }

    GlobalLoadingOverlay.show(context, text: loadingText);
    try {
      final ticket = await buildTicket(shop);
      GlobalLoadingOverlay.hide();
      return ticket;
    } catch (e, stack) {
      log(
        'Failed to build receipt ticket: $e',
        name: _logName,
        error: e,
        stackTrace: stack,
      );
      GlobalLoadingOverlay.hide();
      if (context.mounted) {
        context.showSnackBar('Failed to prepare receipt: $e', isError: true);
      }
      return null;
    }
  }
}
