import 'package:bookie_buddy_web/core/constants/app_constants.dart';
import 'package:bookie_buddy_web/core/di/app_dependencies.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:bookie_buddy_core/features/thermal_printer/domain/entities/print_ticket_entity/print_ticket_entity.dart';
import 'package:bookie_buddy_web/features/printer/domain/entities/printer_bridge_status_enum.dart';
import 'package:bookie_buddy_web/features/printer/domain/entities/printer_device_entity/printer_device_entity.dart';
import 'package:bookie_buddy_web/features/printer/domain/entities/printer_device_entity/printer_online_status.dart';
import 'package:bookie_buddy_web/features/printer/presentation/print/bloc/qz_printer_cubit/qz_printer_cubit.dart';
import 'package:bookie_buddy_web/features/printer/presentation/print/widgets/printer_list_card.dart';
import 'package:bookie_buddy_web/utils/extensions/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

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
        actions: [
          BlocBuilder<QzPrinterCubit, QzPrinterState>(
            buildWhen: (previous, current) =>
                previous.status != current.status ||
                previous.refreshingPrinters != current.refreshingPrinters,
            builder: (context, state) {
              final canRefresh =
                  (state.status == PrinterBridgeStatus.connected ||
                      state.status == PrinterBridgeStatus.error) &&
                  !state.refreshingPrinters;
              return IconButton(
                tooltip: 'Refresh printer list',
                icon: state.refreshingPrinters
                    ? const SizedBox(
                        height: 18,
                        width: 18,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.refresh),
                onPressed: canRefresh
                    ? () => context.read<QzPrinterCubit>().refreshPrinters()
                    : null,
              );
            },
          ),
        ],
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
        },
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
                  onPressed: () =>
                      launchUrl(Uri.parse(AppConstants.qzTrayDownloadUrl)),
                  child: const Text('Download QZ Tray'),
                ),
                ElevatedButton(
                  onPressed: onRetry,
                  child: const Text(
                    'Retry',
                    style: TextStyle(color: AppColors.white),
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
              ? _EmptyPrintersView(onRefresh: () => cubit.refreshPrinters())
              : RefreshIndicator(
                  onRefresh: cubit.refreshPrinters,
                  child: ListView.separated(
                    padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
                    itemCount: state.printers.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 10),
                    itemBuilder: (context, index) {
                      final printer = state.printers[index];
                      final selected =
                          printer.name == state.selectedPrinterName;
                      final connected =
                          printer.name == state.lastUsedPrinterName;
                      return PrinterListCard(
                        name: printer.name,
                        onlineStatus: printer.onlineStatus,
                        selected: selected,
                        connected: connected,
                        busy: busy,
                        onTap: busy ? null : () => cubit.selectPrinter(printer),
                        onConnect: busy || connected
                            ? null
                            : () => _connect(context, cubit, printer),
                        onDisconnect: busy || !connected
                            ? null
                            : () => cubit.disconnectPrinter(),
                      );
                    },
                  ),
                ),
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
            color: AppColors.surface,
            border: Border(top: BorderSide(color: AppColors.greyBorder)),
          ),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 360, minHeight: 52),
              child: ElevatedButton.icon(
                onPressed: state.selectedPrinterName == null || busy
                    ? null
                    : () => ticket != null
                          ? cubit.print(ticket!)
                          : _saveDefault(context, cubit),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(52),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(26),
                  ),
                ),
                icon: busy
                    ? const SizedBox.shrink()
                    : Icon(
                        ticket != null ? Icons.print : Icons.save_outlined,
                        color: AppColors.white,
                        size: 20,
                      ),
                label: busy
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: AppColors.white,
                        ),
                      )
                    : Text(
                        ticket != null ? 'Print' : 'Save as default printer',
                        style: const TextStyle(
                          color: AppColors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _connect(
    BuildContext context,
    QzPrinterCubit cubit,
    PrinterDeviceEntity printer,
  ) async {
    final connected = await cubit.connectToPrinter(printer);
    if (!connected || !context.mounted) return;
    if (printer.onlineStatus == PrinterOnlineStatus.offline) {
      context.showSnackBar(
        'Set ${printer.name} as default, but it looks offline right now — '
        'check it\'s powered on before printing.',
        isError: true,
      );
    } else {
      context.showSnackBar('Connected to ${printer.name}.');
    }
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
      color: AppColors.redLight,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        children: [
          const Icon(Icons.error_outline, color: AppColors.red, size: 18),
          const SizedBox(width: 8),
          Expanded(
            child: Text(message, style: const TextStyle(color: AppColors.red)),
          ),
          TextButton(
            onPressed: onRetry,
            style: TextButton.styleFrom(foregroundColor: AppColors.red),
            child: const Text('Retry'),
          ),
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
