/// Stub implementation for non-web platforms
/// These functions do nothing on mobile/desktop

void setupBeforeUnloadListener(bool Function() hasUnsavedChanges) {
  // No-op on non-web platforms
}

void removeBeforeUnloadListener() {
  // No-op on non-web platforms
}
