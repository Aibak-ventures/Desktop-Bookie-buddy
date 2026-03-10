import 'dart:developer';

import 'package:bookie_buddy_web/core/config/logger_config.dart';

extension ObjectX on Object? {
  void logInfo({String? before, String? after}) =>
      logIt.i('${before ?? ''}${this}${after ?? ''}');
  void logDebug({String? before, String? after}) =>
      log('${before ?? ''}${toString()}${after ?? ''}');
}
