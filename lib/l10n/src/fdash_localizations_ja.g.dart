// ignore_for_file: avoid_escaping_inner_quotes, unnecessary_brace_in_string_interps, unnecessary_string_escapes, always_use_package_imports

import 'package:intl/intl.dart' as intl;

import 'fdash_localizations.g.dart';

/// The translations for Japanese (`ja`).
class FDashLocalizationsJa extends FDashLocalizations {
  FDashLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get validatorRequiredItem => 'この質問は完了する必要があります。';

  @override
  String validatorMinLength(num minLength) {
    String _temp0 = intl.Intl.pluralLogic(
      minLength,
      locale: localeName,
      other: '最低$minLength文字入力してください。',
      one: '最低1文字入力してください',
    );
    return '$_temp0';
  }

  @override
  String validatorMaxLength(num maxLength) {
    String _temp0 = intl.Intl.pluralLogic(
      maxLength,
      locale: localeName,
      other: '最大$maxLength文字まで入力できます。',
    );
    return '$_temp0';
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
  String get dataAbsentReasonAskedDeclined => '私は答えないことにしている。';

  @override
  String get narrativePageTitle => 'ナラティブ';

  @override
  String get questionnaireGenericTitle => '調査';

  @override
  String get questionnaireUnknownTitle => '無題';

  @override
  String get questionnaireUnknownPublisher => '出版社不明';

  @override
  String get validatorDate => '有効な日付を入力してください。';

  @override
  String get validatorTime => '有効な時間を入力してください。';

  @override
  String get validatorDateTime => '有効な日付と時刻を入力してください。';

  @override
  String validatorMinOccurs(num minOccurs) {
    String _temp0 = intl.Intl.pluralLogic(
      minOccurs,
      locale: localeName,
      other: '$minOccurs以上の選択肢を選ぶ',
      one: '少なくとも1つの選択肢を選ぶ',
    );
    return '$_temp0。';
  }

  @override
  String validatorMaxOccurs(num maxOccurs) {
    String _temp0 = intl.Intl.pluralLogic(
      maxOccurs,
      locale: localeName,
      other: '$maxOccurs選択肢を1つまで選ぶ',
      one: '選択肢を1つまで選ぶ',
    );
    return '$_temp0。';
  }

  @override
  String validatorSingleSelectionOrSingleOpenString(Object openLabel) {
    return 'Either select an option, or enter free text in \"$openLabel\".';
  }

  @override
  String get dataAbsentReasonAskedDeclinedInputLabel => '私は答えないことにしている。';

  @override
  String get dataAbsentReasonAskedDeclinedOutput => '回答を拒否した';

  @override
  String get dataAbsentReasonAsTextOutput => '[フリーテキスト]';

  @override
  String get autoCompleteSearchTermInput => '検索語を入力...';

  @override
  String get responseStatusToCompleteButtonLabel => '完成';

  @override
  String get responseStatusToInProgressButtonLabel => '修正';

  @override
  String get progressQuestionnaireLoading => 'アンケートの読み込み中...';

  @override
  String get handlingSaveButtonLabel => '保存';

  @override
  String get handlingUploadButtonLabel => 'アップロード';

  @override
  String get handlingUploading => 'アンケートのアップロード...';

  @override
  String get loginStatusLoggingIn => 'サインインすると...';

  @override
  String get loginStatusLoggedIn => 'サインは...';

  @override
  String get loginStatusLoggingOut => 'サインアウト...';

  @override
  String get loginStatusLoggedOut => 'サインアウト...';

  @override
  String get loginStatusUnknown => '何が起こっているのかわからない？';

  @override
  String get loginStatusError => '何かが間違っていた。';

  @override
  String get handlingSaved => 'アンケートは保存しました。';

  @override
  String get handlingUploaded => 'アンケートをアップしました。';

  @override
  String aggregationScore(Object score) {
    return 'スコア：$score';
  }

  @override
  String get aggregationTotalScoreTitle => 'トータルスコア';

  @override
  String get fillerOpenCodingOtherLabel => 'Other';

  @override
  String fillerAddAnotherItemLabel(Object itemLabel) {
    return 'Add another \"$itemLabel\"';
  }

  @override
  String get fillerExclusiveOptionLabel => '(exclusive)';
}
