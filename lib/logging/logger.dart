import 'dart:async';

import 'package:logging/logging.dart' as logging;

import 'logging.dart';

/// This logger is used consistently throughout the library.
/// It is designed to map to dart:logger, dart:developer, etc.
///
/// It will send to logging package (which by default does nothing).
class Logger {
  final String name;
  late final logging.Logger loggingLogger;

  factory Logger(String name) {
    return Logger._('fdash.$name');
  }

  Logger._(this.name) : loggingLogger = logging.Logger(name);

  /// Log. See dart:developer log for meaning of params.
  void log(
    String message, {
    DateTime? time,
    int? sequenceNumber,
    logging.Level level = LogLevel.info,
    Zone? zone,
    Object? error,
    StackTrace? stackTrace,
  }) {
    {
      loggingLogger.log(level, message, error, stackTrace, zone);
    }
  }
}
