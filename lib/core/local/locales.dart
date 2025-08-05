import 'dart:ui';

import 'package:tender/core/storage/local/app_settings_prefs.dart';

import '../../config/constants/constants.dart';
import '../../config/di/di.dart';

LocaleSettings localeSettings = LocaleSettings();
class LocaleSettings {
  final AppSettingsPrefs prefs;

  LocaleSettings() : prefs = instance<AppSettingsPrefs>();

  static const Map<String, String> languages = {
    Constants.arabic: Constants.arabicName,
    Constants.english: Constants.englishName,
  };

  List<Locale> get locales => languages.keys
      .map(
        (e) => Locale(e),
      )
      .toList();

  Locale get defaultLocale => Locale(prefs.getLocale());
}
