import 'package:faiadashu/logging/logging.dart';
import 'package:faiadashu/questionnaires/model/expression/expression.dart';
import 'package:fhir/r4/metadata_types/metadata_types.dart';
import 'package:fhir/r4/resource/resource.dart';
import 'package:fhir_path/run_fhir_path.dart';
import 'package:flutter/foundation.dart';

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
        '$name has wrong language: ${fhirPathExpression.language.toString()}',
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

  /// Evaluates a FHIRPath expression and interprets the result as a [bool].
  ///
  /// Proper behavior is undefined: http://jira.hl7.org/browse/FHIR-33295
  /// Using singleton collection evaluation: https://hl7.org/fhirpath/#singleton-evaluation-of-collections
  Future<bool> fetchBoolValue({
    String? location,
    required bool unknownValue,
  }) async {
    final fhirPathResult = await fetchValue();

    if (fhirPathResult == null) {
      return unknownValue;
    }

    if (fhirPathResult is! List) {
      throw ArgumentError('Expected List', 'fhirPathResult');
    }

    if (fhirPathResult.isEmpty) {
      return unknownValue;
    } else if (fhirPathResult.first is! bool) {
      _logger.warn(
        'Questionnaire design issue: "$this" at $location results in $fhirPathResult. Expected a bool.',
      );

      return fhirPathResult.first != null;
    } else {
      return fhirPathResult.first as bool;
    }
  }
}
