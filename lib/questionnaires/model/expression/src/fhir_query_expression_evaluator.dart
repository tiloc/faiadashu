import 'package:faiadashu/faiadashu.dart';

class FhirQueryExpressionEvaluator extends FhirExpressionEvaluator {
  FhirQueryExpressionEvaluator(
    super.fhirExpression,
    super.upstreamExpressions, {
    super.debugLabel,
  });

  @override
  dynamic evaluate({int? generation}) {
    // TODO: implement evaluate
    return [];
  }
}
