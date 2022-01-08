import 'package:drug_stores/screens/admin/drug_list/drug_list.dart';

// ignore: implementation_imports
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

class AdminHomeScreen extends GetView {
  static String routeName = '/admin/home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: ElevatedButton(
                child: Text('showDrugs'.tr()),
                onPressed: () => Get.toNamed(AdminDrugList.routeName),
              ),
            ),
          ),
          Divider(),
          Expanded(
            child: Center(
              child: ElevatedButton(
                child: Text('showOrders'.tr()),
                onPressed: () => Get.toNamed(AdminDrugList.routeName),
              ),
            ),
          ),
        ],
      ),
    );
  }
}