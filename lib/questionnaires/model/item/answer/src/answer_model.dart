import 'package:faiadashu/fhir_types/fhir_types.dart';
import 'package:faiadashu/questionnaires/model/model.dart';
import 'package:fhir/r4.dart';
import 'package:flutter/material.dart';

/// Models a single answer within a [QuestionItemModel].
abstract class AnswerModel<I, V> extends ResponseNode {
  /// Textual depiction of an unanswered question.
  static const nullText = '—';

  final QuestionItemModel responseItemModel;
  V? _value;

  V? get value => _value;

  /// Set the [value].
  ///
  /// This will also validate it and set the errorText accordingly.
  set value(V? newValue) {
    if (_value != newValue) {
      _value = newValue;

      responseItemModel.handleChangedAnswer(this);
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

  /// Is the control for the answer to be enabled?
  ///
  /// * true: users may manipulate the control
  /// * false: users may not manipulate the control
  bool get isControlEnabled =>
      responseItemModel.displayVisibility == DisplayVisibility.shown;

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
  String? validateInput(I? inputValue);

  /// Validates a value against the constraints of the answer model.
  /// Does not change the [value] of the answer model.
  ///
  /// Returns null when it is valid, or a localized message when it is not.
  String? validateValue(V? inputValue);

  /// Validates whether the current [value] will pass the completeness check.
  ///
  /// Completeness means that the validity criteria are met,
  /// in order to submit a [QuestionnaireResponse] as complete.
  ///
  /// Since an individual answer does not know whether it is required, this
  /// is not taken into account.
  ///
  /// Returns null when the answer is valid, or an error text,
  /// when it is not.
  ///
  String? validate({
    bool updateErrorText = true,
    bool notifyListeners = false,
  }) {
    final newErrorText = validateValue(
      value,
    );

    if (errorText == newErrorText) {
      return newErrorText;
    }

    if (updateErrorText) {
      errorText = newErrorText;
    }
    if (notifyListeners) {
      // TODO: answerModels cannot have listeners yet.
//      notifyListeners();
    }

    return newErrorText;
  }

  /// Returns whether any answer (valid or invalid) has been provided.
  bool get isAnswered => !isUnanswered;

  /// Returns whether this question is unanswered.
  bool get isUnanswered;

  String? errorText;

  /// Returns an error text for display in the answer's control.
  ///
  /// This might return an error text from the parent [QuestionItemModel].
  String? get displayErrorText => errorText ?? responseItemModel.errorText;

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
