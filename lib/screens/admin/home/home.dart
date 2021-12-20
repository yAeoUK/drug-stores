import 'package:drug_stores/components/items_list.dart';
import 'package:drug_stores/controllers/admin_drugs_list_controller.dart';
import 'package:drug_stores/models/drug.dart';
import 'package:drug_stores/screens/admin/drug_form/drug_form.dart';
import 'package:drug_stores/screens/admin/home/components/drug_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:get/route_manager.dart';

class AdminHomeScreen extends GetView {
  static String routeName = 'admin/home';

  @override
  Widget build(BuildContext context) {
    AdminDrugsListController adminDrugsListController =
        Get.put(AdminDrugsListController());
    return Scaffold(
      body: ItemsList(
        controller: adminDrugsListController,
        itemBuilder: (context, index) => DrugItem(
          drug: adminDrugsListController.items[index] as Drug,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed(DrugForm.addRouteName),
        child: Icon(Icons.add),
      ),
    );
  }
}