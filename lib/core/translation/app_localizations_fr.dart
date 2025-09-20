// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get errorFieldRequired => 'Ce champ est obligatoire';

  @override
  String get errorInvalidName => 'Format du nom invalide';

  @override
  String get errorInvalidUrl => 'URL invalide';

  @override
  String get errorInvalidPhoneNumber => 'Numéro de téléphone invalide';

  @override
  String get errorInvalidEmail => 'Adresse e-mail invalide';

  @override
  String get errorInvalidPassword =>
      'Le mot de passe doit contenir au moins 8 caractères avec majuscule, minuscule et caractères spéciaux';

  @override
  String get errorPasswordMismatch => 'Les mots de passe ne correspondent pas';

  @override
  String get errorInvalidNumber => 'Numéro invalide';

  @override
  String get errorInvalidIban => 'Format IBAN invalide';

  @override
  String get errorInvalidMobileNumber => 'Numéro mobile invalide';

  @override
  String get errorInvalidStcPayId => 'Identifiant STC Pay invalide';

  @override
  String get errorInvalidNationalId => 'Numéro d\'identité nationale invalide';

  @override
  String get errorInvalidPassport => 'Numéro de passeport invalide';

  @override
  String errorPhoneValidation(Object length, Object start) {
    return 'Le numéro de téléphone doit commencer par $start et comporter $length chiffres.';
  }

  @override
  String get errorExperienceRequired =>
      'Vous devez ajouter au moins une expérience.';

  @override
  String get errorIdDocumentRequired =>
      'Vous devez téléverser un document d\'identité pour vérifier votre identité.';

  @override
  String get errorPhotoRequired =>
      'Vous devez téléverser une photo avec un fond blanc.';
}
