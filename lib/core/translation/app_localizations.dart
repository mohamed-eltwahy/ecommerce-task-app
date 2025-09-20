import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';
import 'app_localizations_fr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'translation/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
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
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

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
    Locale('ar'),
    Locale('en'),
    Locale('fr'),
  ];

  /// No description provided for @errorFieldRequired.
  ///
  /// In en, this message translates to:
  /// **'This field is required'**
  String get errorFieldRequired;

  /// No description provided for @errorInvalidName.
  ///
  /// In en, this message translates to:
  /// **'Invalid name format'**
  String get errorInvalidName;

  /// No description provided for @errorInvalidUrl.
  ///
  /// In en, this message translates to:
  /// **'Invalid URL'**
  String get errorInvalidUrl;

  /// No description provided for @errorInvalidPhoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Invalid phone number'**
  String get errorInvalidPhoneNumber;

  /// No description provided for @errorInvalidEmail.
  ///
  /// In en, this message translates to:
  /// **'Invalid email address'**
  String get errorInvalidEmail;

  /// No description provided for @errorInvalidPassword.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 8 characters long with uppercase, lowercase, and special characters'**
  String get errorInvalidPassword;

  /// No description provided for @errorPasswordMismatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get errorPasswordMismatch;

  /// No description provided for @errorInvalidNumber.
  ///
  /// In en, this message translates to:
  /// **'Invalid number'**
  String get errorInvalidNumber;

  /// No description provided for @errorInvalidIban.
  ///
  /// In en, this message translates to:
  /// **'Invalid IBAN format'**
  String get errorInvalidIban;

  /// No description provided for @errorInvalidMobileNumber.
  ///
  /// In en, this message translates to:
  /// **'Invalid mobile number'**
  String get errorInvalidMobileNumber;

  /// No description provided for @errorInvalidStcPayId.
  ///
  /// In en, this message translates to:
  /// **'Invalid STC Pay ID'**
  String get errorInvalidStcPayId;

  /// No description provided for @errorInvalidNationalId.
  ///
  /// In en, this message translates to:
  /// **'Invalid National ID'**
  String get errorInvalidNationalId;

  /// No description provided for @errorInvalidPassport.
  ///
  /// In en, this message translates to:
  /// **'Invalid passport number'**
  String get errorInvalidPassport;

  /// No description provided for @errorPhoneValidation.
  ///
  /// In en, this message translates to:
  /// **'The phone number must start with {start} and be {length} digits long.'**
  String errorPhoneValidation(Object length, Object start);

  /// No description provided for @errorExperienceRequired.
  ///
  /// In en, this message translates to:
  /// **'You must add at least one experience.'**
  String get errorExperienceRequired;

  /// No description provided for @errorIdDocumentRequired.
  ///
  /// In en, this message translates to:
  /// **'You must upload an ID document to verify your identity.'**
  String get errorIdDocumentRequired;

  /// No description provided for @errorPhotoRequired.
  ///
  /// In en, this message translates to:
  /// **'You must upload a photo with a white background.'**
  String get errorPhotoRequired;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en', 'fr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
    case 'fr':
      return AppLocalizationsFr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
