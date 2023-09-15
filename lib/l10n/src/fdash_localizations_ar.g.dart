// ignore_for_file: avoid_escaping_inner_quotes, unnecessary_brace_in_string_interps, unnecessary_string_escapes, always_use_package_imports

import 'package:intl/intl.dart' as intl;

import 'fdash_localizations.g.dart';

/// The translations for Arabic (`ar`).
class FDashLocalizationsAr extends FDashLocalizations {
  FDashLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get validatorRequiredItem => 'هذا السؤال يحتاج إلى أن يكتمل.';

  @override
  String validatorMinLength(num minLength) {
    String _temp0 = intl.Intl.pluralLogic(
      minLength,
      locale: localeName,
      other: 'أدخل $minLength حرفًا على الأقل.',
      one: 'أدخل على الأقل حرفًا واحدًا.',
    );
    return '$_temp0';
  }

  @override
  String validatorMaxLength(num maxLength) {
    String _temp0 = intl.Intl.pluralLogic(
      maxLength,
      locale: localeName,
      other: 'أدخل حتى $maxLength حرفًا.',
    );
    return '$_temp0';
  }

  @override
  String get validatorUrl => 'أدخل عنوان URL صالحًا بتنسيق // :https';

  @override
  String get validatorRegExp => 'أدخل إجابة صالحة.';

  @override
  String validatorEntryFormat(String entryFormat) {
    return 'أدخل بتنسيق $entryFormat.';
  }

  @override
  String get validatorNan => 'أدخل رقمًا صالحًا.';

  @override
  String validatorMinValue(String minValue) {
    return 'أدخل رقم $minValue أو أعلى.';
  }

  @override
  String validatorMaxValue(String maxValue) {
    return 'أدخل رقمًا يصل إلى $maxValue.';
  }

  @override
  String get dataAbsentReasonAskedDeclined => 'اخترت عدم الرد.';

  @override
  String get narrativePageTitle => 'رواية';

  @override
  String get questionnaireGenericTitle => 'استطلاع';

  @override
  String get questionnaireUnknownTitle => 'بدون عنوان';

  @override
  String get questionnaireUnknownPublisher => 'ناشر غير معروف';

  @override
  String get validatorDate => 'أدخل تاريخًا صالحًا.';

  @override
  String get validatorTime => 'أدخل وقتًا صالحًا.';

  @override
  String get validatorDateTime => 'أدخل تاريخًا ووقتًا صالحين.';

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
  String get dataAbsentReasonAskedDeclinedInputLabel => 'اخترت عدم الرد.';

  @override
  String get dataAbsentReasonAskedDeclinedOutput => 'رفض الإجابة';

  @override
  String get dataAbsentReasonAsTextOutput => '[نص حر]';

  @override
  String get autoCompleteSearchTermInput => 'أدخل مصطلح البحث…';

  @override
  String get responseStatusToCompleteButtonLabel => 'اكتمال';

  @override
  String get responseStatusToInProgressButtonLabel => 'يعدل';

  @override
  String get progressQuestionnaireLoading => 'يتم تحميل الاستطلاع…';

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
