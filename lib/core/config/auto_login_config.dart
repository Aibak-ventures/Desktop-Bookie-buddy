/// Compile-time auto-login credentials for local dev, supplied via
/// --dart-define (see .vscode/launch.json → "Flutter: Run Dev (Auto Login)").
///
/// Both defaults are empty, so auto-login is a no-op unless explicitly
/// overridden — production and default dev runs are unaffected.
class AutoLoginConfig {
  const AutoLoginConfig._();

  static const String phone = String.fromEnvironment('AUTO_PHONE');
  static const String password = String.fromEnvironment('AUTO_PASSWORD');

  static bool get isEnabled => phone.isNotEmpty && password.isNotEmpty;
}
