

import 'package:intl/intl.dart' as intl;
import 'fdash_localizations.g.dart';

/// The translations for Spanish Castilian (`es`).
class FDashLocalizationsEs extends FDashLocalizations {
  FDashLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get validatorRequiredItem => 'Esta pregunta debe ser completada.';

  @override
  String validatorMinLength(int minLength) {
    return intl.Intl.pluralLogic(
      minLength,
      locale: localeName,
      one: 'Introducir al menos un carácter.',
      other: 'Introducir al menos $minLength caracteres.',
    );
  }

  @override
  String validatorMaxLength(int maxLength) {
    return intl.Intl.pluralLogic(
      maxLength,
      locale: localeName,
      other: 'Ingrese hasta $maxLength caracteres.',
    );
  }

  @override
  String get validatorUrl => 'Introduzca una URL válida con el formato https://...';

  @override
  String get validatorRegExp => 'Introduzca una respuesta válida.';

  @override
  String validatorEntryFormat(String entryFormat) {
    return 'Introduzca el formato $entryFormat.';
  }

  @override
  String get validatorNan => 'Introduzca un número válido.';

  @override
  String validatorMinValue(String minValue) {
    return 'Introduzca un número de $minValue o superior.';
  }

  @override
  String validatorMaxValue(String maxValue) {
    return 'Introduzca un número hasta $maxValue.';
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
