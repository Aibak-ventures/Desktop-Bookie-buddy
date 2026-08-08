/// Status of the QZ Tray bridge itself — there is no persistent
/// per-device connection to model here (unlike mobile's Bluetooth/USB/
/// network connectors); each print is "connect to QZ Tray if needed ->
/// send bytes -> done".
enum PrinterBridgeStatus {
  /// Initial state before the first availability check has run.
  unknown,

  /// QZ Tray isn't running (or the WebSocket handshake failed) — first-
  /// class expected state, not an edge case, since it requires the user to
  /// have installed and started the desktop app.
  unavailable,

  connecting,
  connected,
  printing,
  error,
}
