// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

/// Web-specific implementation using dart:html
/// Prevents accidental browser close/refresh when there are unsaved changes

html.EventListener? _beforeUnloadListener;

void setupBeforeUnloadListener(bool Function() hasUnsavedChanges) {
  // Remove any existing listener first
  removeBeforeUnloadListener();

  // Create and store the listener
  _beforeUnloadListener = (html.Event e) {
    if (hasUnsavedChanges()) {
      // Set returnValue to trigger the browser's confirmation dialog
      (e as html.BeforeUnloadEvent).returnValue =
          'You have unsaved changes. Are you sure you want to leave?';
      return 'You have unsaved changes. Are you sure you want to leave?';
    }
  } as html.EventListener;

  // Add the listener to window
  html.window.addEventListener('beforeunload', _beforeUnloadListener!);
}

void removeBeforeUnloadListener() {
  if (_beforeUnloadListener != null) {
    html.window.removeEventListener('beforeunload', _beforeUnloadListener!);
    _beforeUnloadListener = null;
  }
}
