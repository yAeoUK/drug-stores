import 'package:drug_stores/components/items_list.dart';
import 'package:drug_stores/controllers/admin_order_list_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class AdminOrderList extends GetView {
  static String routeName = '/admin/orders';

  final AdminOrdersListController adminOrdersListController =
      Get.put(AdminOrdersListController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ItemsList(
        controller: adminOrdersListController,
      ),
    );
  }
}
