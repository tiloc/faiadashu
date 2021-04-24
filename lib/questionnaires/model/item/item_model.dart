import 'dart:ui';

import 'package:faiadashu/faiadashu.dart';
import 'package:fhir/r4.dart';

import '../../../fhir_types/fhir_types_extensions.dart';
import '../questionnaire_location.dart';

/// Models a [QuestionnaireResponseItem].
abstract class ItemModel<I, V> {
  final QuestionnaireLocation location;
  final AnswerLocation answerLocation;
  final Locale locale;
  V? value;

  QuestionnaireItem get qi => location.questionnaireItem;

  /// Returns the human-readable entry format.
  ///
  /// See: http://hl7.org/fhir/R4/extension-entryformat.html
  String? get entryFormat {
    return qi.extension_
        ?.extensionOrNull('http://hl7.org/fhir/StructureDefinition/entryFormat')
        ?.valueString;
  }

  ItemModel(this.location, this.answerLocation) : locale = location.top.locale;

  /// Returns null when [inValue] is valid, or a localized message when it is not.
  String? validate(I? inValue);

  /// Returns a [QuestionnaireResponseAnswer] based on the current value.
  QuestionnaireResponseAnswer? fillAnswer();

  List<QuestionnaireResponseAnswer>? fillCodingAnswers() {
    throw UnimplementedError('fillCodingAnswers() not implemented.');
  }

  bool hasCodingAnswers() => false;
}
