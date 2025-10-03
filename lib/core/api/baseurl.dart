// ignore_for_file: avoid_redundant_argument_values

import 'package:flutter/foundation.dart' show kReleaseMode;

const String _devBaseUrl = 'https://dev.bookiebuddy.in';
const String _prodBaseUrl = 'https://flutter.bookiebuddy.in';

// const baseUrl = _devBaseUrl; //development
// const baseUrl = _prodBaseUrl; //production

/// Compile-time switch: defaults to prod on release builds, dev on debug builds.
/// Override explicitly with: --dart-define=PROD=true|false
///
///* Dev run (default): flutter run
///* Dev run forced: flutter run --dart-define=PROD=false
///* Prod-like debug run: flutter run --dart-define=PROD=true
///* Release APK (prod default): flutter build apk --release
///* Release APK (dev override): flutter build apk --release --dart-define=PROD=false
const bool _isProd = bool.fromEnvironment('PROD', defaultValue: kReleaseMode);

const String baseUrl = _isProd ? _prodBaseUrl : _devBaseUrl;
