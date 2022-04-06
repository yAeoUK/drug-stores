import 'package:drug_stores/screens/salesman/drug_list/drug_list.dart';

// ignore: implementation_imports
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:get/route_manager.dart';

class SalesmanHomeScreen extends GetView {
  static String routeName = '/salesman/home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: ElevatedButton(
                child: Text('addOrder'.tr()),
                //TODO change salesman orders route name
                onPressed: () => Get.toNamed(''),
              ),
            ),
          ),
          Divider(),
          Expanded(
            child: Center(
              child: ElevatedButton(
                child: Text('showOrders'.tr()),
                onPressed: () => Get.toNamed(SalesmanDrugList.rootName),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
