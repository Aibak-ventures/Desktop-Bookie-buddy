import 'dart:async';
import 'dart:developer';

import 'package:bookie_buddy_web/features/printer/domain/entities/print_ticket_entity/print_ticket_entity.dart';
import 'package:bookie_buddy_web/features/printer/domain/entities/printer_bridge_status_enum.dart';
import 'package:bookie_buddy_web/features/printer/domain/entities/printer_device_entity/printer_device_entity.dart';
import 'package:bookie_buddy_web/features/printer/domain/usecases/check_print_bridge_available_usecase.dart';
import 'package:bookie_buddy_web/features/printer/domain/usecases/clear_last_printer_usecase.dart';
import 'package:bookie_buddy_web/features/printer/domain/usecases/find_printers_usecase.dart';
import 'package:bookie_buddy_web/features/printer/domain/usecases/get_last_printer_usecase.dart';
import 'package:bookie_buddy_web/features/printer/domain/usecases/print_receipt_usecase.dart';
import 'package:bookie_buddy_web/features/printer/domain/usecases/refresh_printer_statuses_usecase.dart';
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
    required this.clearLastPrinterUseCase,
    required this.refreshPrinterStatusesUseCase,
  }) : super(const QzPrinterState());

  final CheckPrintBridgeAvailableUseCase checkBridgeAvailableUseCase;
  final FindPrintersUseCase findPrintersUseCase;
  final PrintReceiptUseCase printReceiptUseCase;
  final GetLastPrinterUseCase getLastPrinterUseCase;
  final SaveLastPrinterUseCase saveLastPrinterUseCase;
  final ClearLastPrinterUseCase clearLastPrinterUseCase;
  final RefreshPrinterStatusesUseCase refreshPrinterStatusesUseCase;

  /// Guards against a stale status refresh (from a superseded
  /// [initialize] call, e.g. pull-to-refresh fired twice) overwriting a
  /// newer printer list.
  int _statusRefreshToken = 0;

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
          errorMessage: null,
        ),
      );
      unawaited(_refreshStatuses(printers));
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

  /// Queries live status for [printers] and merges it into whatever
  /// printer list is current in state — dropped if a newer [initialize]
  /// call has already superseded [printers] (guarded by
  /// [_statusRefreshToken]) so a slow status query can't clobber a fresher
  /// list.
  Future<void> _refreshStatuses(List<PrinterDeviceEntity> printers) async {
    final token = ++_statusRefreshToken;
    try {
      final withStatus = await refreshPrinterStatusesUseCase(printers);
      if (token != _statusRefreshToken || isClosed) return;
      emit(state.copyWith(printers: withStatus));
    } catch (e, stack) {
      // Status is a best-effort enhancement — the plain printer list from
      // [initialize] already rendered, so a failed refresh just leaves
      // every printer's status as unknown rather than surfacing an error.
      log('_refreshStatuses() failed: $e', name: _logName, error: e, stackTrace: stack);
    }
  }

  /// Re-lists printers and re-checks their live status without leaving the
  /// picker (unlike [initialize], which briefly swaps the whole body for a
  /// spinner) — this is what the AppBar refresh button and pull-to-refresh
  /// call, so the user can confirm a printer just came online/offline
  /// without navigating away and back.
  Future<void> refreshPrinters() async {
    log('refreshPrinters()', name: _logName);
    emit(state.copyWith(refreshingPrinters: true));
    try {
      final printers = await findPrintersUseCase();
      final selected = state.selectedPrinterName != null &&
              printers.any((p) => p.name == state.selectedPrinterName)
          ? state.selectedPrinterName
          : null;
      emit(
        state.copyWith(
          printers: printers,
          selectedPrinterName: selected,
          refreshingPrinters: false,
          errorMessage: null,
        ),
      );
      await _refreshStatuses(printers);
    } catch (e, stack) {
      log(
        'refreshPrinters() failed: $e',
        name: _logName,
        error: e,
        stackTrace: stack,
      );
      emit(
        state.copyWith(
          refreshingPrinters: false,
          status: PrinterBridgeStatus.error,
          errorMessage: 'Could not refresh printers: $e',
        ),
      );
    }
  }

  void selectPrinter(PrinterDeviceEntity printer) {
    log('selectPrinter(${printer.name})', name: _logName);
    emit(state.copyWith(selectedPrinterName: printer.name));
  }

  /// Connects to [printer] — highlights it and immediately persists it as
  /// the default, without waiting for the bottom "Save"/"Print" action.
  /// This is what the per-row "Connect" button drives, as opposed to
  /// [selectPrinter], which only highlights.
  Future<bool> connectToPrinter(PrinterDeviceEntity printer) async {
    log('connectToPrinter(${printer.name})', name: _logName);
    emit(state.copyWith(selectedPrinterName: printer.name));
    return saveSelectedPrinter();
  }

  /// Clears the currently connected/default printer. Selection in the list
  /// (if any) is left as-is so the user can immediately connect to another
  /// one.
  Future<void> disconnectPrinter() async {
    log('disconnectPrinter()', name: _logName);
    try {
      await clearLastPrinterUseCase();
      emit(
        state.copyWith(
          lastUsedPrinterName: null,
          selectedPrinterName: null,
          errorMessage: null,
        ),
      );
    } catch (e, stack) {
      log(
        'disconnectPrinter() failed: $e',
        name: _logName,
        error: e,
        stackTrace: stack,
      );
      emit(
        state.copyWith(
          status: PrinterBridgeStatus.error,
          errorMessage: 'Could not disconnect printer: $e',
        ),
      );
    }
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
      emit(
        state.copyWith(lastUsedPrinterName: printerName, errorMessage: null),
      );
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
          errorMessage: null,
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
