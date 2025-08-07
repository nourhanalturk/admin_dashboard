import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:tender/config/di/di.dart';
import 'package:tender/core/routes/routes.dart';
import 'package:tender/core/extensions/extensions.dart';


import 'config/constants/env_constants.dart';
import 'core/local/locale_controller.dart';
import 'core/local/locales.dart';

void main() async {
  await initModule();
  runApp(   EasyLocalization(
    supportedLocales: localeSettings.locales,
    path: translationPath,
    fallbackLocale: localeSettings.defaultLocale,
    startLocale: localeSettings.defaultLocale,
    child: const MyApp(),
  ),);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: localeSettings.defaultLocale,
      initialRoute: Routes.dashboard,
      onGenerateRoute: RouteGenerator.getRoute,
      debugShowCheckedModeBanner: dotenv.env[EnvConstants.debug].onNullBool(),
    );
  }
}
