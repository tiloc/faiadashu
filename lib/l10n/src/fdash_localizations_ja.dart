

import 'package:intl/intl.dart' as intl;
import 'fdash_localizations.g.dart';

/// The translations for Japanese (`ja`).
class FDashLocalizationsJa extends FDashLocalizations {
  FDashLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get validatorRequiredItem => 'この質問は完了する必要があります。';

  @override
  String validatorMinLength(int minLength) {
    return intl.Intl.pluralLogic(
      minLength,
      locale: localeName,
      one: '最低1文字入力してください',
      other: '最低$minLength文字入力してください。',
    );
  }

  @override
  String validatorMaxLength(int maxLength) {
    return intl.Intl.pluralLogic(
      maxLength,
      locale: localeName,
      other: '最大$maxLength文字まで入力できます。',
    );
  }

  @override
  String get validatorUrl => '有効なURLをフォーマット https://... で入力してください。';

  @override
  String get validatorRegExp => '有効な回答を入力してください。';

  @override
  String validatorEntryFormat(String entryFormat) {
    return 'フォーマット$entryFormatで入力してください。';
  }

  @override
  String get validatorDate => 'Enter a valid date.';

  @override
  String get validatorTime => 'Enter a valid time.';

  @override
  String get validatorDateTime => 'Enter a valid date and time.';

  @override
  String get validatorNan => '有効な数字を入力してください。';

  @override
  String validatorMinValue(String minValue) {
    return '$minValue以上の数値を入力してください。';
  }

  @override
  String validatorMaxValue(String maxValue) {
    return '$maxValueまでの数値を入力してください。';
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
  String get dataAbsentReasonAskedDeclinedInputLabel => 'I choose not to answer.';

  @override
  String get dataAbsentReasonAskedDeclinedOutput => 'Declined to answer';

  @override
  String get dataAbsentReasonAsTextOutput => '[AS TEXT]';

  @override
  String get narrativePageTitle => 'ナラティブ';

  @override
  String get questionnaireGenericTitle => '調査';

  @override
  String get questionnaireUnknownTitle => '無題';

  @override
  String get questionnaireUnknownPublisher => '出版社不明';

  @override
  String get autoCompleteSearchTermInput => 'Enter search term…';

  @override
  String get responseStatusToCompleteButtonLabel => 'Complete';

  @override
  String get responseStatusToInProgressButtonLabel => 'Amend';

  @override
  String get progressQuestionnaireLoading => 'The survey is loading…';
}
