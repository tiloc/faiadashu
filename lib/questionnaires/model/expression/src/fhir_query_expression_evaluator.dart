import 'package:faiadashu/faiadashu.dart';
import 'package:fhir/r4/metadata_types/metadata_types.dart';

class FhirQueryExpressionEvaluator extends FhirExpressionEvaluator {
  FhirQueryExpressionEvaluator(
    Expression fhirExpression,
    Iterable<ExpressionEvaluator> upstreamExpressions, {
    String? debugLabel,
  }) : super(
          fhirExpression,
          upstreamExpressions,
          debugLabel: debugLabel,
        );

  @override
  dynamic evaluate({int? generation}) {
    // TODO: implement evaluate
    return [];
  }
}
