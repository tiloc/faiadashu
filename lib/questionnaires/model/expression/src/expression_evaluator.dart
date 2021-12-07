import 'package:flutter/foundation.dart';

/// Evaluate an expression.
///
/// Takes other expressions - referred to as 'upstream' expressions into account.
abstract class ExpressionEvaluator with Diagnosticable {
  /// The name of the expression
  final String? name;

  final Iterable<ExpressionEvaluator> upstreamExpressions;

  /// Fetch the current value.
  ///
  /// This is async, as it might involve access to servers.
  Future<dynamic> fetchValue();

  ExpressionEvaluator(
    this.name,
    this.upstreamExpressions,
  );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);

    properties.add(StringProperty('name', name, ifEmpty: '-'));
    properties.add(IterableProperty('upstream', upstreamExpressions));
  }
}
