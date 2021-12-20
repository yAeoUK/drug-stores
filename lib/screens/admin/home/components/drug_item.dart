import 'dart:convert';

import 'package:drug_stores/controllers/admin_drugs_list_controller.dart';
import 'package:drug_stores/models/drug.dart';
import 'package:drug_stores/screens/admin/drug_form/drug_form.dart';

// ignore: implementation_imports
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

class DrugItem extends GetView {
  final Drug drug;

  DrugItem({required this.drug});

  @override
  Widget build(BuildContext context) {
    AdminDrugsListController adminDrugsListController =
        Get.find<AdminDrugsListController>();
    int? index = adminDrugsListController.getItemIndex(drug.id);
    String message = '';
    if (index != null) message = adminDrugsListController.itemsMessage[index];
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
              onTap: () =>
                  Get.toNamed(DrugForm.editRouteName, arguments: drug.id),
            ),
            GestureDetector(
              child: Icon(
                Icons.delete,
                color: Colors.red,
              ),
              onTap: () => adminDrugsListController.deleteItem(drug.id),
            ),
          ],
        ));
  }
}
