import 'package:faiadashu/fhir_types/fhir_types.dart';
import 'package:faiadashu/l10n/l10n.dart';
import 'package:faiadashu/questionnaires/model/model.dart';
import 'package:fhir/r4.dart'
    show
        FhirDate,
        FhirDateTime,
        QuestionnaireResponseAnswer,
        QuestionnaireResponseItem,
        FhirTime;

class DateTimeAnswerModel extends AnswerModel<FhirDateTime, FhirDateTime> {
  DateTimeAnswerModel(super.responseModel);

  @override
  RenderingString get display => (value != null)
      ? RenderingString.fromText(
          value!.format(locale, defaultText: AnswerModel.nullText),
        )
      : RenderingString.nullText;

  @override
  QuestionnaireResponseAnswer? createFhirAnswer(
    List<QuestionnaireResponseItem>? items,
  ) {
    final itemType = qi.type;

    if (value?.value == null) {
      return null;
    }

    if (itemType.value == 'date') {
      return QuestionnaireResponseAnswer(
        valueDate: FhirDate(value!.value),
        item: items,
      );
    } else if (itemType.value == 'datetime') {
      return QuestionnaireResponseAnswer(
        valueDateTime: value,
        item: items,
      );
    } else if (itemType.value == 'time') {
      return QuestionnaireResponseAnswer(
        valueTime: FhirTime(
          value!.value!.toIso8601String().substring('yyyy-MM-ddT'.length),
        ),
        item: items,
      );
    } else {
      throw StateError('Unexpected itemType: $itemType');
    }
  }

  @override
  String? validateInput(FhirDateTime? inValue) {
    return validateValue(inValue);
  }

  @override
  String? validateValue(FhirDateTime? inValue) {
    return inValue == null || inValue.isValid
        ? null
        : lookupFDashLocalizations(locale).validatorDateTime;
  }

  @override
  bool get isEmpty => value == null;

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
