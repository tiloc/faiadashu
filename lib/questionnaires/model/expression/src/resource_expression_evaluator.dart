import 'package:faiadashu/questionnaires/model/expression/expression.dart';
import 'package:fhir/r4/resource/resource.dart';

class ResourceExpressionEvaluator extends ExpressionEvaluator {
  final Resource? Function() resourceBuilder;

  @override
  dynamic evaluate({int? generation}) {
    final resource = resourceBuilder.call()?.toJson();

    return [resource];
  }

  ResourceExpressionEvaluator(
    String name,
    this.resourceBuilder, {
    String? debugLabel,
  }) : super(
          name,
          [],
          debugLabel: debugLabel,
        );
}
