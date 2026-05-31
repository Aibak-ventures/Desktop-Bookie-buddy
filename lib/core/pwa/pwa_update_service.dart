import 'pwa_update_service_stub.dart'
    if (dart.library.html) 'pwa_update_service_web.dart';

class PwaUpdateService {
  static void listenForUpdates(void Function() onUpdate) {
    listenForPwaUpdates(onUpdate);
  }

  static void reload() {
    reloadPage();
  }
}
