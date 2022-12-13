import 'package:drug_stores/components/loading.dart';
import 'package:drug_stores/controllers/salesman_order_list_controller.dart';
import 'package:drug_stores/models/order.dart';

// ignore: implementation_imports
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

class SalesmanOrderItem extends GetView {
  final int index;

  SalesmanOrderItem({required this.index});

  final SalesmanOrderListController salesmanOrderListController = Get.find();

  @override
  Widget build(BuildContext context) {
    String message = salesmanOrderListController.itemsMessage[index];
    Order order = Order.fromMap(salesmanOrderListController.items[index]);
    return Obx(() {
      return ListTile(
          leading: ImageIcon(AssetImage("assets/icons/pill.png")),
          title: Text(
            order.drugStoreName!,
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: message == ''
              ? Text('drugQuantity'
                  .tr(namedArgs: {'quantity': order.drugsCount.toString()}))
              : Text(message),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                  child: Icon(Icons.edit),
                  onTap: () => salesmanOrderListController.editOrder(order)),
              if (salesmanOrderListController.itemsLoading[index])
                Loading()
              else
                GestureDetector(
                  child: Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                  onTap: () => salesmanOrderListController.deleteItem(order.id),
                ),
            ],
          ));
    });
  }
}
