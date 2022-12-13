import 'package:drug_stores/components/items_list.dart';
import 'package:drug_stores/controllers/salesman_order_list_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:get/instance_manager.dart';

class SalesmanOrderList extends GetView {
  static String rootName = "/salesman/drugs";

  @override
  Widget build(BuildContext context) {
    Get.delete<SalesmanOrderListController>();
    final SalesmanOrderListController salesmanDrugListController =
        Get.put(SalesmanOrderListController());
    return Scaffold(body: ItemsList(controller: salesmanDrugListController));
  }
}
