class LogLevel {
  /// Tracing output: finely granular following of method enter/leave, intermediate checkpoints
  static const trace = 300;

  /// Debugging output
  static const debug = 500;

  /// Info output
  static const info = 800;

  /// Potentially problematic: Unsupported functionality, incomplete data, etc.
  static const warn = 900;

  /// Definitely a serious error.
  static const error = 1000;
}
