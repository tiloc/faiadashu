

import 'package:intl/intl.dart' as intl;
import 'fdash_localizations.g.dart';

/// The translations for German (`de`).
class FDashLocalizationsDe extends FDashLocalizations {
  FDashLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get validatorRequiredItem => 'Füllen sie dieses Pflichtfeld aus.';

  @override
  String validatorMinLength(int minLength) {
    return intl.Intl.pluralLogic(
      minLength,
      locale: localeName,
      other: 'Mind. $minLength Zeichen eingeben.',
    );
  }

  @override
  String validatorMaxLength(int maxLength) {
    return intl.Intl.pluralLogic(
      maxLength,
      locale: localeName,
      other: 'Max. $maxLength Zeichen eingeben.',
    );
  }

  @override
  String get validatorUrl => 'Gültige URL eingeben.';

  @override
  String get validatorRegExp => 'Gültige Angabe machen.';

  @override
  String validatorEntryFormat(String entryFormat) {
    return 'Eingeben im Format: $entryFormat';
  }

  @override
  String validatorMaxValue(String maxValue) {
    return 'Eine Zahl bis $maxValue eingeben.';
  }
}
