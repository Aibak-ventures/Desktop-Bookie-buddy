import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:bookie_buddy_web/features/printer/domain/entities/printer_device_entity/printer_online_status.dart';
import 'package:flutter/material.dart';

/// A single printer row — tapping the card only highlights it; connecting
/// requires the explicit "Connect" button.
class PrinterListCard extends StatelessWidget {
  const PrinterListCard({
    required this.name,
    required this.onlineStatus,
    required this.selected,
    required this.connected,
    required this.busy,
    required this.onTap,
    required this.onConnect,
    required this.onDisconnect,
  });

  final String name;
  final PrinterOnlineStatus onlineStatus;
  final bool selected;
  final bool connected;
  final bool busy;
  final VoidCallback? onTap;
  final VoidCallback? onConnect;
  final VoidCallback? onDisconnect;

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
            border: Border.all(
              color: selected ? AppColors.purpleAccent : AppColors.greyBorder,
              width: selected ? 1.5 : 1,
            ),
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
              if (connected) ...[
                Chip(
                  label: const Text('In use'),
                  backgroundColor: AppColors.grey100,
                  visualDensity: VisualDensity.compact,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                const SizedBox(width: 8),
              ],

              if (connected)
                ElevatedButton.icon(
                  onPressed: onDisconnect,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.redTomato,
                    foregroundColor: AppColors.white,
                  ),
                  icon: const Icon(
                    Icons.link_off,
                    size: 16,
                    color: AppColors.white,
                  ),
                  label: const Text('Disconnect'),
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
