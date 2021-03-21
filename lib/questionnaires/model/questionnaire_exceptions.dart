/// [Questionnaire] is internally inconsistent or invalid.
class QuestionnaireFormatException implements Exception {
  /// A human-readable message
  final String message;

  /// The offending data element
  final dynamic element;

  /// A throwable
  final dynamic? cause;
  QuestionnaireFormatException(this.message, this.element, [this.cause]);

  @override
  String toString() {
    return '$message: $element';
  }
}
