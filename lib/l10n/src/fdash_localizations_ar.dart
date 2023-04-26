// ignore_for_file: avoid_escaping_inner_quotes, unnecessary_brace_in_string_interps, unnecessary_string_escapes, always_use_package_imports

import 'package:intl/intl.dart' as intl;
import 'fdash_localizations.g.dart';

/// The translations for Arabic (`ar`).
class FDashLocalizationsAr extends FDashLocalizations {
  FDashLocalizationsAr([super.locale = 'ar']);

  @override
  String get validatorRequiredItem => 'هذا السؤال يحتاج إلى أن يكتمل.';

  @override
  String validatorMinLength(int minLength) {
    return intl.Intl.pluralLogic(
      minLength,
      locale: localeName,
      one: 'أدخل على الأقل حرفًا واحدًا.',
      other: 'أدخل $minLength حرفًا على الأقل.',
    );
  }

  @override
  String validatorMaxLength(int maxLength) {
    return intl.Intl.pluralLogic(
      maxLength,
      locale: localeName,
      other: 'أدخل حتى $maxLength حرفًا.',
    );
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
