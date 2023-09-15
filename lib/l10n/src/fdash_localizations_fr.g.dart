// ignore_for_file: avoid_escaping_inner_quotes, unnecessary_brace_in_string_interps, unnecessary_string_escapes, always_use_package_imports

import 'package:intl/intl.dart' as intl;

import 'fdash_localizations.g.dart';

/// The translations for French (`fr`).
class FDashLocalizationsFr extends FDashLocalizations {
  FDashLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get validatorRequiredItem => 'Cette question doit être complétée.';

  @override
  String validatorMinLength(num minLength) {
    String _temp0 = intl.Intl.pluralLogic(
      minLength,
      locale: localeName,
      other: 'Entrez au moins $minLength caractères.',
      one: 'Entrez au moins un caractère.',
    );
    return '$_temp0';
  }

  @override
  String validatorMaxLength(num maxLength) {
    String _temp0 = intl.Intl.pluralLogic(
      maxLength,
      locale: localeName,
      other: 'Entrez jusqu\'à $maxLength caractères.',
    );
    return '$_temp0';
  }

  @override
  String get validatorUrl => 'Entrez une URL valide au format https://...';

  @override
  String get validatorRegExp => 'Entrez une réponse valide.';

  @override
  String validatorEntryFormat(String entryFormat) {
    return 'Entrez dans le format $entryFormat.';
  }

  @override
  String get validatorNan => 'Entrez un nombre valide.';

  @override
  String validatorMinValue(String minValue) {
    return 'Entrez un nombre de $minValue ou supérieur.';
  }

  @override
  String validatorMaxValue(String maxValue) {
    return 'Entrez un nombre jusqu\'à $maxValue.';
  }

  @override
  String get dataAbsentReasonAskedDeclined => 'Je choisis de ne pas répondre.';

  @override
  String get narrativePageTitle => 'Narratif';

  @override
  String get questionnaireGenericTitle => 'Sondage';

  @override
  String get questionnaireUnknownTitle => 'Sans titre';

  @override
  String get questionnaireUnknownPublisher => 'Éditeur inconnu';

  @override
  String get validatorDate => 'Entrez une date valide.';

  @override
  String get validatorTime => 'Entrez une heure valide.';

  @override
  String get validatorDateTime => 'Entrez une date et une heure valides.';

  @override
  String validatorMinOccurs(num minOccurs) {
    String _temp0 = intl.Intl.pluralLogic(
      minOccurs,
      locale: localeName,
      other: 'Sélectionnez $minOccurs options ou plus.',
      one: 'Sélectionnez au moins une option.',
    );
    return '$_temp0';
  }

  @override
  String validatorMaxOccurs(num maxOccurs) {
    String _temp0 = intl.Intl.pluralLogic(
      maxOccurs,
      locale: localeName,
      other: 'Sélectionnez jusqu\'à $maxOccurs options.',
      one: 'Sélectionnez jusqu\'à une option.',
    );
    return '$_temp0';
  }

  @override
  String validatorSingleSelectionOrSingleOpenString(Object openLabel) {
    return 'Sélectionnez une option ou saisissez du texte libre dans \"$openLabel\".';
  }

  @override
  String get dataAbsentReasonAskedDeclinedInputLabel =>
      'Je choisis de ne pas répondre.';

  @override
  String get dataAbsentReasonAskedDeclinedOutput => 'Refusé de répondre';

  @override
  String get dataAbsentReasonAsTextOutput => '[COMME TEXTE]';

  @override
  String get autoCompleteSearchTermInput => 'Entrez un terme de recherche…';

  @override
  String get responseStatusToCompleteButtonLabel => 'Compléter';

  @override
  String get responseStatusToInProgressButtonLabel => 'Modifier';

  @override
  String get progressQuestionnaireLoading =>
      'L\'enquête est en cours de chargement…';

  @override
  String get handlingSaveButtonLabel => 'Enregistrer';

  @override
  String get handlingUploadButtonLabel => 'Télécharger';

  @override
  String get handlingUploading => 'Téléchargement de l\'enquête…';

  @override
  String get loginStatusLoggingIn => 'Connexion en cours…';

  @override
  String get loginStatusLoggedIn => 'Connecté…';

  @override
  String get loginStatusLoggingOut => 'Déconnexion en cours…';

  @override
  String get loginStatusLoggedOut => 'Déconnecté…';

  @override
  String get loginStatusUnknown => 'Pas sûr de ce qui se passe ?';

  @override
  String get loginStatusError => 'Quelque chose s\'est mal passé.';

  @override
  String get handlingSaved => 'Enquête enregistrée.';

  @override
  String get handlingUploaded => 'Enquête téléchargée.';

  @override
  String aggregationScore(Object score) {
    return 'Score : $score';
  }

  @override
  String get aggregationTotalScoreTitle => 'Score total';

  @override
  String get fillerOpenCodingOtherLabel => 'Autre';

  @override
  String fillerAddAnotherItemLabel(Object itemLabel) {
    return 'Ajouter un autre \"$itemLabel\"';
  }

  @override
  String get fillerExclusiveOptionLabel => '(exclusif)';
}
