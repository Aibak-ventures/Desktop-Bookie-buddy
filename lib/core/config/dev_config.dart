import 'package:flutter/foundation.dart' show kReleaseMode;

/// General-purpose compile-time dev toggles, supplied via --dart-define.
/// Add new flags here unless one grows specific enough to warrant its own
/// config class (see AutoLoginConfig).
///
/// Each flag below is set the same way: pass
/// `--dart-define=<FLAG_NAME>=<value>` to `flutter run`/`flutter build`
/// (or add it to a launch config's `toolArgs` — see .vscode/launch.json).
/// e.g. `flutter run --dart-define=PROD=false --dart-define=MOCK_PRINTER=true`
class DevConfig {
  const DevConfig._();

  /// Skips straight past the onboarding screen on splash, regardless of
  /// the persisted onboarding flag. Off by default.
  static const bool skipOnboarding = bool.fromEnvironment('SKIP_ONBOARDING');

  /// Verbose request/response logging (bodies, headers, per-request prints).
  /// Opt-in — off by default even in debug builds, since every request's
  /// full payload printed to console is more noise than most debugging
  /// sessions want. Error logging is unaffected by this flag; it always
  /// happens in debug builds, and via the production error interceptor
  /// in debug/production builds respectively.
  static const bool showFullNetworkLog = bool.fromEnvironment(
    'FULL_NETWORK_LOG',
  );

  /// Whether the app should behave as a production build (prod API base
  /// URL, etc). Defaults to prod on release builds, dev on debug builds;
  /// override explicitly to test either mode in the other build type.
  static const bool isProduction = bool.fromEnvironment(
    'PROD',
    defaultValue: kReleaseMode,
  );

  /// Uses a mock printer for the printer picker/print flow instead of a
  /// real QZ Tray connection — for testing without physical hardware.
  /// Off by default.
  static const bool useMockPrinter = bool.fromEnvironment('MOCK_PRINTER');
}
