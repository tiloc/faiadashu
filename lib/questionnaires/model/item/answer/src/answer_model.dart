import 'dart:ui';

import 'package:fhir/r4.dart';

import '../../../../../fhir_types/fhir_types.dart';
import '../../../../questionnaires.dart';

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
  String? validate(I? inValue);

  /// Returns a [QuestionnaireResponseAnswer] based on the current value.
  QuestionnaireResponseAnswer? fillAnswer();

  List<QuestionnaireResponseAnswer>? fillCodingAnswers() {
    throw UnimplementedError('fillCodingAnswers() not implemented.');
  }

  bool hasCodingAnswers() => false;
}
