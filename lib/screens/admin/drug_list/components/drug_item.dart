import 'package:drug_stores/components/loading.dart';
import 'package:drug_stores/controllers/admin_drugs_list_controller.dart';
import 'package:drug_stores/models/drug.dart';
// ignore: implementation_imports
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

class DrugItem extends GetView {
  final int index;

  DrugItem({required this.index});

  final AdminDrugsListController adminDrugsListController = Get.find();

  @override
  Widget build(BuildContext context) {
    String message = adminDrugsListController.itemsMessage[index];
    Drug drug = Drug.fromMap(adminDrugsListController.items[index]);
    return Obx(() {
      return ListTile(
          leading: ImageIcon(AssetImage("assets/icons/pill.png")),
          title: Text(
            drug.name!,
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: message == ''
              ? Text('drugQuantity'
                  .tr(namedArgs: {'quantity': drug.quantity.toString()}))
              : Text(message),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                  child: Icon(Icons.edit),
                  onTap: () => adminDrugsListController.editDrug(drug)),
              if (adminDrugsListController.itemsLoading[index])
                Loading()
              else
                GestureDetector(
                  child: Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                  onTap: () => adminDrugsListController.deleteItem(drug.id!),
                ),
            ],
          ));
    });
  }
}
