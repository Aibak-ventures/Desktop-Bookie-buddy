import 'dart:developer';

import 'package:bookie_buddy_web/features/printer/domain/entities/print_ticket_entity/print_ticket_entity.dart';
import 'package:bookie_buddy_web/features/printer/domain/entities/quick_print_result.dart';
import 'package:bookie_buddy_web/features/printer/domain/repositories/i_printer_repository.dart';

const _logName = 'QuickPrint';

/// Prints [ticket] straight to the last-used printer — no screen
/// navigation, no printer picker. This is the fast path for "print my
/// receipt" from anywhere in the app (booking/sale detail, etc.); the
/// picker/setup flow (`QzPrintScreen`) is only needed the first time a
/// printer is chosen, or as a fallback when this fails.
///
/// Deliberately skips an upfront `isBridgeAvailable()` check — that would
/// just be a second round trip before the print attempt itself, which
/// already fails informatively if the bridge or printer isn't reachable.
class QuickPrintReceiptUseCase {
  QuickPrintReceiptUseCase(this._repository);

  final IPrinterRepository _repository;

  Future<QuickPrintResult> call(PrintTicketEntity ticket) async {
    final printerName = await _repository.getLastPrinter();
    if (printerName == null) {
      log('call() — no printer configured yet', name: _logName);
      return const QuickPrintNoPrinterConfigured();
    }

    log('call() -> "$printerName"', name: _logName);
    try {
      await _repository.print(printerName, ticket);
      log('call() succeeded', name: _logName);
      return const QuickPrintSuccess();
    } catch (e, stack) {
      log('call() failed: $e', name: _logName, error: e, stackTrace: stack);
      return QuickPrintFailed(e.toString());
    }
  }
}
