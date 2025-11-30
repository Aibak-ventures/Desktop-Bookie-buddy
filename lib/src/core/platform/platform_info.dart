/// Platform detection utility
/// 
/// Provides safe platform checks for multi-platform support.
/// Use this instead of dart:io Platform to avoid web compatibility issues.
class PlatformInfo {
  // This will be implemented with conditional imports
  // For now, we'll use a simple implementation
  
  static const bool isWeb = bool.fromEnvironment('dart.library.js_util');
  static const bool isDesktop = !isWeb;
  
  /// Check if running on Windows desktop
  static bool get isWindows => isDesktop && _checkWindows();
  
  /// Check if running on macOS desktop
  static bool get isMacOS => isDesktop && _checkMacOS();
  
  /// Check if running on Linux desktop
  static bool get isLinux => isDesktop && _checkLinux();
  
  // Platform-specific checks (will be implemented with conditional imports)
  static bool _checkWindows() => false; // TODO: Implement with dart:io conditionally
  static bool _checkMacOS() => false;   // TODO: Implement with dart:io conditionally
  static bool _checkLinux() => false;   // TODO: Implement with dart:io conditionally
}
