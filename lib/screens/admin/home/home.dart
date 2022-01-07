import 'package:drug_stores/components/items_list.dart';
import 'package:drug_stores/controllers/admin_drugs_list_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:get/route_manager.dart';

class AdminHomeScreen extends GetView {
  static String routeName = 'admin/home';
  final AdminDrugsListController adminDrugsListController =
      Get.put(AdminDrugsListController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ItemsList(
        controller: adminDrugsListController,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => adminDrugsListController.addDrug(),
        child: Icon(Icons.add),
      ),
    );
  }
}