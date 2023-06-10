import 'package:drug_stores/common/enums.dart';
import 'package:drug_stores/configs/api_config.dart';
import 'package:drug_stores/configs/language_config.dart';
import 'package:drug_stores/controllers/items_list_controller.dart';
import 'package:drug_stores/dialogues/yes_no_dialogue.dart';
import 'package:drug_stores/helper/network.dart';
import 'package:drug_stores/models/drug.dart';
import 'package:drug_stores/models/failure_response.dart';
import 'package:drug_stores/models/pharmacy.dart';
import 'package:drug_stores/screens/admin/pharmacy_form/pharmacy_form.dart';
import 'package:drug_stores/screens/admin/pharmacy_list/components/pharmacy_item.dart';

// ignore: implementation_imports
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/route_manager.dart';

class AdminPharmacyListController extends ItemsListController<Drug> {
  AdminPharmacyListController()
      : super(
            itemBuilder: (context, index) => AdminPharmacyItem(index: index),
            plural: 'pharmacies',
            indexUrl: ApiConfig.adminGetPharmacies);

  @override
  Future deleteItem(int id) {
    int? index = getItemIndex(id);
    return showDialog<DialogueResponse>(
        context: Get.context!,
        builder: (BuildContext context) {
          return YesNoDialogue(
              title: 'pharmacy.dialogue.delete.title'.tr(),
              content: 'pharmacy.dialogue.delete.content'.tr());
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
                    msg: 'pharmacy.deleteSuccess'.tr(),
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1,
                  );
                  super.deleteItem(id);
                })
            .post(url: ApiConfig.adminDeletePharmacy, body: {'pharmacyId': id});
      }
    });
  }

  Future addPharmacy() async {
    var result = await Get.toNamed(AdminPharmacyForm.addRouteName);
    super.addItem(result);
  }

  Future editPharmacy(Pharmacy pharmacy) async {
    Get.put<Pharmacy>(pharmacy);
    var result = await Get.toNamed(AdminPharmacyForm.editRouteName);
    await Get.delete<Pharmacy>(force: true);
    super.editItem(result);
  }
}
