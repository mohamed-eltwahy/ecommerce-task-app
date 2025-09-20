import 'package:ecommerce_app/core/translation/app_localizations.dart';
import 'package:flutter/material.dart';
extension AppLocalizationsX on BuildContext {
  AppLocalizations get tr => AppLocalizations.of(this)!;
}