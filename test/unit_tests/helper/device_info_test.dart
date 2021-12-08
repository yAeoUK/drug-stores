import 'dart:convert';

import 'package:drug_stores/configs/app_config.dart';
import 'package:drug_stores/configs/language_config.dart';
import 'package:drug_stores/controllers/main_controller.dart';
import 'package:drug_stores/helper/device_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Map? info;
  setUpAll(() async {
    MainController.testing = true;
    await DeviceInfoHelper.configure();
    info = jsonDecode(DeviceInfoHelper.getDeviceInfo());
  });
  test('Test device info has ${DeviceInfoHelper.buildModel}', () {
    expect(info!.containsKey(DeviceInfoHelper.buildModel), true);
  });
  test('Test device info has ${DeviceInfoHelper.androidAPI}', () {
    expect(info!.containsKey(DeviceInfoHelper.androidAPI), true);
  });
  test('Test device info has ${DeviceInfoHelper.rooted}', () {
    expect(info!.containsKey(DeviceInfoHelper.rooted), true);
    expect(int.parse(info![DeviceInfoHelper.rooted]) < 2, true);
  });
  test('Test device info has ${DeviceInfoHelper.isEmulator}', () {
    expect(info!.containsKey(DeviceInfoHelper.isEmulator), true);
    expect(int.parse(info![DeviceInfoHelper.isEmulator]) < 2, true);
  });
  test('Test device info has ${DeviceInfoHelper.appVersionName}', () {
    expect(info!.containsKey(DeviceInfoHelper.appPackageName), true);
    expect(info![DeviceInfoHelper.appVersionName], AppConfig.appVersionName);
  });
  test('Test device info has ${DeviceInfoHelper.appVersionCode}', () {
    expect(info!.containsKey(DeviceInfoHelper.appVersionCode), true);
    expect(info![DeviceInfoHelper.appVersionCode],
        AppConfig.appVersionCode.toString());
  });
  test('Test device info has ${DeviceInfoHelper.appVersionName}', () {
    expect(info!.containsKey(DeviceInfoHelper.appPackageName), true);
    expect(info![DeviceInfoHelper.appPackageName], AppConfig.appPackageName);
  });
  test('Test device info has ${DeviceInfoHelper.appId}', () {
    expect(info!.containsKey(DeviceInfoHelper.appId), true);
    expect(info![DeviceInfoHelper.appId], AppConfig.appId.toString());
  });
  test('Test device info has ${DeviceInfoHelper.appLanguage}', () {
    expect(info!.containsKey(DeviceInfoHelper.appLanguage), true);
    expect(
        LanguageConfig.supportedLocales
            .contains(Locale(info![DeviceInfoHelper.appLanguage])),
        true);
  });
}
