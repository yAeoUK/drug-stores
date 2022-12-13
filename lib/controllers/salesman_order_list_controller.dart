import 'package:drug_stores/configs/api_config.dart';
import 'package:drug_stores/controllers/items_list_controller.dart';
import 'package:drug_stores/models/drug.dart';
import 'package:drug_stores/models/order.dart';
import 'package:drug_stores/screens/salesman/order_form/order_form.dart';
import 'package:drug_stores/screens/salesman/order_list/components/order_item.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/instance_manager.dart';

import '../common/enums.dart';
import '../configs/language_config.dart';
import '../dialogues/yes_no_dialogue.dart';
import '../helper/network.dart';
import '../models/failure_response.dart';

class SalesmanOrderListController extends ItemsListController<Drug> {
  SalesmanOrderListController()
      : super(
            indexUrl: ApiConfig.salesmanGetOrders,
            itemBuilder: (context, index) => SalesmanOrderItem(index: index),
            plural: 'orders');

  Future editOrder(Order order) async {
    Get.put<Order>(order);
    await Get.toNamed(SalesmanOrderForm.editRouteName);
    await Get.delete<Order>(force: true);
    loadData(refresh: true);
    // super.editItem(result);
  }

  @override
  Future deleteItem(int id) {
    int? index = getItemIndex(id);
    return showDialog<DialogueResponse>(
        context: Get.context!,
        builder: (BuildContext context) {
          return YesNoDialogue(
              title: 'order.dialogue.delete.title'.tr(),
              content: 'order.dialogue.delete.content'.tr());
        }).then((value) {
      if (value == DialogueResponse.yes) {
        Network(
            onPreConnect: () => super.preItemLoading(index!),
            onPostConnect: () => super.postItemLoading(index!),
            onMessageReceived: (FailureResponse response) =>
                itemsMessage[index!] = response.content,
            onConnectionFailed: () =>
                itemsMessage[index!] = LanguageConfig.formNoConnection.tr(),
            onConnectionSucceed: (body) {
              Fluttertoast.showToast(
                msg: 'order.deleteSuccess'.tr(),
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
              );
              super.deleteItem(id);
            }).post(url: ApiConfig.salesmanDeleteOrder, body: {'orderId': id});
      }
    });
  }
}
