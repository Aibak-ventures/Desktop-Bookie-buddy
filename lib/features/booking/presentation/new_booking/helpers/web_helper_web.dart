import 'dart:js_interop';

import 'package:web/web.dart' as web;

/// Web-specific implementation using package:web
/// Prevents accidental browser close/refresh when there are unsaved changes

JSFunction? _beforeUnloadListener;

void setupBeforeUnloadListener(bool Function() hasUnsavedChanges) {
  // Remove any existing listener first
  removeBeforeUnloadListener();

  // Create and store the listener
  final listener = ((web.BeforeUnloadEvent e) {
    if (hasUnsavedChanges()) {
      // preventDefault + returnValue triggers the browser's confirmation dialog
      e.preventDefault();
      e.returnValue =
          'You have unsaved changes. Are you sure you want to leave?';
    }
  }).toJS;
  _beforeUnloadListener = listener;

  // Add the listener to window
  web.window.addEventListener('beforeunload', listener);
}

void removeBeforeUnloadListener() {
  final listener = _beforeUnloadListener;
  if (listener != null) {
    web.window.removeEventListener('beforeunload', listener);
    _beforeUnloadListener = null;
  }
}
