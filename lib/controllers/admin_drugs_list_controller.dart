import 'package:drug_stores/common/enums.dart';
import 'package:drug_stores/configs/api_config.dart';
import 'package:drug_stores/configs/app_config.dart';
import 'package:drug_stores/configs/language_config.dart';
import 'package:drug_stores/controllers/items_list_controller.dart';
import 'package:drug_stores/dialogues/yes_no_dialogue.dart';
import 'package:drug_stores/helper/network.dart';
import 'package:drug_stores/models/drug.dart';
import 'package:drug_stores/models/failure_response.dart';

// ignore: implementation_imports
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class AdminDrugsListController extends ItemsListController {
  @override
  Future loadData(int offset) {
    return Network(
        onConnectionSucceed: (body) =>
            items.addAll(Drug.fromList(body['drugs'])),
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
              items.removeAt(index!);
            }).post(url: ApiConfig.adminDeleteDrug, body: {'drugId': id});
      }
    });
  }
}
