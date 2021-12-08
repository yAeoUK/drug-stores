import 'dart:convert';
import 'dart:math';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:drug_stores/configs/app_config.dart';
import 'package:drug_stores/configs/language_config.dart';
import 'package:drug_stores/controllers/main_controller.dart';
import 'package:drug_stores/helper/random.dart';
import 'package:flutter/material.dart';
import 'package:flutter_security_checker/flutter_security_checker.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:package_info_plus/package_info_plus.dart';

class DeviceInfoHelper {
  static late Map<String, String?> _data;

  static String buildModel = 'buildModel';
  static String androidAPI = 'androidAPI';
  static String rooted = 'rooted';
  static String isEmulator = 'isEmulator';
  static String appVersionName = 'appVersionName';
  static String appVersionCode = 'appVersionCode';
  static String appPackageName = 'appPackageName';
  static String appId = 'appId';
  static String appLanguage = 'appLanguage';

  static String getDeviceInfo() {
    if (!MainController.testing)
      _data.addAll({
        appLanguage: Localizations.localeOf(Get.context!).languageCode,
      });

    return json.encode(_data).toString();
  }

  static Future configure() async {
    if (MainController.testing) {
      Random random = Random();
      _data = {
        buildModel: Randoms.getRandomString(),
        androidAPI: random.nextInt(31).toString(),
        rooted: random.nextInt(2).toString(),
        isEmulator: random.nextInt(2).toString(),
        appVersionName: AppConfig.appVersionName,
        appVersionCode: AppConfig.appVersionCode.toString(),
        appPackageName: AppConfig.appPackageName,
        appId: AppConfig.appId.toString(),
        appLanguage: LanguageConfig
            .supportedLocales[
                random.nextInt(LanguageConfig.supportedLocales.length)]
            .languageCode
      };
      return;
    }
    final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    final AndroidDeviceInfo androidDeviceInfo =
        await deviceInfoPlugin.androidInfo;
    final isRooted = await FlutterSecurityChecker.isRooted;
    final PackageInfo packageInfo = await PackageInfo.fromPlatform();
    _data = {
      buildModel: androidDeviceInfo.model,
      androidAPI: androidDeviceInfo.version.sdkInt.toString(),
      rooted: isRooted ? '1' : '0',
      isEmulator: androidDeviceInfo.isPhysicalDevice! ? '0' : '1',
      appVersionName: packageInfo.version,
      appVersionCode: packageInfo.buildNumber,
      appPackageName: packageInfo.packageName,
      appId: AppConfig.appId.toString()
    };
  }
}
