import 'package:faiadashu/logging/logging.dart';
import 'package:faiadashu/questionnaires/model/expression/expression.dart';
import 'package:fhir/r4/metadata_types/metadata_types.dart';
import 'package:fhir/r4/resource/resource.dart';
import 'package:fhir_path/fhir_path.dart';
import 'package:flutter/foundation.dart';

class FhirPathExpressionEvaluator extends FhirExpressionEvaluator {
  static final _logger = Logger(FhirPathExpressionEvaluator);

  final Resource? Function()? resourceBuilder;
  final String fhirPath;
  final Map<String, dynamic>? Function()? jsonBuilder;

  late final ParserList _parsedFhirPath;

  int? _generation;
  dynamic _cachedResult;

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
        '$name has wrong language: ${fhirPathExpression.language}',
      );
    }

    _parsedFhirPath = parseFhirPath(fhirPath);
  }

  @override
  dynamic evaluate({int? generation}) {
    if (generation != null && _generation == generation) {
      return _cachedResult;
    }

    final upstreamExpressions = this.upstreamExpressions;

    final upstreamMap = <String, dynamic>{};

    for (final upstreamExpression in upstreamExpressions) {
      final name = ArgumentError.checkNotNull(upstreamExpression.name);
      final key = '%$name';

      upstreamMap[key] = () {
        _logger.debug('Lazy eval of: $key');

        return upstreamExpression.evaluate(generation: generation);
      };
    }

    final jsonContext =
        resourceBuilder?.call()?.toJson() ?? jsonBuilder?.call();
    final fhirPathResult = executeFhirPath(
      context: jsonContext,
      parsedFhirPath: _parsedFhirPath,
      pathExpression: fhirPath,
      environment: upstreamMap,
    );

    _logger.debug('${toStringShort()} $fhirPath: $fhirPathResult');

    if (generation != null) {
      _cachedResult = fhirPathResult;
      _generation = generation;
    }

    return fhirPathResult;
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
  bool fetchBoolValue({
    String? location,
    int? generation,
    required bool unknownValue,
  }) {
    final fhirPathResult = evaluate(generation: generation);

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
