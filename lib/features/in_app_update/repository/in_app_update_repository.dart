import 'package:bookie_buddy_web/core/navigation/navigations.dart';
import 'package:bookie_buddy_web/features/in_app_update/services/in_app_update_service.dart';
import 'package:bookie_buddy_web/features/in_app_update/view/show_ios_app_update_dialog.dart';
import 'package:flutter/foundation.dart';
import 'package:package_info_plus/package_info_plus.dart';

class InAppUpdateRepository {
  static final _service = InAppUpdateService();
  static final _context = navigatorKey.currentContext!;

  /// Checks if an app update is available and initiates the update process.
  ///
  /// For Android, it forces an immediate update if available.
  /// For iOS, it shows a dialog prompting the user to update via the App Store.
  /// Logs a message if no update is available.
  static Future<void> runInAppUpdate() async {
    final isUpdateAvailable = await _service.checkForUpdate();

    if (!isUpdateAvailable) {
      debugPrint("🎉 No update available!");
      return;
    }

    if (defaultTargetPlatform == TargetPlatform.android) {
      await _service.forceUpdate(_context);
    } else if (defaultTargetPlatform == TargetPlatform.iOS) {
      final app = await PackageInfo.fromPlatform();
      await showIOSUpdateDialog(
        _context,
        _service.redirectToAppStore,
        currentVersion: app.version,
        latestVersion: _service.appStoreVersion ?? 'Check in App Store',
      );
    }
    debugPrint("🎉 Update available!");
  }
}
