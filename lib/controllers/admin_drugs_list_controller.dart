import 'package:drug_stores/common/enums.dart';
import 'package:drug_stores/configs/api_config.dart';
import 'package:drug_stores/configs/language_config.dart';
import 'package:drug_stores/controllers/items_list_controller.dart';
import 'package:drug_stores/dialogues/yes_no_dialogue.dart';
import 'package:drug_stores/helper/network.dart';
import 'package:drug_stores/models/drug.dart';
import 'package:drug_stores/models/failure_response.dart';
import 'package:drug_stores/screens/admin/drug_form/drug_form.dart';
import 'package:drug_stores/screens/admin/drug_list/components/drug_item.dart';
// ignore: implementation_imports
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/route_manager.dart';

class AdminDrugsListController extends ItemsListController<Drug> {
  AdminDrugsListController()
      : super(
            itemBuilder: (context, index) => DrugItem(index: index),
            plural: 'drugs',
            indexUrl: ApiConfig.adminGetDrugs);

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
    var result = await Get.toNamed(AdminDrugForm.addRouteName);
    super.addItem(result);
  }

  Future editDrug(Drug drug) async {
    Get.put<Drug>(drug);
    var result = await Get.toNamed(AdminDrugForm.editRouteName);
    await Get.delete<Drug>(force: true);
    super.editItem(result);
  }
}