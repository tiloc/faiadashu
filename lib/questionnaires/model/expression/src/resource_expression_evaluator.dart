import 'package:faiadashu/questionnaires/model/expression/expression.dart';
import 'package:fhir/r4/resource/resource.dart';

class ResourceExpressionEvaluator extends ExpressionEvaluator {
  final Resource? Function() resourceBuilder;

  @override
  Future<dynamic> fetchValue() {
    final resource = resourceBuilder.call()?.toJson();

    return Future.value([resource]);
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
