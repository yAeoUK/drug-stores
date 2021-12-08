import 'package:drug_stores/common/routes.dart';
import 'package:drug_stores/controllers/admin_controller.dart';
import 'package:drug_stores/controllers/salesman_controller.dart';
import 'package:drug_stores/screens/admin/home/home.dart';
import 'package:drug_stores/screens/salesman/home/home.dart';
import 'package:drug_stores/screens/welcome/welcome.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import 'configs/language_config.dart';
import 'controllers/main_controller.dart';

main() async {
  await MainController.initServices();
  runApp(EasyLocalization(
    child: MyApp(),
    supportedLocales: LanguageConfig.supportedLocales,
    path: LanguageConfig.translationPath,
    fallbackLocale: LanguageConfig.fallbackLocale,
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        localizationsDelegates: context.localizationDelegates,
        routes: routes,
        supportedLocales: context.supportedLocales,
        fallbackLocale: context.fallbackLocale,
        initialRoute: Get.find<AdminController>().isLoggedIn()
            ? AdminHomeScreen.routeName
            : Get.find<SalesmanController>().isLoggedIn()
                ? SalesmanHomeScreen.routeName
                : WelcomeScreen.routeName,
        locale: context.locale,
        defaultTransition: Transition.fade);
  }
}
