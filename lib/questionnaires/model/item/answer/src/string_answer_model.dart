import 'package:fhir/r4.dart';

import '../../../../../coding/coding.dart';
import '../../../../../fhir_types/fhir_types.dart';
import '../../../../model/model.dart';

/// Models string answers, incl. URLs.
class StringAnswerModel extends AnswerModel<String, String> {
  static final _urlRegExp = RegExp(
      r'^(http|https|ftp|sftp)://(?:[a-zA-Z]|[0-9]|[$-_@.&+]|[!*\(\),]|(?:%[0-9a-fA-F][0-9a-fA-F]))+');

  late final RegExp? regExp;
  late final int minLength;
  late final int? maxLength;

  StringAnswerModel(ResponseModel responseModel, int answerIndex)
      : super(responseModel, answerIndex) {
    final regexPattern = qi.extension_
        ?.extensionOrNull('http://hl7.org/fhir/StructureDefinition/regex')
        ?.valueString;

    regExp =
        (regexPattern != null) ? RegExp(regexPattern, unicode: true) : null;

    minLength = qi.extension_
            ?.extensionOrNull(
                'http://hl7.org/fhir/StructureDefinition/minLength')
            ?.valueInteger
            ?.value ??
        0;

    maxLength = qi.maxLength?.value;

    value = answer?.valueString;
  }

  @override
  String get display => value ?? AnswerModel.nullText;

  @override
  String? validateInput(String? inValue) {
    if (inValue == null || inValue.isEmpty) {
      return null;
    }

    if (inValue.length < minLength) {
      return 'Provide $minLength or more characters.';
    }

    if (maxLength != null && inValue.length > maxLength!) {
      return 'Provide up to $maxLength characters.';
    }

    if (qi.type == QuestionnaireItemType.url) {
      if (!_urlRegExp.hasMatch(inValue)) {
        return 'Provide a valid URL.';
      }
    }

    if (regExp != null) {
      if (!regExp!.hasMatch(inValue)) {
        if (entryFormat != null) {
          return "Provide as '$entryFormat'";
        } else {
          return 'Provide a valid answer.';
        }
      }
    }

    return null;
  }

  // TODO: Should the string get trimmed somewhere?

  @override
  QuestionnaireResponseAnswer? get filledAnswer {
    final valid = validateInput(value) == null;
    final dataAbsentReasonExtension = !valid
        ? [
            FhirExtension(
                url: dataAbsentReasonExtensionUrl,
                valueCode: dataAbsentReasonAsTextCode)
          ]
        : null;

    return (value != null && value!.isNotEmpty)
        ? (qi.type != QuestionnaireItemType.url)
            ? QuestionnaireResponseAnswer(
                valueString: value, extension_: dataAbsentReasonExtension)
            : QuestionnaireResponseAnswer(
                valueUri: FhirUri(value), extension_: dataAbsentReasonExtension)
        : null;
  }

  @override
  QuestionnaireErrorFlag? get isComplete {
    final valid = validateInput(value);
    if (valid == null) {
      return null;
    } else {
      return QuestionnaireErrorFlag(responseModel.itemModel.linkId,
          answerIndex: answerIndex, errorText: valid);
    }
  }

  @override
  bool get isUnanswered => (value == null) || value!.trim().isEmpty;
}
