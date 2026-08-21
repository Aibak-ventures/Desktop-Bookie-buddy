import 'package:bookie_buddy_web/features/printer/domain/entities/print_ticket_entity/print_ticket_entity.dart';
import 'package:bookie_buddy_web/features/printer/domain/entities/printer_device_entity/printer_device_entity.dart';

abstract interface class IPrinterRepository {
  /// Cheap check for whether QZ Tray is reachable at
  /// `wss://localhost:8181` — connects if not already connected. Use at
  /// screen-open time to decide between the printer picker and the
  /// "QZ Tray isn't running" state.
  Future<bool> isBridgeAvailable();

  /// Explicitly (re)connects to the QZ Tray WebSocket. Most callers don't
  /// need this directly — [isBridgeAvailable] and [findPrinters] both
  /// connect on demand — but it's exposed for an explicit "Retry" action.
  Future<void> connectToBridge();

  /// Returns the OS/QZ-installed printer list. [PrinterDeviceEntity.onlineStatus]
  /// on each entry is [PrinterOnlineStatus.unknown] until [refreshPrinterStatuses]
  /// has been run against it — this call alone doesn't probe liveness.
  Future<List<PrinterDeviceEntity>> findPrinters();

  /// Probes live reachability for [printers] via QZ Tray's status API and
  /// returns the same list with [PrinterDeviceEntity.onlineStatus] filled
  /// in. Separate from [findPrinters] since the status query is slower
  /// (round-trips through QZ's async event callback, several seconds
  /// worst-case) — callers show the list immediately from [findPrinters]
  /// then refresh statuses in.
  Future<List<PrinterDeviceEntity>> refreshPrinterStatuses(
    List<PrinterDeviceEntity> printers,
  );

  /// Sends [ticket] to [printerName] via QZ Tray. The repository is the
  /// only place that turns [PrintTicketEntity]'s commands into actual
  /// ESC/POS bytes (via `esc_pos_utils_plus`) — domain/presentation never
  /// see that library's types.
  Future<void> print(String printerName, PrintTicketEntity ticket);

  /// Persists the last-used printer name so returning users aren't asked
  /// to re-pick a printer every session — QZ has no auto-reconnect/last-
  /// device concept of its own, unlike mobile's Bluetooth/USB connectors.
  Future<void> saveLastPrinter(String printerName);

  Future<String?> getLastPrinter();

  Future<void> clearLastPrinter();
}
