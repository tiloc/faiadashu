// ignore_for_file: avoid_escaping_inner_quotes, unnecessary_brace_in_string_interps, unnecessary_string_escapes

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

  @override
  String get validatorDate => 'Enter a valid date.';

  @override
  String get validatorTime => 'Enter a valid time.';

  @override
  String get validatorDateTime => 'Enter a valid date and time.';

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
}
