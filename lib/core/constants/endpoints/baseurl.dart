import 'package:bookie_buddy_web/core/config/dev_config.dart';

const String _devBaseUrl = 'https://dev.bookiebuddy.in';
const String _prodBaseUrl = 'https://flutter.bookiebuddy.in';

const bool kIsProduction = DevConfig.isProduction;

/// Whether the app is running in development environment
const bool kIsDevelopment = !kIsProduction;

const String baseUrl = kIsProduction ? _prodBaseUrl : _devBaseUrl;
