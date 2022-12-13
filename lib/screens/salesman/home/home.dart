import 'package:drug_stores/common/enums.dart';
import 'package:drug_stores/controllers/salesman_controller.dart';
import 'package:drug_stores/dialogues/yes_no_dialogue.dart';
import 'package:drug_stores/screens/salesman/order_form/order_form.dart';
import 'package:drug_stores/screens/salesman/order_list/order_list.dart';
import 'package:drug_stores/screens/welcome/welcome.dart';

// ignore: implementation_imports
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:get/route_manager.dart';

class SalesmanHomeScreen extends GetView {
  static String routeName = '/salesman/home';

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
                    Get.find<SalesmanController>().logout();
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
                child: Text('order.add'.tr()),
                onPressed: () => Get.toNamed(SalesmanOrderForm.rootName),
              ),
            ),
          ),
          Divider(),
          Expanded(
            child: Center(
              child: ElevatedButton(
                child: Text('showOrders'.tr()),
                onPressed: () => Get.toNamed(SalesmanOrderList.rootName),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
