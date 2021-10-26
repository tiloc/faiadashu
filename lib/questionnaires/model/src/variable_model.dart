import 'package:fhir/r4.dart';
import 'package:fhir_path/fhir_path.dart';

import 'questionnaire_exceptions.dart';

/// Models a variable for use in expressions.
///
/// See: http://hl7.org/fhir/StructureDefinition/variable
class VariableModel {
  static final variableExtensionUrl =
      FhirUri('http://hl7.org/fhir/StructureDefinition/variable');

  /// The name of the variable
  late final String name;

  /// The expression that calculates the value of the variable
  late final String expression;

  final List<VariableModel>? _visibleOtherVariables;

  dynamic _value;

  /// Returns the current value of the variable.
  ///
  /// Use [updateValue] for recalculation.
  dynamic get value => _value;

  /// Updates the value of the variable.
  ///
  /// Considers the [resource] and the current value of the other variables
  /// that have been passed in during construction.
  ///
  /// The other variables will not be updated by this method.
  void updateValue(Resource? resource) {
    final passedVariables = (_visibleOtherVariables != null)
        ? Map.fromEntries(
            _visibleOtherVariables!.map<MapEntry<String, dynamic>>(
              (otherVariable) =>
                  MapEntry(otherVariable.name, otherVariable.value),
            ),
          )
        : null;

    final newValue = r4WalkFhirPath(resource, expression, passedVariables);

    _value = newValue;
  }

  /// Returns the variables associated with a [Resource].
  static List<VariableModel>? variables(
    Resource resource,
    List<VariableModel>? visibleOtherVariables,
  ) {
    // WIP: Previous variables in the same resource shall be visible to later ones
    return resource.extension_
        ?.where((ext) => ext.url == variableExtensionUrl)
        .map((ext) => VariableModel(ext, visibleOtherVariables))
        .toList(growable: false);
  }

  VariableModel(
    FhirExtension variableExtension,
    List<VariableModel>? visibleOtherVariables,
  ) : _visibleOtherVariables = visibleOtherVariables {
    final expressionName = variableExtension.valueExpression?.name?.value;
    if (expressionName == null) {
      throw QuestionnaireFormatException(
        'Variable missing name',
        variableExtension,
      );
    }
    name = expressionName;

    final expressionExpression = variableExtension.valueExpression?.expression;
    if (expressionExpression == null) {
      throw QuestionnaireFormatException(
        'Variable missing expression',
        variableExtension,
      );
    }

    expression = expressionExpression;
  }
}
