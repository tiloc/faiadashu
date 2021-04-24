import 'package:fhir/primitive_types/fhir_uri.dart';
import 'package:fhir/r4/basic_types/fhir_extension.dart';
import 'package:fhir/r4/resource_types/clinical/diagnostics/diagnostics.dart';
import 'package:fhir/r4/resource_types/specialized/definitional_artifacts/definitional_artifacts.dart';

import '../../../../coding/data_absent_reasons.dart';
import '../../../../fhir_types/fhir_types_extensions.dart';
import '../../../view/item/questionnaire_response_filler.dart';
import '../../questionnaire_location.dart';
import 'answer_model.dart';

/// Models string answers, incl. URLs.
class StringAnswerModel extends AnswerModel<String, String> {
  static final _urlRegExp = RegExp(
      r'^(http|https|ftp|sftp)://(?:[a-zA-Z]|[0-9]|[$-_@.&+]|[!*\(\),]|(?:%[0-9a-fA-F][0-9a-fA-F]))+');

  late final RegExp? regExp;
  late final int minLength;
  late final int? maxLength;

  StringAnswerModel(
      QuestionnaireLocation location, AnswerLocation answerLocation)
      : super(location, answerLocation) {
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

    value = answerLocation.answer?.valueString;
  }

  @override
  String get display => value ?? AnswerModel.nullText;

  @override
  String? validate(String? inValue) {
    if (inValue == null || inValue.isEmpty) {
      return null;
    }

    if (inValue.length < minLength) {
      return 'Enter $minLength or more characters.';
    }

    if (maxLength != null && inValue.length > maxLength!) {
      return 'Enter up to $maxLength characters.';
    }

    if (qi.type == QuestionnaireItemType.url) {
      if (!_urlRegExp.hasMatch(inValue)) {
        return 'Enter a valid URL.';
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

  @override
  QuestionnaireResponseAnswer? fillAnswer() {
    final valid = validate(value) == null;
    final dataAbsentReasonExtension = !valid
        ? [
            FhirExtension(
                url: DataAbsentReason.extensionUrl,
                valueCode: DataAbsentReason.asTextCode)
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
}
