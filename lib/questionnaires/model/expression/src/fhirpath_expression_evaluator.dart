import 'package:fhir/r4/metadata_types/metadata_types.dart';
import 'package:fhir/r4/resource/resource.dart';
import 'package:fhir_path/run_fhir_path.dart';

import 'expression_evaluator.dart';
import 'fhir_expression_evaluator.dart';

class FhirPathExpressionEvaluator extends FhirExpressionEvaluator {
  final Resource? Function()? resourceBuilder;
  final String fhirpath;

  FhirPathExpressionEvaluator(
    this.resourceBuilder,
    Expression fhirpathExpression,
    Iterable<ExpressionEvaluator> upstreamExpressions,
  )   : fhirpath = ArgumentError.checkNotNull(fhirpathExpression.expression),
        super(
          fhirpathExpression,
          upstreamExpressions,
        ) {
    if (fhirpathExpression.language != ExpressionLanguage.text_fhirpath) {
      throw ArgumentError(
        "$name has wrong language: ${fhirpathExpression.language.toString()}",
      );
    }
  }

  @override
  Future<dynamic> fetchValue() async {
    final upstreamExpressions = this.upstreamExpressions;

    final upstreamMap = <String, dynamic>{};

    for (final upstreamExpression
        in upstreamExpressions.toList(growable: false).reversed) {
      final name = ArgumentError.checkNotNull(upstreamExpression.name);
      final key = '%$name';

      if (upstreamMap[key] != null) {
        // items later in the list beat items earlier in the list.
        continue;
      }

      final value = await upstreamExpression.fetchValue();

      upstreamMap[key] = value;
    }

    final resource = resourceBuilder?.call();

    return Future.value(
      r4WalkFhirPath(resource, fhirpath, upstreamMap),
    );
  }
}
