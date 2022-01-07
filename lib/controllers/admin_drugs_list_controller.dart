import 'package:drug_stores/common/enums.dart';
import 'package:drug_stores/configs/api_config.dart';
import 'package:drug_stores/configs/app_config.dart';
import 'package:drug_stores/configs/language_config.dart';
import 'package:drug_stores/controllers/items_list_controller.dart';
import 'package:drug_stores/dialogues/yes_no_dialogue.dart';
import 'package:drug_stores/helper/network.dart';
import 'package:drug_stores/models/drug.dart';
import 'package:drug_stores/models/failure_response.dart';
import 'package:drug_stores/screens/admin/drug_form/drug_form.dart';
import 'package:drug_stores/screens/admin/home/components/drug_item.dart';

// ignore: implementation_imports
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/route_manager.dart';

class AdminDrugsListController extends ItemsListController<Drug> {
  AdminDrugsListController()
      : super((context, index) => DrugItem(index: index));

  @override
  Future loadData({int offset = 0, bool refresh = false}) {
    return Network(
        onConnectionSucceed: (body) {
          if (refresh) {
            items.clear();
            itemsLoading.clear();
            itemsMessage.clear();
          }
          var newDrugs = Drug.fromList(body['drugs']);
          int oldCount = itemsLoading.length;
          for (int c = 0; c < newDrugs.length; c++) {
            itemsLoading.add(false);
            itemsMessage.add('');
          }
          items.addAll(newDrugs);
          if (items.length - oldCount < AppConfig.listItemsInitialCount)
            loadMoreVisibility(false);
        },
        onMessageReceived: (failureResponse) =>
            message(failureResponse.content),
        onConnectionFailed: () =>
            message(LanguageConfig.formNoConnection.tr())).post(
        url: ApiConfig.adminGetDrugs,
        body: {'limit': AppConfig.listItemsInitialCount, 'offset': offset});
  }

  @override
  Future deleteItem(int id) {
    int? index = getItemIndex(id);
    return showDialog<DialogueResponse>(
        context: Get.context!,
        builder: (BuildContext context) {
          return YesNoDialogue(
              title: 'drug.dialogue.delete.title'.tr(),
              content: 'drug.dialogue.delete.content'.tr());
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
                msg: 'drug.deleteSuccess'.tr(),
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
              );
              super.deleteItem(id);
            }).post(url: ApiConfig.adminDeleteDrug, body: {'drugId': id});
      }
    });
  }

  Future addDrug() async {
    var result = await Get.toNamed(DrugForm.addRouteName);
    super.addItem(result);
  }

  Future editDrug(Drug drug) async {
    Get.put<Drug>(drug);
    var result = await Get.toNamed(DrugForm.editRouteName);
    await Get.delete<Drug>(force: true);
    super.editItem(result);
  }
}