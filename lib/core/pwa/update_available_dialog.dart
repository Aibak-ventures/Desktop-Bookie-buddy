import 'package:bookie_buddy_web/core/pwa/pwa_update_service.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

void showUpdateAvailableDialog(BuildContext context) {
  showGeneralDialog<void>(
    context: context,
    barrierDismissible: false,
    barrierLabel: 'update',
    barrierColor: Colors.black.withValues(alpha: 0.4),
    transitionDuration: Duration.zero,
    pageBuilder: (_, __, ___) => const _UpdateAvailableDialog(),
  );
}

class _UpdateAvailableDialog extends StatelessWidget {
  const _UpdateAvailableDialog();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        width: 360,
        padding: const EdgeInsets.all(28),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: AppColors.purpleLight,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.system_update_alt_rounded,
                color: AppColors.purple,
                size: 26,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'New Update Available',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'A newer version of Bookie Buddy has been released. Refresh now to get the latest version.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 13, color: AppColors.grey),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Later'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: PwaUpdateService.reload,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.purple,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Refresh Now'),
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
