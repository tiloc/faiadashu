import 'package:fhir/r4.dart';

import '../../../model.dart';

/// A pseudo-model for a questionnaire item of an unsupported type.
class UnsupportedAnswerModel extends AnswerModel<Object, Object> {
  UnsupportedAnswerModel(QuestionItemModel responseModel)
      : super(responseModel);

  @override
  QuestionnaireResponseAnswer? get filledAnswer {
    throw UnimplementedError('UnsupportedAnswerModel cannot fill an answer.');
  }

  @override
  String get display => AnswerModel.nullText;

  @override
  String? validateInput(Object? inValue) {
    return null;
  }

  @override
  QuestionnaireErrorFlag? get isComplete => null;

  @override
  bool get isUnanswered => false;

  @override
  void populate(QuestionnaireResponseAnswer answer) {
    throw UnsupportedError('Cannot populate item of unknown type.');
  }
}
