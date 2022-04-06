import 'package:drug_stores/components/items_list.dart';
import 'package:drug_stores/controllers/salesman_drug_list_controller.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:get/instance_manager.dart';

class SalesmanDrugList extends GetView {
  static String rootName = "/salesman/drugs";
  final SalesmanDrugListController salesmanDrugListController =
  Get.put(SalesmanDrugListController());

  @override
  Widget build(BuildContext context) {
    return ItemsList(controller: salesmanDrugListController);
  }
}
