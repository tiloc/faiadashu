

import 'package:intl/intl.dart' as intl;
import 'fdash_localizations.g.dart';

/// The translations for English (`en`).
class FDashLocalizationsEn extends FDashLocalizations {
  FDashLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get validatorRequiredItem => 'This question needs to be completed.';

  @override
  String validatorMinLength(int minLength) {
    return intl.Intl.pluralLogic(
      minLength,
      locale: localeName,
      one: 'Enter at least one character.',
      other: 'Enter at least $minLength characters.',
    );
  }

  @override
  String validatorMaxLength(int maxLength) {
    return intl.Intl.pluralLogic(
      maxLength,
      locale: localeName,
      other: 'Enter up to $maxLength characters.',
    );
  }

  @override
  String get validatorUrl => 'Enter a valid URL in format https://...';

  @override
  String get validatorRegExp => 'Enter a valid response.';

  @override
  String validatorEntryFormat(String entryFormat) {
    return 'Enter in format $entryFormat.';
  }

  @override
  String get validatorNan => 'Enter a valid number.';

  @override
  String validatorMinValue(String minValue) {
    return 'Enter a number of $minValue or higher.';
  }

  @override
  String validatorMaxValue(String maxValue) {
    return 'Enter a number up to $maxValue.';
  }

  @override
  String get dataAbsentReasonAskedDeclined => 'I choose not to answer.';

  @override
  String get narrativePageTitle => 'Narrative';

  @override
  String get questionnaireGenericTitle => 'Survey';

  @override
  String get questionnaireUnknownTitle => 'Untitled';

  @override
  String get questionnaireUnknownPublisher => 'Unknown publisher';
}
