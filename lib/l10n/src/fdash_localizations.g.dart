
import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'fdash_localizations_de.dart';
import 'fdash_localizations_en.dart';

/// Callers can lookup localized strings with an instance of FDashLocalizations returned
/// by `FDashLocalizations.of(context)`.
///
/// Applications need to include `FDashLocalizations.delegate()` in their app's
/// localizationDelegates list, and the locales they support in the app's
/// supportedLocales list. For example:
///
/// ```
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
/// ```
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # rest of dependencies
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
  FDashLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static FDashLocalizations? of(BuildContext context) {
    return Localizations.of<FDashLocalizations>(context, FDashLocalizations);
  }

  static const LocalizationsDelegate<FDashLocalizations> delegate = _FDashLocalizationsDelegate();

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
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('de'),
    Locale('en')
  ];

  /// No description provided for @validatorRequiredItem.
  ///
  /// In en, this message translates to:
  /// **'Provide this required answer.'**
  String get validatorRequiredItem;

  /// No description provided for @validatorMinLength.
  ///
  /// In en, this message translates to:
  /// **'{minLength, plural, =1 {Provide at least one character.} other {Provide at least {minLength} characters.}}'**
  String validatorMinLength(int minLength);

  /// No description provided for @validatorMaxLength.
  ///
  /// In en, this message translates to:
  /// **'{maxLength, plural, other{Provide up to {maxLength} characters.}}'**
  String validatorMaxLength(int maxLength);

  /// No description provided for @validatorUrl.
  ///
  /// In en, this message translates to:
  /// **'Provide a valid URL.'**
  String get validatorUrl;

  /// No description provided for @validatorRegExp.
  ///
  /// In en, this message translates to:
  /// **'Provide a valid answer.'**
  String get validatorRegExp;

  /// No description provided for @validatorEntryFormat.
  ///
  /// In en, this message translates to:
  /// **'Provide as {entryFormat}'**
  String validatorEntryFormat(String entryFormat);

  /// No description provided for @validatorMaxValue.
  ///
  /// In en, this message translates to:
  /// **'Provide a number up to {maxValue}.'**
  String validatorMaxValue(String maxValue);
}

class _FDashLocalizationsDelegate extends LocalizationsDelegate<FDashLocalizations> {
  const _FDashLocalizationsDelegate();

  @override
  Future<FDashLocalizations> load(Locale locale) {
    return SynchronousFuture<FDashLocalizations>(lookupFDashLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['de', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_FDashLocalizationsDelegate old) => false;
}

FDashLocalizations lookupFDashLocalizations(Locale locale) {
  


// Lookup logic when only language code is specified.
switch (locale.languageCode) {
  case 'de': return FDashLocalizationsDe();
    case 'en': return FDashLocalizationsEn();
}


  throw FlutterError(
    'FDashLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
