import 'package:drug_stores/components/loading.dart';
import 'package:drug_stores/controllers/salesman_drug_list_controller.dart';
import 'package:drug_stores/models/order_drug.dart';

// ignore: implementation_imports
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

class SalesmanDrugItem extends GetView {
  final int index;

  SalesmanDrugItem({required this.index});

  final SalesmanDrugListController salesmanDrugsListController = Get.find();

  @override
  Widget build(BuildContext context) {
    String message = salesmanDrugsListController.itemsMessage[index];
    OrderDrug orderDrug =
        OrderDrug.fromMap(salesmanDrugsListController.items[index]);
    return Obx(() {
      return ListTile(
          leading: ImageIcon(AssetImage("assets/icons/pill.png")),
          title: Text(
            orderDrug.drug.name!,
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: message == ''
              ? Text('drugQuantity'
                  .tr(namedArgs: {'quantity': orderDrug.quantity.toString()}))
              : Text(message),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                  child: Icon(Icons.edit),
                  onTap: () => salesmanDrugsListController.editItem(orderDrug)),
              if (salesmanDrugsListController.itemsLoading[index])
                Loading()
              else
                GestureDetector(
                  child: Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                  onTap: () => salesmanDrugsListController
                      .deleteItem(orderDrug.drug.id!),
                ),
            ],
          ));
    });
  }
}
