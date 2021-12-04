import 'package:fhir/r4.dart';
import 'package:flutter/material.dart';

import '../../../../../fhir_types/fhir_types.dart';
import '../../../model.dart';

/// Models a single answer within a [QuestionItemModel].
abstract class AnswerModel<I, V> extends ResponseNode {
  /// Textual depiction of an unanswered question.
  static const nullText = '—';

  final QuestionItemModel responseItemModel;
  V? _value;

  V? get value => _value;
  set value(V? newValue) {
    if (newValue != _value) {
      _value = newValue;

      responseItemModel.onAnswerChanged(this);
    }
  }

  QuestionnaireItemModel get questionnaireItemModel =>
      responseItemModel.questionnaireItemModel;

  QuestionnaireResponseModel get questionnaireResponseModel =>
      responseItemModel.questionnaireResponseModel;

  QuestionnaireModelDefaults get modelDefaults =>
      questionnaireResponseModel.questionnaireModel.questionnaireModelDefaults;

  Locale get locale => questionnaireResponseModel.locale;

  QuestionnaireItem get qi => questionnaireItemModel.questionnaireItem;

  bool get isEnabled =>
      !questionnaireItemModel.isReadOnly &&
      !(questionnaireResponseModel.responseStatus ==
          QuestionnaireResponseStatus.completed);

  /// Returns the human-readable entry format.
  ///
  /// See: http://hl7.org/fhir/R4/extension-entryformat.html
  String? get entryFormat {
    return qi.extension_
        ?.extensionOrNull('http://hl7.org/fhir/StructureDefinition/entryFormat')
        ?.valueString;
  }

  /// Construct a new, unpopulated answer model.
  AnswerModel(this.responseItemModel) : super(responseItemModel);

  /// Returns a human-readable, localized, textual description of the model.
  ///
  /// Returns [RenderingString.nullText] if the question is unanswered.
  RenderingString get display;

  /// Validates a new input value. Does not change the [value].
  ///
  /// Returns null when [inputValue] is valid, or a localized message when it is not.
  ///
  /// This is used to validate external input from a view.
  ///
  String? validateInput(I? inputValue);

  /// Returns whether the answer will pass the completeness check.
  ///
  /// Completeness means that the validity criteria are met,
  /// in order to submit a [QuestionnaireResponse] as complete.
  ///
  /// Since an individual answer does not know whether it is required, this
  /// is not taken into account.
  ///
  /// Returns null when the answer is valid, or a [QuestionnaireErrorFlag],
  /// when it is not.
  QuestionnaireErrorFlag? get isComplete;

  /// Returns whether any answer (valid or invalid) has been provided.
  bool get isAnswered => !isUnanswered;

  /// Returns whether this question is unanswered.
  bool get isUnanswered;

  String? get errorText {
    return questionnaireResponseModel
        .errorFlagForNodeUid(responseItemModel.nodeUid)
        ?.errorText;
  }

  /// Returns a [QuestionnaireResponseAnswer] based on the current value.
  ///
  /// Can optionally add nested [items].
  ///
  /// This is the link between the presentation model and the underlying
  /// FHIR domain model.
  QuestionnaireResponseAnswer? createFhirAnswer(
    List<QuestionnaireResponseItem>? items,
  );

  List<QuestionnaireResponseAnswer>? createFhirCodingAnswers(
    List<QuestionnaireResponseItem>? items,
  ) {
    throw UnimplementedError('createFhirCodingAnswers not implemented.');
  }

  bool get hasCodingAnswers => false;

  /// Populate an answer model with a value from the FHIR domain model.
  void populate(QuestionnaireResponseAnswer answer);

  /// Populate an answer model with a multiple-choice answer from the FHIR domain model.
  void populateCodingAnswers(List<QuestionnaireResponseAnswer>? answers) {
    throw UnimplementedError('populateCodingAnswers not implemented.');
  }

  /// Populates the answer from the result of a FHIRPath expression.
  ///
  /// This function is designed for a very specific internal purpose and should
  /// not be invoked by application code.
  void populateFromExpression(dynamic evaluationResult) {
    throw UnimplementedError('populateFromExpression not implemented.');
  }

  static int _uidCounter = 0;

  /// INTERNAL USE ONLY - do not invoke!
  @override
  String calculateNodeUid() {
    _uidCounter++;

    return '${parentNode?.nodeUid}/$_uidCounter';
  }
}
