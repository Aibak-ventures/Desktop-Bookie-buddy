import 'package:bookie_buddy_web/core/pwa/pwa_update_service_stub.dart'
    if (dart.library.js_interop) 'pwa_update_service_web.dart';

class PwaUpdateService {
  static void listenForUpdates(void Function() onUpdate) {
    listenForPwaUpdates(onUpdate);
  }

  static void reload() {
    reloadPage();
  }
}
