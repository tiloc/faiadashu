// ignore_for_file: avoid_escaping_inner_quotes, unnecessary_brace_in_string_interps, unnecessary_string_escapes, always_use_package_imports
import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'fdash_localizations_ar.g.dart';
import 'fdash_localizations_de.g.dart';
import 'fdash_localizations_en.g.dart';
import 'fdash_localizations_es.g.dart';
import 'fdash_localizations_fr.g.dart';
import 'fdash_localizations_it.g.dart';
import 'fdash_localizations_ja.g.dart';

/// Callers can lookup localized strings with an instance of FDashLocalizations
/// returned by `FDashLocalizations.of(context)`.
///
/// Applications need to include `FDashLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'src/fdash_localizations.g.dart';
///
/// return MaterialApp(
///   localizationsDelegates: FDashLocalizations.localizationsDelegates,
///   supportedLocales: FDashLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the FDashLocalizations.supportedLocales
/// property.
abstract class FDashLocalizations {
  FDashLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static FDashLocalizations of(BuildContext context) {
    return Localizations.of<FDashLocalizations>(context, FDashLocalizations)!;
  }

  static const LocalizationsDelegate<FDashLocalizations> delegate =
      _FDashLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('ar'),
    Locale('de'),
    Locale('es'),
    Locale('fr'),
    Locale('it'),
    Locale('ja')
  ];

  /// No description provided for @validatorRequiredItem.
  ///
  /// In en, this message translates to:
  /// **'This question needs to be completed.'**
  String get validatorRequiredItem;

  /// No description provided for @validatorMinLength.
  ///
  /// In en, this message translates to:
  /// **'{minLength, plural, =1 {Enter at least one character.} other {Enter at least {minLength} characters.}}'**
  String validatorMinLength(num minLength);

  /// No description provided for @validatorMaxLength.
  ///
  /// In en, this message translates to:
  /// **'{maxLength, plural, other{Enter up to {maxLength} characters.}}'**
  String validatorMaxLength(num maxLength);

  /// No description provided for @validatorUrl.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid URL in format https://...'**
  String get validatorUrl;

  /// No description provided for @validatorRegExp.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid response.'**
  String get validatorRegExp;

  /// No description provided for @validatorEntryFormat.
  ///
  /// In en, this message translates to:
  /// **'Enter in format {entryFormat}.'**
  String validatorEntryFormat(String entryFormat);

  /// No description provided for @validatorNan.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid number.'**
  String get validatorNan;

  /// No description provided for @validatorMinValue.
  ///
  /// In en, this message translates to:
  /// **'Enter a number of {minValue} or higher.'**
  String validatorMinValue(String minValue);

  /// No description provided for @validatorMaxValue.
  ///
  /// In en, this message translates to:
  /// **'Enter a number up to {maxValue}.'**
  String validatorMaxValue(String maxValue);

  /// No description provided for @dataAbsentReasonAskedDeclined.
  ///
  /// In en, this message translates to:
  /// **'I choose not to answer.'**
  String get dataAbsentReasonAskedDeclined;

  /// No description provided for @narrativePageTitle.
  ///
  /// In en, this message translates to:
  /// **'Narrative'**
  String get narrativePageTitle;

  /// No description provided for @questionnaireGenericTitle.
  ///
  /// In en, this message translates to:
  /// **'Survey'**
  String get questionnaireGenericTitle;

  /// No description provided for @questionnaireUnknownTitle.
  ///
  /// In en, this message translates to:
  /// **'Untitled'**
  String get questionnaireUnknownTitle;

  /// No description provided for @questionnaireUnknownPublisher.
  ///
  /// In en, this message translates to:
  /// **'Unknown publisher'**
  String get questionnaireUnknownPublisher;

  /// No description provided for @validatorDate.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid date.'**
  String get validatorDate;

  /// No description provided for @validatorTime.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid time.'**
  String get validatorTime;

  /// No description provided for @validatorDateTime.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid date and time.'**
  String get validatorDateTime;

  /// No description provided for @validatorMinOccurs.
  ///
  /// In en, this message translates to:
  /// **'{minOccurs, plural, =1 {Select at least one option.} other {Select {minOccurs} or more options.}}'**
  String validatorMinOccurs(num minOccurs);

  /// No description provided for @validatorMaxOccurs.
  ///
  /// In en, this message translates to:
  /// **'{maxOccurs, plural, =1 {Select up to one option.} other {Select up to {maxOccurs} options.}}'**
  String validatorMaxOccurs(num maxOccurs);

  /// No description provided for @validatorSingleSelectionOrSingleOpenString.
  ///
  /// In en, this message translates to:
  /// **'Either select an option, or enter free text in \"{openLabel}\".'**
  String validatorSingleSelectionOrSingleOpenString(Object openLabel);

  /// No description provided for @dataAbsentReasonAskedDeclinedInputLabel.
  ///
  /// In en, this message translates to:
  /// **'I choose not to answer.'**
  String get dataAbsentReasonAskedDeclinedInputLabel;

  /// No description provided for @dataAbsentReasonAskedDeclinedOutput.
  ///
  /// In en, this message translates to:
  /// **'Declined to answer'**
  String get dataAbsentReasonAskedDeclinedOutput;

  /// No description provided for @dataAbsentReasonAsTextOutput.
  ///
  /// In en, this message translates to:
  /// **'[AS TEXT]'**
  String get dataAbsentReasonAsTextOutput;

  /// No description provided for @autoCompleteSearchTermInput.
  ///
  /// In en, this message translates to:
  /// **'Enter search term…'**
  String get autoCompleteSearchTermInput;

  /// No description provided for @responseStatusToCompleteButtonLabel.
  ///
  /// In en, this message translates to:
  /// **'Complete'**
  String get responseStatusToCompleteButtonLabel;

  /// No description provided for @responseStatusToInProgressButtonLabel.
  ///
  /// In en, this message translates to:
  /// **'Amend'**
  String get responseStatusToInProgressButtonLabel;

  /// No description provided for @progressQuestionnaireLoading.
  ///
  /// In en, this message translates to:
  /// **'The survey is loading…'**
  String get progressQuestionnaireLoading;

  /// No description provided for @handlingSaveButtonLabel.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get handlingSaveButtonLabel;

  /// No description provided for @handlingUploadButtonLabel.
  ///
  /// In en, this message translates to:
  /// **'Upload'**
  String get handlingUploadButtonLabel;

  /// No description provided for @handlingUploading.
  ///
  /// In en, this message translates to:
  /// **'Uploading survey…'**
  String get handlingUploading;

  /// No description provided for @loginStatusLoggingIn.
  ///
  /// In en, this message translates to:
  /// **'Signing in…'**
  String get loginStatusLoggingIn;

  /// No description provided for @loginStatusLoggedIn.
  ///
  /// In en, this message translates to:
  /// **'Signed in…'**
  String get loginStatusLoggedIn;

  /// No description provided for @loginStatusLoggingOut.
  ///
  /// In en, this message translates to:
  /// **'Signing out…'**
  String get loginStatusLoggingOut;

  /// No description provided for @loginStatusLoggedOut.
  ///
  /// In en, this message translates to:
  /// **'Signed out…'**
  String get loginStatusLoggedOut;

  /// No description provided for @loginStatusUnknown.
  ///
  /// In en, this message translates to:
  /// **'Not sure what\'s going on?'**
  String get loginStatusUnknown;

  /// No description provided for @loginStatusError.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong.'**
  String get loginStatusError;

  /// No description provided for @handlingSaved.
  ///
  /// In en, this message translates to:
  /// **'Survey saved.'**
  String get handlingSaved;

  /// No description provided for @handlingUploaded.
  ///
  /// In en, this message translates to:
  /// **'Survey uploaded.'**
  String get handlingUploaded;

  /// No description provided for @aggregationScore.
  ///
  /// In en, this message translates to:
  /// **'Score: {score}'**
  String aggregationScore(Object score);

  /// No description provided for @aggregationTotalScoreTitle.
  ///
  /// In en, this message translates to:
  /// **'Total Score'**
  String get aggregationTotalScoreTitle;

  /// No description provided for @fillerOpenCodingOtherLabel.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get fillerOpenCodingOtherLabel;

  /// No description provided for @fillerAddAnotherItemLabel.
  ///
  /// In en, this message translates to:
  /// **'Add another \"{itemLabel}\"'**
  String fillerAddAnotherItemLabel(Object itemLabel);

  /// No description provided for @fillerExclusiveOptionLabel.
  ///
  /// In en, this message translates to:
  /// **'(exclusive)'**
  String get fillerExclusiveOptionLabel;
}

class _FDashLocalizationsDelegate
    extends LocalizationsDelegate<FDashLocalizations> {
  const _FDashLocalizationsDelegate();

  @override
  Future<FDashLocalizations> load(Locale locale) {
    return SynchronousFuture<FDashLocalizations>(
        lookupFDashLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
        'ar',
        'de',
        'en',
        'es',
        'fr',
        'it',
        'ja'
      ].contains(locale.languageCode);

  @override
  bool shouldReload(_FDashLocalizationsDelegate old) => false;
}

FDashLocalizations lookupFDashLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return FDashLocalizationsAr();
    case 'de':
      return FDashLocalizationsDe();
    case 'en':
      return FDashLocalizationsEn();
    case 'es':
      return FDashLocalizationsEs();
    case 'fr':
      return FDashLocalizationsFr();
    case 'it':
      return FDashLocalizationsIt();
    case 'ja':
      return FDashLocalizationsJa();
  }

  throw FlutterError(
      'FDashLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
