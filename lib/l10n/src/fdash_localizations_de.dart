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
      other: 'Bis zu $maxLength Zeichen eingeben.',
    );
  }

  @override
  String get validatorUrl => 'URL im Format https://... eingeben.';

  @override
  String get validatorRegExp => 'Gültigen Wert eingeben.';

  @override
  String validatorEntryFormat(String entryFormat) {
    return 'Im Format $entryFormat eingeben.';
  }

  @override
  String get validatorDate => 'Gültiges Datum eingeben.';

  @override
  String get validatorTime => 'Gültige Uhrzeit eingeben.';

  @override
  String get validatorDateTime => 'Gültiges Datum/Zeit eingeben.';

  @override
  String get validatorNan => 'Gültige Zahl eingeben.';

  @override
  String validatorMinValue(String minValue) {
    return 'Eine Zahl ab $minValue eingeben.';
  }

  @override
  String validatorMaxValue(String maxValue) {
    return 'Eine Zahl bis $maxValue eingeben.';
  }

  @override
  String validatorMinOccurs(int minOccurs) {
    return intl.Intl.pluralLogic(
      minOccurs,
      locale: localeName,
      one: 'Mind. eine Auswahl.',
      other: 'Mind. $minOccurs auswählen.',
    );
  }

  @override
  String validatorMaxOccurs(int maxOccurs) {
    return intl.Intl.pluralLogic(
      maxOccurs,
      locale: localeName,
      one: 'Höchstens eine Auswahl.',
      other: 'Bis zu $maxOccurs auswählen.',
    );
  }

  @override
  String get dataAbsentReasonAskedDeclinedInputLabel =>
      'Ich möchte nicht antworten.';

  @override
  String get dataAbsentReasonAskedDeclinedOutput => 'Antwort abgelehnt';

  @override
  String get dataAbsentReasonAsTextOutput => '[FREITEXT]';

  @override
  String get narrativePageTitle => 'Freitext';

  @override
  String get questionnaireGenericTitle => 'Fragebogen';

  @override
  String get questionnaireUnknownTitle => '(ohne Titel)';

  @override
  String get questionnaireUnknownPublisher => '(unbekannte Quelle)';

  @override
  String get autoCompleteSearchTermInput => 'Suchbegriff eingeben…';

  @override
  String get responseStatusToCompleteButtonLabel => 'Fertig';

  @override
  String get responseStatusToInProgressButtonLabel => 'Ändern';

  @override
  String get progressQuestionnaireLoading => 'Der Fragebogen lädt…';

  @override
  String get handlingSaveButtonLabel => 'Speichern';

  @override
  String get handlingSaved => 'Survey saved.';

  @override
  String get handlingUploadButtonLabel => 'Hochladen';

  @override
  String get handlingUploading => 'Bogen hochladen…';

  @override
  String get handlingUploaded => 'Survey uploaded.';

  @override
  String get loginStatusLoggingIn => 'Anmelden…';

  @override
  String get loginStatusLoggedIn => 'Angemeldet…';

  @override
  String get loginStatusLoggingOut => 'Ich melde mich ab…';

  @override
  String get loginStatusLoggedOut => 'Abgemeldet…';

  @override
  String get loginStatusUnknown => 'Nicht sicher, was los ist?';

  @override
  String get loginStatusError => 'Etwas ist schief gelaufen.';
}
