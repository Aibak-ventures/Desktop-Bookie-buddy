import 'dart:developer';
import 'dart:js_interop';

import 'package:bookie_buddy_web/features/printer/data/datasources/qz_tray_js_bindings.dart';
import 'package:bookie_buddy_web/utils/error/exceptions/printer_exceptions.dart';

const _logName = 'QzPrinter';

/// Thin wrapper around `qz-tray.js` (via [qzTray]) — the only place in the
/// app that touches the raw JS bindings directly. Everything else in this
/// feature works with domain entities. Mirrors
/// `ThermalPrinterDatasource` in the mobile app's `thermal_printer`
/// feature.
class QzTrayDatasource {
  /// Connects to the QZ Tray WebSocket (`wss://localhost:8181`) if not
  /// already connected. Throws [PrinterBridgeUnavailableException] if QZ
  /// Tray isn't running (connect promise rejects) — the caller is expected
  /// to already have tried [isAvailable] first, but this is the actual
  /// enforcement point for anything (e.g. `printRaw`) that needs a live
  /// connection.
  Future<void> connect() async {
    if (qzTray.websocket.isActive().toDart) {
      log('Already connected to QZ Tray', name: _logName);
      return;
    }
    log('Connecting to QZ Tray...', name: _logName);
    try {
      await qzTray.websocket.connect().toDart;
      log('Connected to QZ Tray', name: _logName);
    } catch (e, stack) {
      log(
        'QZ Tray connect failed: $e',
        name: _logName,
        error: e,
        stackTrace: stack,
      );
      throw PrinterBridgeUnavailableException();
    }
  }

  /// Cheap availability probe — connects if needed and reports whether
  /// that succeeded, rather than throwing. Use at screen-open time.
  Future<bool> isAvailable() async {
    if (qzTray.websocket.isActive().toDart) {
      return true;
    }
    try {
      await connect();
      return true;
    } on PrinterBridgeUnavailableException {
      return false;
    }
  }

  Future<void> disconnect() async {
    if (!qzTray.websocket.isActive().toDart) {
      return;
    }
    log('Disconnecting from QZ Tray...', name: _logName);
    await qzTray.websocket.disconnect().toDart;
    log('Disconnected from QZ Tray', name: _logName);
  }

  /// Returns raw printer names as reported by the OS print-driver list —
  /// QZ exposes no address/connection-type breakdown beyond the name.
  Future<List<String>> findPrinters() async {
    await connect();
    log('Finding printers...', name: _logName);
    try {
      final result = await qzTray.printers.find().toDart;
      final names = (result as JSArray).toDart
          .map((e) => (e as JSString).toDart)
          .toList();
      log('Found ${names.length} printer(s): $names', name: _logName);
      return names;
    } catch (e, stack) {
      log(
        'findPrinters() failed: $e',
        name: _logName,
        error: e,
        stackTrace: stack,
      );
      throw PrinterOperationException('Could not list printers: $e');
    }
  }

  /// Sends already-built raw ESC/POS bytes (base64-encoded) to
  /// [printerName] via QZ Tray.
  Future<void> printRaw(String printerName, String escPosBase64) async {
    await connect();
    log(
      'Printing ${escPosBase64.length} base64 char(s) to "$printerName"...',
      name: _logName,
    );
    try {
      final config = qzTray.configs.create(printerName.toJS);
      final data = QzPrintDataJson(
        type: 'raw',
        format: 'command',
        flavor: 'base64',
        data: escPosBase64,
      );
      await qzTray.print(config, [data].toJS).toDart;
      log('Print handed to QZ Tray', name: _logName);
    } catch (e, stack) {
      log('printRaw() failed: $e', name: _logName, error: e, stackTrace: stack);
      throw PrinterOperationException('Print failed: $e');
    }
  }
}
