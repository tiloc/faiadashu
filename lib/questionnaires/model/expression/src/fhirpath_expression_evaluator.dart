import 'package:fhir/r4/metadata_types/metadata_types.dart';
import 'package:fhir/r4/resource/resource.dart';
import 'package:fhir_path/run_fhir_path.dart';
import 'package:flutter/foundation.dart';

import '../../../../logging/logging.dart';
import 'expression_evaluator.dart';
import 'fhir_expression_evaluator.dart';

class FhirPathExpressionEvaluator extends FhirExpressionEvaluator {
  static final _logger = Logger(FhirPathExpressionEvaluator);

  final Resource? Function()? resourceBuilder;
  final String fhirPath;
  final Map<String, dynamic>? Function()? jsonBuilder;

  FhirPathExpressionEvaluator(
    this.resourceBuilder,
    Expression fhirPathExpression,
    Iterable<ExpressionEvaluator> upstreamExpressions, {
    this.jsonBuilder,
    String? debugLabel,
  })  : fhirPath = ArgumentError.checkNotNull(fhirPathExpression.expression),
        super(
          fhirPathExpression,
          upstreamExpressions,
          debugLabel: debugLabel,
        ) {
    if (fhirPathExpression.language != ExpressionLanguage.text_fhirpath) {
      throw ArgumentError(
        "$name has wrong language: ${fhirPathExpression.language.toString()}",
      );
    }
  }

  @override
  Future<dynamic> fetchValue() async {
    final upstreamExpressions = this.upstreamExpressions;

    final upstreamMap = <String, dynamic>{};

    for (final upstreamExpression in upstreamExpressions) {
      final name = ArgumentError.checkNotNull(upstreamExpression.name);
      final key = '%$name';

      try {
        final value = await upstreamExpression.fetchValue();

        upstreamMap[key] = value;
      } catch (ex) {
        // If resolving the value fails: silently put nothing into the map
        // If it was required it will fail later during FHIRPath eval. If not: great!
        _logger.warn('Cannot fetch upstream $upstreamExpression', error: ex);
      }
    }

    final jsonContext =
        resourceBuilder?.call()?.toJson() ?? jsonBuilder?.call();
    final fhirPathResult =
        walkFhirPath(jsonContext, fhirPath, environment: upstreamMap);

    _logger.debug('${toStringShort()} $fhirPath: $fhirPathResult');

    return Future.value(
      fhirPathResult,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);

    properties.add(
      StringProperty('FHIRPath', fhirPath),
    );
  }
}
