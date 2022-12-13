import 'package:drug_stores/controllers/admin_order_list_controller.dart';
import 'package:drug_stores/models/order.dart';
import 'package:drug_stores/screens/admin/order_list/order_list.dart';

// ignore: implementation_imports
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:get/instance_manager.dart';

class OrderItem extends GetView {
  final int index;

  OrderItem({required this.index});

  final AdminOrdersListController adminOrdersListController = Get.find();

  @override
  Widget build(BuildContext context) {
    Order order = Order.fromMap(adminOrdersListController.items[index]);
    return ListTile(
      leading: Icon(Icons.person),
      title: Text(order.salesmanName!),
      subtitle: Text(
          'drugsCount'.tr(namedArgs: {'number': order.drugsCount.toString()})),
      trailing: Icon(Icons.arrow_back_ios),
      onTap: () =>
          Get.toNamed(AdminOrderList.routeName, arguments: {'id': order.id}),
    );
  }
}
