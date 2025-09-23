class SecureActionAuthSessionManager {
  const SecureActionAuthSessionManager();

  static DateTime? _lastVerifiedAt;

  static bool get isWithinGracePeriod {
    if (_lastVerifiedAt == null) return false;
    final now = DateTime.now();
    return now.difference(_lastVerifiedAt!).inSeconds < 60;
  }

  static void markVerified() {
    _lastVerifiedAt = DateTime.now();
  }

  static void reset() {
    _lastVerifiedAt = null;
  }
}
