// ignore_for_file: avoid_escaping_inner_quotes, unnecessary_brace_in_string_interps, unnecessary_string_escapes, always_use_package_imports

import 'package:intl/intl.dart' as intl;

import 'fdash_localizations.g.dart';

/// The translations for Italian (`it`).
class FDashLocalizationsIt extends FDashLocalizations {
  FDashLocalizationsIt([String locale = 'it']) : super(locale);

  @override
  String get validatorRequiredItem => 'Questa domanda deve essere completata.';

  @override
  String validatorMinLength(num minLength) {
    String _temp0 = intl.Intl.pluralLogic(
      minLength,
      locale: localeName,
      other: 'Inserisci almeno $minLength caratteri.',
      one: 'Inserisci almeno un carattere.',
    );
    return '$_temp0';
  }

  @override
  String validatorMaxLength(num maxLength) {
    String _temp0 = intl.Intl.pluralLogic(
      maxLength,
      locale: localeName,
      other: 'Inserisci fino a $maxLength caratteri.',
    );
    return '$_temp0';
  }

  @override
  String get validatorUrl => 'Inserisci un URL valido nel formato https://...';

  @override
  String get validatorRegExp => 'Inserisci una risposta valida.';

  @override
  String validatorEntryFormat(String entryFormat) {
    return 'Inserisci nel formato $entryFormat.';
  }

  @override
  String get validatorNan => 'Inserisci un numero valido.';

  @override
  String validatorMinValue(String minValue) {
    return 'Inserisci un numero di $minValue o superiore.';
  }

  @override
  String validatorMaxValue(String maxValue) {
    return 'Inserisci un numero fino a $maxValue.';
  }

  @override
  String get dataAbsentReasonAskedDeclined => 'Ho scelto di non rispondere.';

  @override
  String get narrativePageTitle => 'Narrativa';

  @override
  String get questionnaireGenericTitle => 'Sondaggio';

  @override
  String get questionnaireUnknownTitle => 'Senza titolo';

  @override
  String get questionnaireUnknownPublisher => 'Editore sconosciuto';

  @override
  String get validatorDate => 'Inserisci una data valida.';

  @override
  String get validatorTime => 'Inserisci un orario valido.';

  @override
  String get validatorDateTime => 'Inserisci una data e un orario validi.';

  @override
  String validatorMinOccurs(num minOccurs) {
    String _temp0 = intl.Intl.pluralLogic(
      minOccurs,
      locale: localeName,
      other: 'Seleziona $minOccurs o più opzioni.',
      one: 'Seleziona almeno un\'opzione.',
    );
    return '$_temp0';
  }

  @override
  String validatorMaxOccurs(num maxOccurs) {
    String _temp0 = intl.Intl.pluralLogic(
      maxOccurs,
      locale: localeName,
      other: 'Seleziona fino a $maxOccurs opzioni.',
      one: 'Seleziona fino a una opzione.',
    );
    return '$_temp0';
  }

  @override
  String validatorSingleSelectionOrSingleOpenString(Object openLabel) {
    return 'Seleziona un\'opzione o inserisci testo libero in \"$openLabel\".';
  }

  @override
  String get dataAbsentReasonAskedDeclinedInputLabel =>
      'Ho scelto di non rispondere.';

  @override
  String get dataAbsentReasonAskedDeclinedOutput => 'Rifiutato di rispondere';

  @override
  String get dataAbsentReasonAsTextOutput => '[COME TESTO]';

  @override
  String get autoCompleteSearchTermInput => 'Inserisci termine di ricerca…';

  @override
  String get responseStatusToCompleteButtonLabel => 'Completa';

  @override
  String get responseStatusToInProgressButtonLabel => 'Modifica';

  @override
  String get progressQuestionnaireLoading => 'Il sondaggio è in caricamento…';

  @override
  String get handlingSaveButtonLabel => 'Salva';

  @override
  String get handlingUploadButtonLabel => 'Carica';

  @override
  String get handlingUploading => 'Caricamento del sondaggio…';

  @override
  String get loginStatusLoggingIn => 'Accesso in corso…';

  @override
  String get loginStatusLoggedIn => 'Accesso effettuato…';

  @override
  String get loginStatusLoggingOut => 'Uscita in corso…';

  @override
  String get loginStatusLoggedOut => 'Accesso terminato…';

  @override
  String get loginStatusUnknown => 'Non sono sicuro di cosa stia succedendo?';

  @override
  String get loginStatusError => 'Qualcosa è andato storto.';

  @override
  String get handlingSaved => 'Sondaggio salvato.';

  @override
  String get handlingUploaded => 'Sondaggio caricato.';

  @override
  String aggregationScore(Object score) {
    return 'Punteggio: $score';
  }

  @override
  String get aggregationTotalScoreTitle => 'Punteggio Totale';

  @override
  String get fillerOpenCodingOtherLabel => 'Altro';

  @override
  String fillerAddAnotherItemLabel(Object itemLabel) {
    return 'Aggiungi un altro \"$itemLabel\"';
  }

  @override
  String get fillerExclusiveOptionLabel => '(esclusivo)';
}
