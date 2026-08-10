import 'dart:developer';

import 'package:bookie_buddy_web/features/printer/domain/entities/print_ticket_entity/print_ticket_entity.dart';
import 'package:bookie_buddy_web/features/printer/domain/entities/printer_bridge_status_enum.dart';
import 'package:bookie_buddy_web/features/printer/domain/entities/printer_device_entity/printer_device_entity.dart';
import 'package:bookie_buddy_web/features/printer/domain/usecases/check_print_bridge_available_usecase.dart';
import 'package:bookie_buddy_web/features/printer/domain/usecases/find_printers_usecase.dart';
import 'package:bookie_buddy_web/features/printer/domain/usecases/get_last_printer_usecase.dart';
import 'package:bookie_buddy_web/features/printer/domain/usecases/print_receipt_usecase.dart';
import 'package:bookie_buddy_web/features/printer/domain/usecases/save_last_printer_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'qz_printer_cubit.freezed.dart';
part 'qz_printer_state.dart';

const _logName = 'QzPrinter';

/// Screen-scoped cubit (unlike mobile's app-wide `ThermalPrinterCubit`) —
/// QZ has no persistent per-device connection to keep alive across screens,
/// so there's nothing worth holding onto once the print screen closes. See
/// this feature's plan doc for why the state machine is simpler than
/// mobile's: "connect to QZ Tray if needed -> send bytes -> done", no
/// reconnect/lifecycle-observer complexity.
class QzPrinterCubit extends Cubit<QzPrinterState> {
  QzPrinterCubit({
    required this.checkBridgeAvailableUseCase,
    required this.findPrintersUseCase,
    required this.printReceiptUseCase,
    required this.getLastPrinterUseCase,
    required this.saveLastPrinterUseCase,
  }) : super(const QzPrinterState());

  final CheckPrintBridgeAvailableUseCase checkBridgeAvailableUseCase;
  final FindPrintersUseCase findPrintersUseCase;
  final PrintReceiptUseCase printReceiptUseCase;
  final GetLastPrinterUseCase getLastPrinterUseCase;
  final SaveLastPrinterUseCase saveLastPrinterUseCase;

  /// Call on screen entry. Checks the bridge, then — if available — loads
  /// the printer list and pre-selects the last-used printer (if it's still
  /// in the list).
  Future<void> initialize() async {
    log('initialize()', name: _logName);
    emit(state.copyWith(status: PrinterBridgeStatus.connecting));
    final available = await checkBridgeAvailableUseCase();
    if (!available) {
      log('QZ Tray unavailable', name: _logName);
      emit(
        state.copyWith(
          status: PrinterBridgeStatus.unavailable,
          printers: [],
          selectedPrinterName: null,
        ),
      );
      return;
    }

    try {
      final printers = await findPrintersUseCase();
      final lastPrinter = await getLastPrinterUseCase();
      final preselected =
          printers.any((p) => p.name == lastPrinter) ? lastPrinter : null;
      log(
        'Found ${printers.length} printer(s), preselected=$preselected',
        name: _logName,
      );
      emit(
        state.copyWith(
          status: PrinterBridgeStatus.connected,
          printers: printers,
          selectedPrinterName: preselected,
          lastUsedPrinterName: preselected,
        ),
      );
    } catch (e, stack) {
      log(
        'initialize() failed listing printers: $e',
        name: _logName,
        error: e,
        stackTrace: stack,
      );
      emit(
        state.copyWith(
          status: PrinterBridgeStatus.error,
          errorMessage: 'Could not list printers: $e',
        ),
      );
    }
  }

  void selectPrinter(PrinterDeviceEntity printer) {
    log('selectPrinter(${printer.name})', name: _logName);
    emit(state.copyWith(selectedPrinterName: printer.name));
  }

  /// Persists the selected printer as default without printing anything —
  /// used by the settings entry point (no [PrintTicketEntity] on hand),
  /// as opposed to [print], which saves as a side effect of a successful
  /// print job.
  Future<bool> saveSelectedPrinter() async {
    final printerName = state.selectedPrinterName;
    if (printerName == null) {
      log('saveSelectedPrinter() aborted — no printer selected',
          name: _logName);
      return false;
    }

    log('saveSelectedPrinter() -> "$printerName"', name: _logName);
    try {
      await saveLastPrinterUseCase(printerName);
      emit(state.copyWith(lastUsedPrinterName: printerName));
      return true;
    } catch (e, stack) {
      log(
        'saveSelectedPrinter() failed: $e',
        name: _logName,
        error: e,
        stackTrace: stack,
      );
      emit(
        state.copyWith(
          status: PrinterBridgeStatus.error,
          errorMessage: 'Could not save printer: $e',
        ),
      );
      return false;
    }
  }

  Future<bool> print(PrintTicketEntity ticket) async {
    final printerName = state.selectedPrinterName;
    if (printerName == null) {
      log('print() aborted — no printer selected', name: _logName);
      emit(
        state.copyWith(
          status: PrinterBridgeStatus.error,
          errorMessage: 'Select a printer first.',
        ),
      );
      return false;
    }

    log('print() -> "$printerName"', name: _logName);
    emit(state.copyWith(status: PrinterBridgeStatus.printing));
    try {
      await printReceiptUseCase(printerName, ticket);
      await saveLastPrinterUseCase(printerName);
      log('print() succeeded', name: _logName);
      emit(
        state.copyWith(
          status: PrinterBridgeStatus.connected,
          lastUsedPrinterName: printerName,
        ),
      );
      return true;
    } catch (e, stack) {
      log('print() failed: $e', name: _logName, error: e, stackTrace: stack);
      emit(
        state.copyWith(
          status: PrinterBridgeStatus.error,
          errorMessage: 'Print failed: $e',
        ),
      );
      return false;
    }
  }
}
