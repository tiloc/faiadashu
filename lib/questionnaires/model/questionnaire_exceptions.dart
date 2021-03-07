class DataFormatException implements Exception {
  /// A human-readable message
  final String message;

  /// The offending data element
  final dynamic element;

  /// A throwable
  final dynamic? cause;
  DataFormatException(this.message, this.element, [this.cause]);
}
