// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:quize_app/config/di/di.dart';
// import 'package:quize_app/core/extensions/extensions.dart';
// import '../storage/local/app_settings_prefs.dart';
//
// class LocaleController extends GetxController {
//   Locale? locale;
//   final AppSettingsPrefs _appSettingsPrefs = instance<AppSettingsPrefs>();
//
//   BuildContext context = Get.context!;
//
//   changeLanguage(String langCode) {
//     Locale locale = Locale(langCode);
//     _appSettingsPrefs.setLocale(
//       langCode,
//     );
//     EasyLocalization.of(context)!.setLocale(Locale(langCode));
//     Get.updateLocale(locale);
//   }
//
//   @override
//   void onInit() {
//     super.onInit();
//     final appLocale = _appSettingsPrefs.getLocale().pareWithDefaultLocale();
//     locale = _getLocaleFromString(appLocale);
//   }
//
//   Locale _getLocaleFromString(String appLocale) {
//     switch (appLocale) {
//       case 'ar':
//         return const Locale('ar');
//       case 'en':
//         return const Locale('en');
//       default:
//         return Locale(Get.deviceLocale!.languageCode);
//     }
//   }
// }
