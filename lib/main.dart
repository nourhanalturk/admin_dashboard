import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:tender/config/di/di.dart';
import 'package:tender/core/routes/routes.dart';
import 'package:tender/core/extensions/extensions.dart';


import 'config/constants/env_constants.dart';

void main() async {
  await initModule();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: Routes.login,
      onGenerateRoute: RouteGenerator.getRoute,
      debugShowCheckedModeBanner: dotenv.env[EnvConstants.debug].onNullBool(),
      // home: LoginView(),
    );
  }
}
