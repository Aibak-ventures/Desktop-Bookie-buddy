// ignore: avoid_web_libraries_in_flutter, deprecated_member_use
import 'dart:html' as html;

void listenForPwaUpdates(void Function() onUpdate) {
  html.window.on['bookiebuddy-update'].listen((_) => onUpdate());
}

void reloadPage() {
  html.window.location.reload();
}
