import 'package:collection/collection.dart';
import 'package:fhir/r4.dart';
import 'package:flutter/material.dart';

import '../../../../../fhir_types/fhir_types.dart';
import '../../../model.dart';

/// Models an answer within a [QuestionnaireResponseItem].
abstract class AnswerModel<I, V> {
  /// Textual depiction of an unanswered question.
  static const nullText = '—';

  final ResponseModel responseModel;
  final int answerIndex;
  V? value;

  QuestionnaireItemModel get itemModel => responseModel.itemModel;

  QuestionnaireModel get questionnaireModel => itemModel.questionnaireModel;

  Locale get locale => questionnaireModel.locale;

  QuestionnaireItem get qi => itemModel.questionnaireItem;

  bool get isEnabled =>
      !itemModel.isReadOnly &&
      !(questionnaireModel.responseStatus ==
          QuestionnaireResponseStatus.completed);

  /// Returns the human-readable entry format.
  ///
  /// See: http://hl7.org/fhir/R4/extension-entryformat.html
  String? get entryFormat {
    return qi.extension_
        ?.extensionOrNull('http://hl7.org/fhir/StructureDefinition/entryFormat')
        ?.valueString;
  }

  AnswerModel(this.responseModel, this.answerIndex);

  /// Returns a human-readable, localized, textual description of the model.
  ///
  /// Returns [nullText] if the question is unanswered.
  String get display;

  QuestionnaireResponseAnswer? get answer => responseModel.answers[answerIndex];

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
  /// Returns null when the answer is valid, or a [QuestionnaireMarker],
  /// when it is not.
  QuestionnaireMarker? get isComplete;

  /// Returns whether this question is unanswered.
  bool get isUnanswered;

  String? get errorText {
    return questionnaireModel.markers.value
        ?.firstWhereOrNull((qm) => qm.linkId == itemModel.linkId)
        ?.annotation;
  }

  /// Returns a [QuestionnaireResponseAnswer] based on the current value.
  ///
  /// This is the link between the presentation model and the underlying
  /// FHIR domain model.
  QuestionnaireResponseAnswer? get filledAnswer;

  List<QuestionnaireResponseAnswer>? get filledCodingAnswers {
    throw UnimplementedError('filledCodingAnswers not implemented.');
  }

  bool get hasCodingAnswers => false;
}
