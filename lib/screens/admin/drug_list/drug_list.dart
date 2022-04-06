import 'package:drug_stores/components/items_list.dart';
import 'package:drug_stores/controllers/admin_drug_list_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminDrugList extends GetView {
  static String routeName = '/admin/drugs';

  @override
  Widget build(BuildContext context) {
    Get.delete<AdminDrugListController>();
    final AdminDrugListController adminDrugsListController =
        Get.put(AdminDrugListController());
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
