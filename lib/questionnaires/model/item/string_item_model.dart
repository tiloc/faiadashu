import 'package:fhir/r4/resource_types/specialized/definitional_artifacts/definitional_artifacts.dart';

import '../../../fhir_types/fhir_types_extensions.dart';
import '../questionnaire_location.dart';
import 'item_model.dart';

class StringItemModel extends ItemModel<String> {
  static final _urlRegExp = RegExp(
      r'^(http|https|ftp|sftp)://(?:[a-zA-Z]|[0-9]|[$-_@.&+]|[!*\(\),]|(?:%[0-9a-fA-F][0-9a-fA-F]))+');

  late final RegExp? regExp;
  late final int minLength;
  late final int? maxLength;

  StringItemModel(QuestionnaireLocation location) : super(location) {
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
  }

  @override
  String? validate(String? inValue) {
    if (inValue == null || inValue.isEmpty) {
      return null;
    }

    if (inValue.length < minLength) {
      return 'Enter $minLength or more characters.';
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
}
