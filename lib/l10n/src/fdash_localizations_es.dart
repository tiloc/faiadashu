// ignore_for_file: avoid_escaping_inner_quotes

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
  String get validatorUrl =>
      'Introduzca una URL válida con el formato https://...';

  @override
  String get validatorRegExp => 'Introduzca una respuesta válida.';

  @override
  String validatorEntryFormat(String entryFormat) {
    return 'Introduzca el formato $entryFormat.';
  }

  @override
  String get validatorDate => 'Enter a valid date.';

  @override
  String get validatorTime => 'Enter a valid time.';

  @override
  String get validatorDateTime => 'Enter a valid date and time.';

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
  String validatorMinOccurs(int minOccurs) {
    return intl.Intl.pluralLogic(
      minOccurs,
      locale: localeName,
      one: 'Select at least one option.',
      other: 'Select $minOccurs or more options.',
    );
  }

  @override
  String validatorMaxOccurs(int maxOccurs) {
    return intl.Intl.pluralLogic(
      maxOccurs,
      locale: localeName,
      one: 'Select up to one option.',
      other: 'Select up to $maxOccurs options.',
    );
  }

  @override
  String get dataAbsentReasonAskedDeclinedInputLabel =>
      'I choose not to answer.';

  @override
  String get dataAbsentReasonAskedDeclinedOutput => 'Declined to answer';

  @override
  String get dataAbsentReasonAsTextOutput => '[AS TEXT]';

  @override
  String get narrativePageTitle => 'Narrativa';

  @override
  String get questionnaireGenericTitle => 'Encuesta';

  @override
  String get questionnaireUnknownTitle => 'Sin título';

  @override
  String get questionnaireUnknownPublisher => 'Editor desconocido';

  @override
  String get autoCompleteSearchTermInput => 'Enter search term…';

  @override
  String get responseStatusToCompleteButtonLabel => 'Complete';

  @override
  String get responseStatusToInProgressButtonLabel => 'Amend';

  @override
  String get progressQuestionnaireLoading => 'The survey is loading…';

  @override
  String get handlingSaveButtonLabel => 'Save';

  @override
  String get handlingSaved => 'Survey saved.';

  @override
  String get handlingUploadButtonLabel => 'Upload';

  @override
  String get handlingUploading => 'Uploading survey…';

  @override
  String get handlingUploaded => 'Survey uploaded.';

  @override
  String get loginStatusLoggingIn => 'Signing in…';

  @override
  String get loginStatusLoggedIn => 'Signed in…';

  @override
  String get loginStatusLoggingOut => 'Signing out…';

  @override
  String get loginStatusLoggedOut => 'Signed out…';

  @override
  String get loginStatusUnknown => 'Not sure what\'s going on?';

  @override
  String get loginStatusError => 'Something went wrong.';

  @override
  String aggregationScore(Object score) {
    return 'Score: $score';
  }

  @override
  String get aggregationTotalScoreTitle => 'Total Score';
}
