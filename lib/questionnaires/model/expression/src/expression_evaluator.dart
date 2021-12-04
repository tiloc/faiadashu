/// Evaluate an expression.
///
/// Takes other expressions - referred to as 'upstream' expressions into account.
abstract class ExpressionEvaluator {
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
}
