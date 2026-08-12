/// Live reachability of a printer as reported by QZ Tray's status API
/// (`qz.printers.getStatus()`), separate from [PrinterDeviceEntity] itself
/// since QZ's static `find()` list (installed/paired printers) and its
/// status push (actually-reachable-right-now) come from two different
/// calls — see `QzTrayDatasource.getPrinterStatuses`.
enum PrinterOnlineStatus {
  /// Status hasn't been checked yet (e.g. still loading, or the status
  /// query timed out/failed) — shown neutrally, never as a hard negative,
  /// since some printers/drivers don't report status at all.
  unknown,

  /// QZ/OS driver reports the printer as reachable and ready.
  online,

  /// QZ/OS driver reports the printer as unreachable (powered off,
  /// disconnected, out of range, etc).
  offline,
}
