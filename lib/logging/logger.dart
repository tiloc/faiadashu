import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart' as logging;

import 'logging.dart';

/// This logger is used consistently throughout the library.
/// It is designed to map to dart:logger, dart:developer, etc.
///
/// It will send to logging package (which by default does nothing).
class Logger {
  final String name;
  late final logging.Logger loggingLogger;

  factory Logger(Type name) {
    return Logger._('fdash.$name');
  }

  factory Logger.tag(String tag) {
    return Logger._('fdash.$tag');
  }

  Logger._(this.name) : loggingLogger = logging.Logger(name);

  /// Log. See dart:developer log for meaning of params.
  void warn(
    String message, {
    DateTime? time,
    int? sequenceNumber,
    Zone? zone,
    Object? error,
    StackTrace? stackTrace,
  }) {
    loggingLogger.log(LogLevel.warn, message, error, stackTrace, zone);
  }

  /// Log. See dart:developer log for meaning of params.
  void error(
    String message, {
    DateTime? time,
    int? sequenceNumber,
    Zone? zone,
    Object? error,
    StackTrace? stackTrace,
  }) {
    loggingLogger.log(LogLevel.error, message, error, stackTrace, zone);
  }

  /// Log. See dart:developer log for meaning of params.
  void trace(
    String message, {
    DateTime? time,
    int? sequenceNumber,
    Zone? zone,
  }) {
    if (kDebugMode) {
      // Can the compiler kill this code on prod builds?
      loggingLogger.log(LogLevel.trace, message, null, null, zone);
    }
  }

  /// Log. See dart:developer log for meaning of params.
  void info(
    String message, {
    DateTime? time,
    int? sequenceNumber,
    Zone? zone,
  }) {
    // Can the compiler kill this code on prod builds?
    loggingLogger.log(LogLevel.info, message, null, null, zone);
  }

  /// Log. See dart:developer log for meaning of params.
  void debug(
    String message, {
    DateTime? time,
    int? sequenceNumber,
    Zone? zone,
  }) {
    if (kDebugMode) {
      // Can the compiler kill this code on prod builds?
      loggingLogger.log(LogLevel.debug, message, null, null, zone);
    }
  }
}
