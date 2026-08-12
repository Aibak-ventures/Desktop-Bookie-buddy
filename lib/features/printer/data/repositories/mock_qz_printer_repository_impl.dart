import 'dart:developer';
import 'dart:math' show Random;

import 'package:bookie_buddy_web/features/printer/data/models/printer_device_model/printer_device_model.dart';
import 'package:bookie_buddy_web/features/printer/domain/entities/print_ticket_entity/print_ticket_entity.dart';
import 'package:bookie_buddy_web/features/printer/domain/entities/printer_device_entity/printer_device_entity.dart';
import 'package:bookie_buddy_web/features/printer/domain/repositories/i_printer_repository.dart';
import 'package:bookie_buddy_web/utils/shared_preference_helper.dart';

const _logName = 'MockQzPrinter';

/// Fake printer names returned by [MockQzPrinterRepositoryImpl.findPrinters]
/// — a mix of common thermal printer models so the picker UI looks
/// realistic during local dev/testing.
const _fakePrinterNames = [
  'EPSON TM-T88VI',
  'XPrinter XP-58',
  'Star TSP143III',
  'Rongta RP80',
];

const _lastPrinterPrefKey = 'last_used_qz_printer_name';

/// Fake [IPrinterRepository] for local development/testing when QZ Tray
/// and/or a physical printer aren't available — e.g. no thermal printer on
/// hand, or working from a machine without QZ Tray installed.
///
/// Simulates the same async shape as [QzPrinterRepositoryImpl]
/// (network-ish delays, occasional failures) so the picker/print screens
/// can be exercised end-to-end without a real bridge. Swap it in via
/// `PrinterDependencies.register(useMock: true)` — **never** ship with the
/// mock wired in for production builds.
///
/// See `QzPrinterRepositoryImpl` for the real implementation this mirrors.
class MockQzPrinterRepositoryImpl implements IPrinterRepository {
  MockQzPrinterRepositoryImpl(this._prefs);

  final SharedPreferenceHelper _prefs;

  @override
  Future<bool> isBridgeAvailable() async {
    await _delay();
    log('isBridgeAvailable() -> true (mock)', name: _logName);
    return true;
  }

  @override
  Future<void> connectToBridge() async {
    await _delay();
    log('connectToBridge() -> connected (mock)', name: _logName);
  }

  @override
  Future<List<PrinterDeviceEntity>> findPrinters() async {
    await _delay();
    log('findPrinters() -> ${_fakePrinterNames.length} fake printer(s)',
        name: _logName);
    return _fakePrinterNames
        .map((name) => PrinterDeviceModel(name: name).toEntity())
        .toList();
  }

  @override
  Future<void> print(String printerName, PrintTicketEntity ticket) async {
    log(
      'print() "$printerName", ${ticket.commands.length} command(s) (mock)',
      name: _logName,
    );
    await _delay(longer: true);
    if (!_fakePrinterNames.contains(printerName)) {
      throw Exception('Unknown mock printer "$printerName"');
    }
    // Occasionally simulate a real-world hiccup (offline/out-of-paper) so
    // the error banner/snackbar paths can be tested too.
    if (Random().nextDouble() < 0.1) {
      throw Exception('Mock printer "$printerName" is offline (simulated).');
    }
    log('print() succeeded (mock)', name: _logName);
  }

  @override
  Future<void> saveLastPrinter(String printerName) =>
      _prefs.instance.setString(_lastPrinterPrefKey, printerName);

  @override
  Future<String?> getLastPrinter() async =>
      _prefs.instance.getString(_lastPrinterPrefKey);

  @override
  Future<void> clearLastPrinter() =>
      _prefs.instance.remove(_lastPrinterPrefKey);

  Future<void> _delay({bool longer = false}) => Future.delayed(
        Duration(milliseconds: longer ? 900 : 400),
      );
}
