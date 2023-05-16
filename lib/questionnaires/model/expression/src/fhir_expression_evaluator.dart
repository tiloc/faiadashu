import 'package:faiadashu/questionnaires/model/expression/expression.dart';
import 'package:fhir/r4/metadata_types/metadata_types.dart';
import 'package:fhir/r4/resource/resource.dart';

abstract class FhirExpressionEvaluator extends ExpressionEvaluator {
  FhirExpressionEvaluator(
    FhirExpression fhirExpression,
    Iterable<ExpressionEvaluator> upstreamExpressions, {
    String? debugLabel,
  }) : super(
          // Using .value breaks on real-world content with invalid identifiers.
          fhirExpression.name?.toString(),
          upstreamExpressions,
          debugLabel: debugLabel,
        );

  factory FhirExpressionEvaluator.fromExpression(
    Resource? Function()? resourceBuilder,
    FhirExpression fhirExpression,
    Iterable<ExpressionEvaluator> upstreamExpressions, {
    Map<String, dynamic>? Function()? jsonBuilder,
    String? debugLabel,
  }) {
    switch (ArgumentError.checkNotNull(fhirExpression.language)) {
      case FhirExpressionLanguage.text_fhirpath:
        return FhirPathExpressionEvaluator(
          resourceBuilder,
          fhirExpression,
          upstreamExpressions,
          jsonBuilder: jsonBuilder,
          debugLabel: debugLabel,
        );
      case FhirExpressionLanguage.application_x_fhir_query:
        return FhirQueryExpressionEvaluator(
          fhirExpression,
          upstreamExpressions,
          debugLabel: debugLabel,
        );
      case FhirExpressionLanguage.text_cql:
      case FhirExpressionLanguage.unknown:
      default:
        throw UnsupportedError(
          'Expressions of type ${fhirExpression.language} are unsupported.',
        );
    }
  }
}
