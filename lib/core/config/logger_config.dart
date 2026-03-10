// import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

// Configure logger with pretty print
final logIt = Logger(
  printer: PrettyPrinter(
    methodCount: 0, // Number of stack trace lines
    errorMethodCount: 5, // For error stack trace
    lineLength: 100,
    colors: true,
    printEmojis: true,
    noBoxingByDefault: true,
    // dateTimeFormat: (time) => DateTimeFormat.onlyTimeAndSinceStart(time),
  ),
  // level: kReleaseMode ? Level.off : Level.debug,
);
