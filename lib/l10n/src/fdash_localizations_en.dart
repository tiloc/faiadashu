

import 'package:intl/intl.dart' as intl;
import 'fdash_localizations.g.dart';

/// The translations for English (`en`).
class FDashLocalizationsEn extends FDashLocalizations {
  FDashLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get validatorRequiredItem => 'Provide this required answer.';

  @override
  String validatorMinLength(int minLength) {
    return intl.Intl.pluralLogic(
      minLength,
      locale: localeName,
      one: 'Provide at least one character.',
      other: 'Provide at least $minLength characters.',
    );
  }

  @override
  String validatorMaxLength(int maxLength) {
    return intl.Intl.pluralLogic(
      maxLength,
      locale: localeName,
      other: 'Provide up to $maxLength characters.',
    );
  }

  @override
  String get validatorUrl => 'Provide a valid URL.';

  @override
  String get validatorRegExp => 'Provide a valid answer.';

  @override
  String validatorEntryFormat(String entryFormat) {
    return 'Provide as $entryFormat';
  }

  @override
  String validatorMaxValue(String maxValue) {
    return 'Provide a number up to $maxValue.';
  }
}
