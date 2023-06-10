import 'package:drug_stores/components/loading.dart';
import 'package:drug_stores/controllers/admin_pharmacy_list_controller.dart';
import 'package:drug_stores/models/pharmacy.dart';

import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

class AdminPharmacyItem extends GetView {
  final int index;

  AdminPharmacyItem({required this.index});

  final AdminPharmacyListController adminPharmacyListController = Get.find();

  @override
  Widget build(BuildContext context) {
    String message = adminPharmacyListController.itemsMessage[index];
    Pharmacy pharmacy =
        Pharmacy.fromMap(adminPharmacyListController.items[index]);
    return Obx(() {
      return ListTile(
          leading: Icon(Icons.store),
          title: Text(
            pharmacy.name!,
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: message == '' ? Text('') : Text(message),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                  child: Icon(Icons.edit),
                  onTap: () =>
                      adminPharmacyListController.editPharmacy(pharmacy)),
              if (adminPharmacyListController.itemsLoading[index])
                Loading()
              else
                GestureDetector(
                  child: Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                  onTap: () =>
                      adminPharmacyListController.deleteItem(pharmacy.id!),
                ),
            ],
          ));
    });
  }
}
