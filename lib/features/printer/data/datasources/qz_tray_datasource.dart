import 'dart:async';
import 'dart:developer';
import 'dart:js_interop';

import 'package:bookie_buddy_web/features/printer/data/datasources/qz_tray_js_bindings.dart';
import 'package:bookie_buddy_web/features/printer/domain/entities/printer_device_entity/printer_online_status.dart';
import 'package:bookie_buddy_web/utils/error/exceptions/printer_exceptions.dart';

const _logName = 'QzPrinter';

/// Thin wrapper around `qz-tray.js` (via [qzTray]) — the only place in the
/// app that touches the raw JS bindings directly. Everything else in this
/// feature works with domain entities. Mirrors
/// `ThermalPrinterDatasource` in the mobile app's `thermal_printer`
/// feature.
///
/// Every call here is request-signed (see `web/qz/qz-sign-message.js`,
/// loaded before Flutter's own bootstrap in `web/index.html`) — without
/// that, QZ Tray shows an "Allow this site to print?" popup on *every*
/// privileged call (`connect`, `find`, `print`), not just once per
/// session. Signing still means one one-time "trust this certificate?"
/// prompt the first time QZ Tray sees this app's self-signed cert
/// (`web/qz/digital-certificate.txt`) — expected, not a bug.
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

  /// Queries QZ Tray's live status for [printerNames] (OS/driver-reported
  /// reachability — SNMP for network printers, driver state for USB/local
  /// ones) and returns a status per name. Any name QZ never reports back
  /// for (driver doesn't support status, or the [_statusTimeout] elapses
  /// first) is reported as [PrinterOnlineStatus.unknown] rather than
  /// assumed offline — an absent report isn't proof the printer is down.
  Future<Map<String, PrinterOnlineStatus>> getPrinterStatuses(
    List<String> printerNames,
  ) async {
    if (printerNames.isEmpty) return {};
    await connect();
    log('Querying status for $printerNames...', name: _logName);

    final results = <String, PrinterOnlineStatus>{};
    final pending = printerNames.toSet();
    final completer = Completer<void>();

    // Deliberately untyped (`JSAny?` + `dartify()`) rather than a
    // statically-typed extension-type/array parameter: DDC's runtime
    // argument check on a strongly-generic-typed callback parameter
    // rejects the native object QZ actually calls back with
    // ("LegacyJavaScriptObject is not a subtype of ..."). `dartify()`
    // walks the JS value into plain Dart collections with no such brand
    // check, sidestepping the mismatch entirely.
    //
    // Per the bundled `qz-tray.js`'s own JSDoc on `setPrinterCallbacks`
    // (`web/qz/qz-tray.js`, `printers.callPrinter`/`setPrinterCallbacks`):
    // this callback fires once **per event**, each call carrying a single
    // event object (never a batch array) with `printerName`/`status`
    // fields — not the `printer`/`statusText`/`severity` array shape
    // assumed here previously.
    void onStatus(JSAny? eventAny) {
      final event = eventAny?.dartify();
      if (event is! Map) return;
      final printerName = event['printerName'] as String?;
      final status = event['status'] as String?;
      if (printerName == null) return;
      results[printerName] = _parseStatus(status ?? '');
      pending.remove(printerName);
      if (pending.isEmpty && !completer.isCompleted) completer.complete();
    }

    try {
      qzTray.printers.setPrinterCallbacks(onStatus.toJS);
      await qzTray.printers
          .startListening(printerNames.map((e) => e.toJS).toList().toJS)
          .toDart;
      await qzTray.printers.getStatus().toDart;
      await completer.future.timeout(_statusTimeout, onTimeout: () {});
    } catch (e, stack) {
      log(
        'getPrinterStatuses() failed: $e',
        name: _logName,
        error: e,
        stackTrace: stack,
      );
      // Fall through — printers not yet in [results] are reported unknown
      // below rather than throwing, since a failed status check shouldn't
      // block the picker from showing the (still-valid) printer list.
    } finally {
      try {
        await qzTray.printers.stopListening().toDart;
      } catch (_) {
        // Best-effort cleanup only.
      }
    }

    for (final name in printerNames) {
      results.putIfAbsent(name, () => PrinterOnlineStatus.unknown);
    }
    log('Printer statuses: $results', name: _logName);
    return results;
  }

  static const _statusTimeout = Duration(seconds: 4);

  /// QZ's `status` values are driver-specific free text (e.g. `"OK"`,
  /// `"READY"`, `"OFFLINE"`, `"NOT AVAILABLE"`) — no fixed enum from QZ
  /// itself, so this matches on substrings rather than exact strings.
  PrinterOnlineStatus _parseStatus(String status) {
    final normalized = status.toUpperCase();
    if (normalized.contains('OFFLINE') ||
        normalized.contains('NOT AVAILABLE') ||
        normalized.contains('UNAVAILABLE') ||
        normalized.contains('ERROR')) {
      return PrinterOnlineStatus.offline;
    }
    if (normalized.contains('OK') ||
        normalized.contains('READY') ||
        normalized.contains('IDLE') ||
        normalized.contains('ONLINE')) {
      return PrinterOnlineStatus.online;
    }
    return PrinterOnlineStatus.unknown;
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
