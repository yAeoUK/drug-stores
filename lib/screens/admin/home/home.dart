import 'package:drug_stores/common/enums.dart';
import 'package:drug_stores/controllers/admin_controller.dart';
import 'package:drug_stores/dialogues/yes_no_dialogue.dart';
import 'package:drug_stores/screens/admin/drug_list/drug_list.dart';
import 'package:drug_stores/screens/admin/order_list/order_list.dart';
import 'package:drug_stores/screens/admin/pharmacy_list/pharmacy_list.dart';
import 'package:drug_stores/screens/welcome/welcome.dart';

// ignore: implementation_imports
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

class AdminHomeScreen extends GetView {
  static String routeName = '/admin/home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                showDialog<DialogueResponse>(
                    context: context,
                    builder: (BuildContext context) {
                      return YesNoDialogue(
                          title: 'confirmLogout'.tr(),
                          content: 'confirmLogoutExplanation'.tr());
                    }).then((value) {
                  if (value == DialogueResponse.yes) {
                    Get.find<AdminController>().logout();
                    Get.offAndToNamed(WelcomeScreen.routeName);
                  }
                });
              },
              icon: Icon(Icons.logout))
        ],
      ),
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
                onPressed: () => Get.toNamed(AdminOrderList.routeName),
              ),
            ),
          ),
          Divider(),
          Expanded(
            child: Center(
              child: ElevatedButton(
                child: Text('showPharmacies'.tr()),
                onPressed: () => Get.toNamed(AdminPharmacyList.routeName),
              ),
            ),
          )
        ],
      ),
    );
  }
}
