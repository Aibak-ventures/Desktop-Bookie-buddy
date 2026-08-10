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

/// Screen that lets the user pick (and print to) a QZ Tray printer.
///
/// Two modes, driven by whether [ticket] is passed:
/// - **Print mode** (`ticket` non-null) — caller (booking/sale detail
///   screen, etc.) built a [PrintTicketEntity] via `PrintTicketBuilder` +
///   `ReceiptCanvas` and wants it printed now; this is the fallback when
///   `printReceiptQuickly` (the no-navigation fast path) fails or nothing
///   is configured yet. Bottom action is "Print".
/// - **Setup mode** (`ticket` null) — reached from Settings any time, to
///   connect/switch the default printer with nothing to print yet. Bottom
///   action is "Save as default printer".
///
/// Mirrors the mobile app's `ThermalPrintScreen`, minus rich device cards
/// (QZ has no connection-type/address to show) and reconnect/lifecycle
/// complexity (no persistent per-device connection — see `QzPrinterCubit`
/// doc).
class QzPrintScreen extends StatelessWidget {
  const QzPrintScreen({super.key, this.ticket});

  final PrintTicketEntity? ticket;

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

  final PrintTicketEntity? ticket;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(ticket != null ? 'Print Receipt' : 'Printer Setup'),
      ),
      body: BlocConsumer<QzPrinterCubit, QzPrinterState>(
        listener: (context, state) {
          if (state.status == PrinterBridgeStatus.error &&
              state.errorMessage != null) {
            context.showSnackBar(state.errorMessage!, isError: true);
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

  final PrintTicketEntity? ticket;
  final QzPrinterState state;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<QzPrinterCubit>();
    final busy = state.status == PrinterBridgeStatus.printing;

    return Column(
      children: [
        if (state.status == PrinterBridgeStatus.error)
          _InlineErrorBanner(
            message: state.errorMessage ?? 'Something went wrong.',
            onRetry: () => cubit.initialize(),
          ),
        Expanded(
          child: state.printers.isEmpty
              ? _EmptyPrintersView(onRefresh: () => cubit.initialize())
              : RefreshIndicator(
                  onRefresh: cubit.initialize,
                  child: ListView.builder(
                    itemCount: state.printers.length,
                    itemBuilder: (context, index) {
                      final printer = state.printers[index];
                      final selected =
                          printer.name == state.selectedPrinterName;
                      final isDefault =
                          printer.name == state.lastUsedPrinterName;
                      return ListTile(
                        title: Text(printer.name),
                        subtitle: isDefault ? const Text('Default') : null,
                        leading: Icon(
                          selected
                              ? Icons.radio_button_checked
                              : Icons.radio_button_unchecked,
                        ),
                        onTap: busy ? null : () => cubit.selectPrinter(printer),
                      );
                    },
                  ),
                ),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: state.selectedPrinterName == null || busy
                  ? null
                  : () => ticket != null
                      ? cubit.print(ticket!)
                      : _saveDefault(context, cubit),
              child: busy
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : Text(
                      ticket != null ? 'Print' : 'Save as default printer',
                      style: const TextStyle(color: Colors.white),
                    ),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _saveDefault(BuildContext context, QzPrinterCubit cubit) async {
    final saved = await cubit.saveSelectedPrinter();
    if (saved && context.mounted) {
      context.showSnackBar('Default printer saved.');
    }
  }
}

class _InlineErrorBanner extends StatelessWidget {
  const _InlineErrorBanner({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.red.shade50,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        children: [
          Icon(Icons.error_outline, color: Colors.red.shade700, size: 18),
          const SizedBox(width: 8),
          Expanded(
            child: Text(message, style: TextStyle(color: Colors.red.shade700)),
          ),
          TextButton(onPressed: onRetry, child: const Text('Retry')),
        ],
      ),
    );
  }
}

class _EmptyPrintersView extends StatelessWidget {
  const _EmptyPrintersView({required this.onRefresh});

  final VoidCallback onRefresh;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.print_outlined, size: 40),
            const SizedBox(height: 12),
            const Text(
              'No printers found on this computer.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            OutlinedButton.icon(
              onPressed: onRefresh,
              icon: const Icon(Icons.refresh),
              label: const Text('Refresh'),
            ),
          ],
        ),
      ),
    );
  }
}
