import 'package:fhir/r4.dart'
    show
        Date,
        FhirDateTime,
        QuestionnaireItemType,
        QuestionnaireResponseAnswer,
        Time;

import '../../../../../fhir_types/fhir_types.dart';
import '../../../../../l10n/l10n.dart';
import '../../../model.dart';

class DateTimeAnswerModel extends AnswerModel<FhirDateTime, FhirDateTime> {
  DateTimeAnswerModel(QuestionItemModel responseModel) : super(responseModel);

  @override
  String get display => value?.format(locale) ?? AnswerModel.nullText;

  @override
  QuestionnaireResponseAnswer? get filledAnswer {
    final itemType = qi.type;

    if (value?.value == null) {
      return null;
    }

    if (itemType == QuestionnaireItemType.date) {
      return QuestionnaireResponseAnswer(valueDate: Date(value!.value));
    } else if (itemType == QuestionnaireItemType.datetime) {
      return QuestionnaireResponseAnswer(valueDateTime: value);
    } else if (itemType == QuestionnaireItemType.time) {
      return QuestionnaireResponseAnswer(
        valueTime: Time(
          value!.value!.toIso8601String().substring('yyyy-MM-ddT'.length),
        ),
      );
    } else {
      throw StateError('Unexpected itemType: $itemType');
    }
  }

  @override
  String? validateInput(FhirDateTime? inValue) {
    if (inValue == null || inValue.isValid) {
      return null;
    } else {
      return lookupFDashLocalizations(locale).validatorDateTime;
    }
  }

  @override
  QuestionnaireErrorFlag? get isComplete {
    // TODO: Look at validity?
    return null;
  }

  @override
  bool get isUnanswered => value == null;

  @override
  void populateFromExpression(dynamic evaluationResult) {
    if (evaluationResult == null) {
      value = null;
      return;
    }

    value = FhirDateTime(evaluationResult);
  }

  @override
  void populate(QuestionnaireResponseAnswer answer) {
    value = answer.valueDateTime ??
        ((answer.valueDate != null) ? FhirDateTime(answer.valueDate) : null);
  }
}
