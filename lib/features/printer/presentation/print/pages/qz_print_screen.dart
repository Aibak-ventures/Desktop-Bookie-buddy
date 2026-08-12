import 'package:bookie_buddy_web/core/di/app_dependencies.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:bookie_buddy_web/features/printer/domain/entities/print_ticket_entity/print_ticket_entity.dart';
import 'package:bookie_buddy_web/features/printer/domain/entities/printer_bridge_status_enum.dart';
import 'package:bookie_buddy_web/features/printer/domain/entities/printer_device_entity/printer_device_entity.dart';
import 'package:bookie_buddy_web/features/printer/domain/entities/printer_device_entity/printer_online_status.dart';
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
                  onPressed: () => launchUrl(Uri.parse(_qzTrayDownloadUrl)),
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
        if (state.lastUsedPrinterName != null)
          _ConnectedPrinterBanner(
            printerName: state.lastUsedPrinterName!,
            busy: busy,
            onDisconnect: () => cubit.disconnectPrinter(),
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
                      return _PrinterCard(
                        name: printer.name,
                        onlineStatus: printer.onlineStatus,
                        selected: selected,
                        connected: connected,
                        busy: busy,
                        onTap: busy ? null : () => cubit.selectPrinter(printer),
                        onConnect: busy || connected
                            ? null
                            : () => _connect(context, cubit, printer),
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

/// Banner showing the printer currently saved as default, with a
/// disconnect action — separate from row selection/highlighting.
class _ConnectedPrinterBanner extends StatelessWidget {
  const _ConnectedPrinterBanner({
    required this.printerName,
    required this.busy,
    required this.onDisconnect,
  });

  final String printerName;
  final bool busy;
  final VoidCallback onDisconnect;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.fromLTRB(16, 12, 16, 0),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.purpleLightShade,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.purpleAccent),
      ),
      child: Row(
        children: [
          const Icon(Icons.check_circle, color: AppColors.purple, size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Connected printer',
                  style: TextStyle(fontSize: 11, color: AppColors.grey600),
                ),
                Text(
                  printerName,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    color: AppColors.black87,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          TextButton.icon(
            onPressed: busy ? null : onDisconnect,
            style: TextButton.styleFrom(foregroundColor: AppColors.red),
            icon: const Icon(Icons.link_off, size: 16),
            label: const Text('Disconnect'),
          ),
        ],
      ),
    );
  }
}

/// A single printer row — tapping the card only highlights it; connecting
/// requires the explicit "Connect" button.
class _PrinterCard extends StatelessWidget {
  const _PrinterCard({
    required this.name,
    required this.onlineStatus,
    required this.selected,
    required this.connected,
    required this.busy,
    required this.onTap,
    required this.onConnect,
  });

  final String name;
  final PrinterOnlineStatus onlineStatus;
  final bool selected;
  final bool connected;
  final bool busy;
  final VoidCallback? onTap;
  final VoidCallback? onConnect;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.surface,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.greyBorder, width: 1),
          ),
          child: Row(
            children: [
              Icon(
                Icons.print_outlined,
                color: selected ? AppColors.purple : AppColors.grey600,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        color: AppColors.black87,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 2),
                      child: _StatusBadge(status: onlineStatus),
                    ),
                    if (connected)
                      Padding(
                        padding: const EdgeInsets.only(top: 2),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.check_circle,
                              size: 13,
                              color: AppColors.purple,
                            ),
                            const SizedBox(width: 4),
                            const Text(
                              'Connected',
                              style: TextStyle(
                                fontSize: 12,
                                color: AppColors.purple,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              if (connected)
                Chip(
                  label: const Text('In use'),
                  backgroundColor: AppColors.grey100,
                  visualDensity: VisualDensity.compact,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                )
              else
                OutlinedButton(
                  onPressed: onConnect,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.purple,
                    side: const BorderSide(color: AppColors.purple),
                  ),
                  child: const Text('Connect'),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Small dot + label reflecting [PrinterOnlineStatus] — never blocks
/// selection/connect, just informs (see [_PrinterPickerView.build] doc for
/// why: some printers/drivers don't report status at all, so a hard
/// online-only filter would risk hiding a real, workable printer).
class _StatusBadge extends StatelessWidget {
  const _StatusBadge({required this.status});

  final PrinterOnlineStatus status;

  @override
  Widget build(BuildContext context) {
    final (color, label) = switch (status) {
      PrinterOnlineStatus.online => (AppColors.green, 'Online'),
      PrinterOnlineStatus.offline => (AppColors.red, 'Offline'),
      PrinterOnlineStatus.unknown => (AppColors.grey600, 'Status unknown'),
    };
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 7,
          height: 7,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 5),
        Text(label, style: TextStyle(fontSize: 12, color: color)),
      ],
    );
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
