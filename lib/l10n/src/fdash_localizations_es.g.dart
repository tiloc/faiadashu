// ignore_for_file: avoid_escaping_inner_quotes, unnecessary_brace_in_string_interps, unnecessary_string_escapes, always_use_package_imports

import 'package:intl/intl.dart' as intl;

import 'fdash_localizations.g.dart';

/// The translations for Spanish Castilian (`es`).
class FDashLocalizationsEs extends FDashLocalizations {
  FDashLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get validatorRequiredItem => 'Esta pregunta debe ser completada.';

  @override
  String validatorMinLength(num minLength) {
    String _temp0 = intl.Intl.pluralLogic(
      minLength,
      locale: localeName,
      other: 'Introducir al menos $minLength caracteres.',
      one: 'Introducir al menos un carácter.',
    );
    return '$_temp0';
  }

  @override
  String validatorMaxLength(num maxLength) {
    String _temp0 = intl.Intl.pluralLogic(
      maxLength,
      locale: localeName,
      other: 'Ingrese hasta $maxLength caracteres.',
    );
    return '$_temp0';
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
  String get dataAbsentReasonAskedDeclined => 'He decidido no responder.';

  @override
  String get narrativePageTitle => 'Narrativa';

  @override
  String get questionnaireGenericTitle => 'Encuesta';

  @override
  String get questionnaireUnknownTitle => 'Sin título';

  @override
  String get questionnaireUnknownPublisher => 'Editor desconocido';

  @override
  String get validatorDate => 'Enter a valid date.';

  @override
  String get validatorTime => 'Enter a valid time.';

  @override
  String get validatorDateTime => 'Enter a valid date and time.';

  @override
  String validatorMinOccurs(num minOccurs) {
    String _temp0 = intl.Intl.pluralLogic(
      minOccurs,
      locale: localeName,
      other: 'Select $minOccurs or more options.',
      one: 'Select at least one option.',
    );
    return '$_temp0';
  }

  @override
  String validatorMaxOccurs(num maxOccurs) {
    String _temp0 = intl.Intl.pluralLogic(
      maxOccurs,
      locale: localeName,
      other: 'Select up to $maxOccurs options.',
      one: 'Select up to one option.',
    );
    return '$_temp0';
  }

  @override
  String validatorSingleSelectionOrSingleOpenString(Object openLabel) {
    return 'Either select an option, or enter free text in \"$openLabel\".';
  }

  @override
  String get dataAbsentReasonAskedDeclinedInputLabel =>
      'I choose not to answer.';

  @override
  String get dataAbsentReasonAskedDeclinedOutput => 'Declined to answer';

  @override
  String get dataAbsentReasonAsTextOutput => '[AS TEXT]';

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
  String get handlingUploadButtonLabel => 'Upload';

  @override
  String get handlingUploading => 'Uploading survey…';

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
  String get handlingSaved => 'Survey saved.';

  @override
  String get handlingUploaded => 'Survey uploaded.';

  @override
  String aggregationScore(Object score) {
    return 'Score: $score';
  }

  @override
  String get aggregationTotalScoreTitle => 'Total Score';

  @override
  String get fillerOpenCodingOtherLabel => 'Other';

  @override
  String fillerAddAnotherItemLabel(Object itemLabel) {
    return 'Add another \"$itemLabel\"';
  }

  @override
  String get fillerExclusiveOptionLabel => '(exclusive)';
}
