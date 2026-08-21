/// Outcome of [QuickPrintReceiptUseCase] — a plain Command-pattern result
/// value, not a domain entity (no business identity). Hand-written sealed
/// class rather than `@freezed` for the same reason as
/// `PrintTicketCommand`: small, and a native `switch` already gives
/// exhaustiveness.
sealed class QuickPrintResult {
  const QuickPrintResult();
}

/// Printed successfully to the last-used printer.
class QuickPrintSuccess extends QuickPrintResult {
  const QuickPrintSuccess();
}

/// No printer has ever been configured (nothing saved via
/// `SaveLastPrinterUseCase`) — there's nothing to try silently, the caller
/// should send the user to [QzPrintScreen] to pick one.
class QuickPrintNoPrinterConfigured extends QuickPrintResult {
  const QuickPrintNoPrinterConfigured();
}

/// Printing to the last-used printer failed — bridge not running, printer
/// unplugged/renamed, etc. Deliberately doesn't distinguish *why*: the
/// fix is the same either way (open the printer setup screen).
class QuickPrintFailed extends QuickPrintResult {
  const QuickPrintFailed(this.message);

  final String message;
}
