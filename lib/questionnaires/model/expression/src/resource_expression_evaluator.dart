import 'package:fhir/r4/resource/resource.dart';

import 'expression_evaluator.dart';

class ResourceExpressionEvaluator extends ExpressionEvaluator {
  final Resource? Function() resourceBuilder;

  @override
  Future<dynamic> fetchValue() {
    final resource = resourceBuilder.call()?.toJson();

    return Future.value([resource]);
  }

  ResourceExpressionEvaluator(
    String name,
    this.resourceBuilder,
    Iterable<ExpressionEvaluator> upstreamExpressions,
  ) : super(name, upstreamExpressions);
}
