import 'package:fhir/r4/metadata_types/metadata_types.dart';
import 'package:fhir/r4/resource/resource.dart';

import 'expression_evaluator.dart';
import 'fhirpath_expression_evaluator.dart';

abstract class FhirExpressionEvaluator extends ExpressionEvaluator {
  FhirExpressionEvaluator(
    Expression fhirExpression,
    Iterable<ExpressionEvaluator> upstreamExpressions, {
    String? debugLabel,
  }) : super(
          fhirExpression.name?.value,
          upstreamExpressions,
          debugLabel: debugLabel,
        );

  factory FhirExpressionEvaluator.fromExpression(
    Resource? Function()? resourceBuilder,
    Expression fhirExpression,
    Iterable<ExpressionEvaluator> upstreamExpressions, {
    Map<String, dynamic>? Function()? jsonBuilder,
    String? debugLabel,
  }) {
    switch (ArgumentError.checkNotNull(fhirExpression.language)) {
      case ExpressionLanguage.text_fhirpath:
        return FhirPathExpressionEvaluator(
          resourceBuilder,
          fhirExpression,
          upstreamExpressions,
          jsonBuilder: jsonBuilder,
          debugLabel: debugLabel,
        );
      case ExpressionLanguage.application_x_fhir_query:
      case ExpressionLanguage.text_cql:
      case ExpressionLanguage.unknown:
        throw UnsupportedError(
          'Expressions of type ${fhirExpression.language} are unsupported.',
        );
    }
  }
}
