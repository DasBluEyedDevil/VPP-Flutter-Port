import 'dart:io' show Platform;

/// Device information utility for logging and debugging
/// 
/// Provides cross-platform device information for all Flutter platforms.
/// Adapts Android Build properties to dart:io Platform equivalents.
class DeviceInfo {
  DeviceInfo._(); // Private constructor - static class

  /// Get device operating system (e.g., "android", "ios", "windows")
  static String get operatingSystem => Platform.operatingSystem;

  /// Get device model/hostname
  /// Note: Unlike Android's Build.MODEL, this returns hostname on most platforms
  static String get model {
    try {
      return Platform.localHostname;
    } catch (e) {
      return 'unknown';
    }
  }

  /// Get OS version string (e.g., "12", "16.0", "10.0.19044")
  static String get osVersion => Platform.operatingSystemVersion;

  /// Get number of processors
  static int get numberOfProcessors => Platform.numberOfProcessors;

  /// Get locale (e.g., "en_US")
  static String get locale => Platform.localeName;

  /// Get full OS version string
  static String get osVersionFull => '$operatingSystem $osVersion';

  /// Get a formatted device info string for logging
  static String getFormattedInfo() {
    final buffer = StringBuffer();
    buffer.writeln('Device: $operatingSystem');
    buffer.writeln('Model/Hostname: $model');
    buffer.writeln('OS Version: $osVersion');
    buffer.writeln('Processors: $numberOfProcessors');
    buffer.writeln('Locale: $locale');
    return buffer.toString();
  }

  /// Get a compact one-line device description
  static String getCompactInfo() {
    return '$operatingSystem $model ($osVersion)';
  }

  /// Get device info as structured JSON string for metadata storage
  static String toJson() {
    return '{"operatingSystem":"$operatingSystem","model":"$model","osVersion":"$osVersion","numberOfProcessors":$numberOfProcessors,"locale":"$locale"}';
  }

  /// Check if running on Android platform
  static bool isAndroid() => Platform.isAndroid;

  /// Check if running on iOS platform
  static bool isIOS() => Platform.isIOS;

  /// Check if running on Windows platform
  static bool isWindows() => Platform.isWindows;

  /// Check if running on macOS platform
  static bool isMacOS() => Platform.isMacOS;

  /// Check if running on Linux platform
  static bool isLinux() => Platform.isLinux;

  /// Check if running on mobile platform (Android or iOS)
  static bool isMobile() => Platform.isAndroid || Platform.isIOS;

  /// Check if running on desktop platform (Windows, macOS, or Linux)
  static bool isDesktop() =>
      Platform.isWindows || Platform.isMacOS || Platform.isLinux;
}
