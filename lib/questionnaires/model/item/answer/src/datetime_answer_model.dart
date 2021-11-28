import 'package:fhir/r4.dart'
    show
        Date,
        FhirDateTime,
        QuestionnaireItemType,
        QuestionnaireResponseAnswer,
        QuestionnaireResponseItem,
        Time;

import '../../../../../fhir_types/fhir_types.dart';
import '../../../../../l10n/l10n.dart';
import '../../../model.dart';

class DateTimeAnswerModel extends AnswerModel<FhirDateTime, FhirDateTime> {
  DateTimeAnswerModel(QuestionItemModel responseModel) : super(responseModel);

  @override
  XhtmlString get display => (value != null)
      ? XhtmlString.fromText(
          value!.format(locale, defaultText: AnswerModel.nullText),
        )
      : XhtmlString.nullText;

  @override
  QuestionnaireResponseAnswer? createFhirAnswer(
    List<QuestionnaireResponseItem>? items,
  ) {
    final itemType = qi.type;

    if (value?.value == null) {
      return null;
    }

    if (itemType == QuestionnaireItemType.date) {
      return QuestionnaireResponseAnswer(
        valueDate: Date(value!.value),
        item: items,
      );
    } else if (itemType == QuestionnaireItemType.datetime) {
      return QuestionnaireResponseAnswer(
        valueDateTime: value,
        item: items,
      );
    } else if (itemType == QuestionnaireItemType.time) {
      return QuestionnaireResponseAnswer(
        valueTime: Time(
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
    return inValue == null || inValue.isValid
        ? null
        : lookupFDashLocalizations(locale).validatorDateTime;
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
