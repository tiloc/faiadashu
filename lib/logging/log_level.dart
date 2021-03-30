import 'package:logging/logging.dart' as logging;

/// Logging levels to be used with `dart:developer` log method.
class LogLevel {
  /// Tracing output: finely granular following of method enter/leave, intermediate checkpoints
  static const trace = logging.Level.FINEST;

  /// Debugging output
  static const debug = logging.Level.FINE;

  /// Info output
  static const info = logging.Level.INFO;

  /// Potentially problematic: Unsupported functionality, incomplete data, etc.
  static const warn = logging.Level.WARNING;

  /// Definitely a serious error.
  static const error = logging.Level.SEVERE;
}
