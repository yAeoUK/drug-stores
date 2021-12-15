import 'package:drug_stores/components/items_list.dart';
import 'package:drug_stores/configs/api_config.dart';
import 'package:drug_stores/configs/app_config.dart';
import 'package:drug_stores/configs/language_config.dart';
import 'package:drug_stores/controllers/admin_drugs_list_controller.dart';
import 'package:drug_stores/helper/network.dart';
import 'package:drug_stores/models/drug.dart';
import 'package:drug_stores/screens/admin/home/components/drug_item.dart';
// ignore: implementation_imports
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

class AdminHomeScreen extends GetView {
  static String routeName = 'admin/home';

  @override
  Widget build(BuildContext context) {
    AdminDrugsListController? adminDrugsListController;
    adminDrugsListController = AdminDrugsListController(Network(
        onConnectionSucceed: (body) =>
            adminDrugsListController!.items = Drug.fromList(body['drugs']),
        onMessageReceived: (failureResponse) =>
            adminDrugsListController!.message(failureResponse.content),
        onConnectionFailed: () => adminDrugsListController!
            .message(LanguageConfig.formNoConnection.tr())).post(
        url: ApiConfig.adminGetDrugs,
        body: {'limit': AppConfig.listItemsInitialCount, 'offset': 0}));
    return Scaffold(
      body: ItemsList(
        controller: adminDrugsListController,
        itemBuilder: (context, index) => DrugItem(
          drug: adminDrugsListController!.items[index] as Drug,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
    );
  }
}