import 'package:fhir/r4.dart';

import '../../../../../coding/coding.dart';
import '../../../../../fhir_types/fhir_types.dart';
import '../../../../../l10n/l10n.dart';
import '../../../../model/model.dart';

enum StringAnswerKeyboard { plain, email, phone, number, multiline, url }

/// Models string answers, incl. URLs.
class StringAnswerModel extends AnswerModel<String, String> {
  static final _urlRegExp = RegExp(
    r'^(http|https|ftp|sftp)://(?:[a-zA-Z]|[0-9]|[$-_@.&+]|[!*\(\),]|(?:%[0-9a-fA-F][0-9a-fA-F]))+',
  );

  late final RegExp? regExp;
  late final int minLength;
  late final int? maxLength;
  late final StringAnswerKeyboard keyboard;

  StringAnswerModel(QuestionItemModel responseModel) : super(responseModel) {
    final regexPattern = qi.extension_
        ?.extensionOrNull('http://hl7.org/fhir/StructureDefinition/regex')
        ?.valueString;

    regExp =
        (regexPattern != null) ? RegExp(regexPattern, unicode: true) : null;

    minLength = qi.extension_
            ?.extensionOrNull(
              'http://hl7.org/fhir/StructureDefinition/minLength',
            )
            ?.valueInteger
            ?.value ??
        0;

    maxLength = qi.maxLength?.value;

    final keyboardExtension = qi.extension_
        ?.extensionOrNull(
          'http://hl7.org/fhir/uv/sdc/StructureDefinition/sdc-questionnaire-keyboard',
        )
        ?.valueCode
        ?.value;

    keyboard = (qi.type == QuestionnaireItemType.text)
        ? StringAnswerKeyboard.multiline
        : (qi.type == QuestionnaireItemType.url)
            ? StringAnswerKeyboard.url
            : (keyboardExtension == 'email')
                ? StringAnswerKeyboard.email
                : (keyboardExtension == 'phone')
                    ? StringAnswerKeyboard.phone
                    : (keyboardExtension == 'number')
                        ? StringAnswerKeyboard.number
                        : StringAnswerKeyboard.plain;
  }

  @override
  RenderingString get display => (value != null)
      ? RenderingString.fromText(value!)
      : RenderingString.nullText;

  @override
  String? validateInput(String? inValue) {
    final checkValue = inValue?.trim();

    if (checkValue == null || checkValue.isEmpty) {
      return null;
    }

    if (checkValue.length < minLength) {
      return lookupFDashLocalizations(locale).validatorMinLength(minLength);
    }

    if (maxLength != null && checkValue.length > maxLength!) {
      return lookupFDashLocalizations(locale).validatorMaxLength(maxLength!);
    }

    if (qi.type == QuestionnaireItemType.url) {
      if (!_urlRegExp.hasMatch(checkValue)) {
        return lookupFDashLocalizations(locale).validatorUrl;
      }
    }

    if (regExp != null) {
      if (!regExp!.hasMatch(checkValue)) {
        return (entryFormat != null)
            ? lookupFDashLocalizations(locale)
                .validatorEntryFormat(entryFormat!)
            : lookupFDashLocalizations(locale).validatorRegExp;
      }
    }

    return null;
  }

  @override
  QuestionnaireResponseAnswer? createFhirAnswer(
    List<QuestionnaireResponseItem>? items,
  ) {
    final value = this.value?.trim();

    final valid = validateInput(value) == null;
    final dataAbsentReasonExtension = !valid
        ? [
            FhirExtension(
              url: dataAbsentReasonExtensionUrl,
              valueCode: dataAbsentReasonAsTextCode,
            ),
          ]
        : null;

    return (value != null && value.isNotEmpty)
        ? (qi.type != QuestionnaireItemType.url)
            ? QuestionnaireResponseAnswer(
                valueString: value,
                extension_: dataAbsentReasonExtension,
                item: items,
              )
            : QuestionnaireResponseAnswer(
                valueUri: FhirUri(value),
                extension_: dataAbsentReasonExtension,
                item: items,
              )
        : null;
  }

  @override
  String? get isComplete {
    return validateInput(value);
  }

  @override
  bool get isUnanswered => value?.trim().isEmpty ?? true;

  @override
  void populateFromExpression(dynamic evaluationResult) {
    if (evaluationResult == null) {
      value = null;

      return;
    }

    value = evaluationResult as String?;
  }

  @override
  void populate(QuestionnaireResponseAnswer answer) {
    value = answer.valueString;
  }
}
