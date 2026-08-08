import 'dart:convert';
import 'dart:developer';

import 'package:bookie_buddy_web/features/printer/data/datasources/qz_tray_datasource.dart';
import 'package:bookie_buddy_web/features/printer/data/models/printer_device_model/printer_device_model.dart';
import 'package:bookie_buddy_web/features/printer/domain/entities/print_ticket_entity/print_ticket_entity.dart';
import 'package:bookie_buddy_web/features/printer/domain/entities/printer_device_entity/printer_device_entity.dart';
import 'package:bookie_buddy_web/features/printer/domain/repositories/i_printer_repository.dart';
import 'package:bookie_buddy_web/utils/shared_preference_helper.dart';
import 'package:esc_pos_utils_plus/esc_pos_utils_plus.dart' as epu;
import 'package:image/image.dart' as img;

const _logName = 'QzPrinter';

/// Shared preferences key for the last-used printer name. Plain
/// SharedPreferences (not secure storage) is enough here — a printer name
/// carries no sensitive information, unlike mobile's saved device, which
/// also isn't secret but reuses `SecureStorageHelper` for convenience
/// since that's what's already wired for the equivalent mobile feature.
const _lastPrinterPrefKey = 'last_used_qz_printer_name';

class QzPrinterRepositoryImpl implements IPrinterRepository {
  QzPrinterRepositoryImpl(this._datasource, this._prefs);

  final QzTrayDatasource _datasource;
  final SharedPreferenceHelper _prefs;

  @override
  Future<bool> isBridgeAvailable() => _datasource.isAvailable();

  @override
  Future<void> connectToBridge() => _datasource.connect();

  @override
  Future<List<PrinterDeviceEntity>> findPrinters() async {
    final names = await _datasource.findPrinters();
    return names
        .map((name) => PrinterDeviceModel(name: name).toEntity())
        .toList();
  }

  @override
  Future<void> print(String printerName, PrintTicketEntity ticket) async {
    log(
      'print() "$printerName", ${ticket.commands.length} command(s)',
      name: _logName,
    );
    final bytes = await _buildEscPosBytes(ticket);
    await _datasource.printRaw(printerName, base64Encode(bytes));
  }

  @override
  Future<void> saveLastPrinter(String printerName) =>
      _prefs.instance.setString(_lastPrinterPrefKey, printerName);

  @override
  Future<String?> getLastPrinter() async =>
      _prefs.instance.getString(_lastPrinterPrefKey);

  @override
  Future<void> clearLastPrinter() => _prefs.instance.remove(_lastPrinterPrefKey);

  // ---------------------------------------------------------------------
  // Mapping helpers
  // ---------------------------------------------------------------------

  /// Turns [ticket]'s commands into actual ESC/POS bytes via
  /// `esc_pos_utils_plus` — the only place in this feature that touches
  /// that library, mirroring how the mobile repository impl is the only
  /// place that touches `unified_esc_pos_printer`'s `Ticket`.
  Future<List<int>> _buildEscPosBytes(PrintTicketEntity ticket) async {
    final profile = await epu.CapabilityProfile.load();
    final generator = epu.Generator(
      _paperSizeToPackage(ticket.paperSize),
      profile,
    );

    final bytes = <int>[];
    for (final command in ticket.commands) {
      switch (command) {
        case PrintTicketImageCommand(:final rgba, :final width, :final height):
          final decoded = img.Image.fromBytes(
            width: width,
            height: height,
            bytes: rgba.buffer,
            order: img.ChannelOrder.rgba,
            numChannels: 4,
          );
          bytes.addAll(
            generator.imageRaster(decoded, align: epu.PosAlign.left),
          );
        case PrintTicketFeedCommand(:final lines):
          bytes.addAll(generator.feed(lines));
        case PrintTicketCutCommand():
          // esc_pos_utils_plus's cut() has no linesBefore/clearance param
          // of its own (unlike mobile's `unified_esc_pos_printer`) — feed
          // the same clearance explicitly first.
          bytes.addAll(generator.feed(command.linesBefore));
          bytes.addAll(generator.cut());
      }
    }
    return bytes;
  }

  epu.PaperSize _paperSizeToPackage(PrinterPaperSize size) => switch (size) {
    PrinterPaperSize.mm58 => epu.PaperSize.mm58,
    PrinterPaperSize.mm72 => epu.PaperSize.mm72,
    PrinterPaperSize.mm80 => epu.PaperSize.mm80,
  };
}
