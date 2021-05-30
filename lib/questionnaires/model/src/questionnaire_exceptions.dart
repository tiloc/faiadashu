/// [Questionnaire] is internally inconsistent or invalid.
class QuestionnaireFormatException implements Exception {
  /// A human-readable message
  final String message;

  /// The offending data element
  final Object? element;

  /// A throwable
  final Object? cause;
  QuestionnaireFormatException(this.message, [this.element, this.cause]);

  @override
  String toString() {
    return (element != null) ? '$message: $element' : message;
  }
}
