import 'dart:ui';

import 'package:fhir/r4.dart';

import '../../../../../fhir_types/fhir_types.dart';
import '../../../model.dart';

/// Models an answer within a [QuestionnaireResponseItem].
abstract class AnswerModel<I, V> {
  /// Textual depiction of an unanswered question.
  static const nullText = '—';

  final QuestionnaireItemModel itemModel;
  final ResponseModel responseModel;
  final int answerIndex;
  final Locale locale;
  V? value;

  QuestionnaireItem get qi => itemModel.questionnaireItem;

  bool get isEnabled =>
      !responseModel.itemModel.isReadOnly &&
      !(responseModel.itemModel.questionnaireModel.responseStatus ==
          QuestionnaireResponseStatus.completed);

  /// Returns the human-readable entry format.
  ///
  /// See: http://hl7.org/fhir/R4/extension-entryformat.html
  String? get entryFormat {
    return qi.extension_
        ?.extensionOrNull('http://hl7.org/fhir/StructureDefinition/entryFormat')
        ?.valueString;
  }

  AnswerModel(this.responseModel, this.answerIndex)
      : itemModel = responseModel.itemModel,
        locale = responseModel.itemModel.questionnaireModel.locale;

  /// Returns a human-readable, localized, textual description of the model.
  ///
  /// Returns [nullText] if the question is unanswered.
  String get display;

  QuestionnaireResponseAnswer? get answer => responseModel.answers[answerIndex];

  /// Returns null when [inValue] is valid, or a localized message when it is not.
  ///
  /// This is used to validate external input (typically coming from a view).
  ///
  String? validate(I? inValue);

  /// Returns whether the answer will pass the completeness check.
  ///
  /// Returns null when the answer is complete, or a [QuestionnaireMarker],
  /// when it is not.
  ///
  /// Completeness means that all the criteria (validity, required) are met,
  /// in order to submit a [QuestionnaireResponse] as complete.
  QuestionnaireMarker? get isComplete;

  /// Returns a [QuestionnaireResponseAnswer] based on the current value.
  QuestionnaireResponseAnswer? get filledAnswer;

  List<QuestionnaireResponseAnswer>? get filledCodingAnswers {
    throw UnimplementedError('filledCodingAnswers not implemented.');
  }

  bool get hasCodingAnswers => false;
}
