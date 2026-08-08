import 'package:bookie_buddy_web/core/di/app_dependencies.dart';
import 'package:bookie_buddy_web/features/printer/domain/entities/print_ticket_entity/print_ticket_entity.dart';
import 'package:bookie_buddy_web/features/printer/domain/entities/printer_bridge_status_enum.dart';
import 'package:bookie_buddy_web/features/printer/presentation/print/bloc/qz_printer_cubit/qz_printer_cubit.dart';
import 'package:bookie_buddy_web/utils/extensions/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

/// Downloads page for QZ Tray — shown when the bridge isn't running.
const _qzTrayDownloadUrl = 'https://qz.io/download/';

/// Screen that lets the user pick a QZ Tray printer and print a
/// pre-built [PrintTicketEntity] (e.g. a rendered receipt). The caller
/// (booking/sale detail screen, etc.) builds the ticket via
/// `PrintTicketBuilder` + `ReceiptCanvas` and passes it in — this screen
/// only handles bridge/printer selection and the print action itself.
///
/// Mirrors the mobile app's `ThermalPrintScreen`, minus rich device cards
/// (QZ has no connection-type/address to show) and reconnect/lifecycle
/// complexity (no persistent per-device connection — see `QzPrinterCubit`
/// doc).
class QzPrintScreen extends StatelessWidget {
  const QzPrintScreen({super.key, required this.ticket});

  final PrintTicketEntity ticket;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<QzPrinterCubit>()..initialize(),
      child: _QzPrintView(ticket: ticket),
    );
  }
}

class _QzPrintView extends StatelessWidget {
  const _QzPrintView({required this.ticket});

  final PrintTicketEntity ticket;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Print Receipt')),
      body: BlocConsumer<QzPrinterCubit, QzPrinterState>(
        listener: (context, state) {
          if (state.status == PrinterBridgeStatus.error &&
              state.errorMessage != null) {
            context.showSnackBar(state.errorMessage!);
          }
        },
        builder: (context, state) {
          switch (state.status) {
            case PrinterBridgeStatus.unknown:
            case PrinterBridgeStatus.connecting:
              return const Center(child: CircularProgressIndicator());
            case PrinterBridgeStatus.unavailable:
              return _BridgeUnavailableView(
                onRetry: () => context.read<QzPrinterCubit>().initialize(),
              );
            case PrinterBridgeStatus.connected:
            case PrinterBridgeStatus.printing:
            case PrinterBridgeStatus.error:
              return _PrinterPickerView(ticket: ticket, state: state);
          }
        }, // exhaustive switch — analyzer error above resolves once
        // qz_printer_cubit.freezed.dart exists (adds `.status` etc.)
      ),
    );
  }
}

class _BridgeUnavailableView extends StatelessWidget {
  const _BridgeUnavailableView({required this.onRetry});

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.print_disabled, size: 48),
            const SizedBox(height: 16),
            const Text(
              "QZ Tray isn't running",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            const Text(
              'Install and start QZ Tray on this computer to print '
              'receipts, then retry.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            Wrap(
              spacing: 12,
              alignment: WrapAlignment.center,
              children: [
                OutlinedButton(
                  onPressed: () => launchUrl(Uri.parse(_qzTrayDownloadUrl)),
                  child: const Text('Download QZ Tray'),
                ),
                ElevatedButton(
                  onPressed: onRetry,
                  child: const Text(
                    'Retry',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _PrinterPickerView extends StatelessWidget {
  const _PrinterPickerView({required this.ticket, required this.state});

  final PrintTicketEntity ticket;
  final QzPrinterState state;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<QzPrinterCubit>();
    final printing = state.status == PrinterBridgeStatus.printing;

    if (state.printers.isEmpty) {
      return const Center(child: Text('No printers found on this computer.'));
    }

    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: state.printers.length,
            itemBuilder: (context, index) {
              final printer = state.printers[index];
              final selected = printer.name == state.selectedPrinterName;
              return ListTile(
                title: Text(printer.name),
                leading: Icon(
                  selected
                      ? Icons.radio_button_checked
                      : Icons.radio_button_unchecked,
                ),
                onTap: printing ? null : () => cubit.selectPrinter(printer),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: state.selectedPrinterName == null || printing
                  ? null
                  : () => cubit.print(ticket),
              child: printing
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Text('Print', style: TextStyle(color: Colors.white)),
            ),
          ),
        ),
      ],
    );
  }
}
