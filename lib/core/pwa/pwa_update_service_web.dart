import 'dart:js_interop';

import 'package:web/web.dart' as web;

void listenForPwaUpdates(void Function() onUpdate) {
  web.window.addEventListener(
    'bookiebuddy-update',
    ((web.Event _) => onUpdate()).toJS,
  );
}

void reloadPage() {
  web.window.location.reload();
}
