import 'package:drug_stores/models/drug.dart';
import 'package:drug_stores/screens/admin/drug_form/drug_form.dart';

// ignore: implementation_imports
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:get/route_manager.dart';

class DrugItem extends GetView {
  final Drug drug;

  DrugItem({required this.drug});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: ImageIcon(AssetImage("assets/icons/pill.png")),
      // title: FittedBox(
      title: Text(
        drug.name!,
        overflow: TextOverflow.ellipsis,
      ),
      // ),
      subtitle: Text(
          'drugQuantity'.tr(namedArgs: {'quantity': drug.quantity.toString()})),
      trailing: GestureDetector(
        child: Icon(Icons.edit),
        onTap: () => Get.toNamed(DrugForm.editRouteName, arguments: drug.id),
      ),
    );
  }
}
