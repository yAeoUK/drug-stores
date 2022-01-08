import 'package:drug_stores/components/items_list.dart';
import 'package:drug_stores/controllers/admin_drugs_list_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class AdminDrugList extends GetView {
  static String routeName = '/admin/drugs';
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
