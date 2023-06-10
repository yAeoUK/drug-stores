import 'package:drug_stores/components/items_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/admin_pharmacy_list_controller.dart';

class AdminPharmacyList extends GetView {
  static String routeName = '/admin/pharmacies';

  @override
  Widget build(BuildContext context) {
    Get.delete<AdminPharmacyListController>();
    final AdminPharmacyListController adminPharmacyListController =
        Get.put(AdminPharmacyListController());
    return Scaffold(
      body: ItemsList(
        controller: adminPharmacyListController,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => adminPharmacyListController.addPharmacy(),
        child: Icon(Icons.add),
      ),
    );
  }
}
