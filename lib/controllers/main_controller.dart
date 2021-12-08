import 'package:drug_stores/controllers/admin_controller.dart';
import 'package:drug_stores/controllers/salesman_controller.dart';
import 'package:drug_stores/helper/device_info.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../helper/shared_preferences_helper.dart';

class MainController {
  static bool testing = false;

  static Future initServices() async {
    WidgetsFlutterBinding.ensureInitialized();
    await EasyLocalization.ensureInitialized();
    await SharedPreferencesHelper.init();
    await DeviceInfoHelper.configure();
    Get.put(AdminController());
    Get.put(SalesmanController());
  }
}
