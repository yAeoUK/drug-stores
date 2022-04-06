import 'dart:convert';

import 'package:drug_stores/common/validators.dart';
import 'package:drug_stores/configs/api_config.dart';
import 'package:drug_stores/configs/language_config.dart';
import 'package:drug_stores/controllers/form_controller.dart';
import 'package:drug_stores/helper/network.dart';
import 'package:drug_stores/models/drug.dart';
import 'package:drug_stores/models/failure_response.dart';

// ignore: implementation_imports
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/route_manager.dart';

class AdminDrugFormController extends FormController {
  TextFieldBloc? drugName, drugQuantity;

  late List<FieldBloc> fields;
  late Drug drug;

  AdminDrugFormController() {
    create = !Get.isRegistered<Drug>();
    if (!create) drug = Get.find();
    drugName = TextFieldBloc(
        initialValue: !create ? drug.name! : '',
        validators: [Validators(field: LanguageConfig.drugName.tr()).required]);
    drugQuantity = TextFieldBloc(
        initialValue: !create ? drug.quantity.toString() : '',
        validators: [
          Validators(field: LanguageConfig.drugQuantity.tr()).required,
          Validators(field: LanguageConfig.drugQuantity.tr()).positiveNumber
        ]);
    fields = [drugName!, drugQuantity!];
    addFieldBlocs(fieldBlocs: fields);
  }

  Future submitData() {
    print('drug: ' + drug.toString());
    return Network(onConnectionSucceed: (body) {
      print('admin drug form connection succeed');
      super.onConnectionSucceed();
      Fluttertoast.showToast(
        msg: create ? 'drug.createSuccess'.tr() : 'drug.editSuccess'.tr(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
      );
      Get.back(result: body["drug"]);
    }, onMessageReceived: (FailureResponse response) {
      super.onMessageReceived(response.content);
      print(
          'admin drug form message received: ' + jsonEncode(response.content));
    }, onPreConnect: () {
      print('admin drug form pre connect');
      super.onPreConnect();
    }, onPostConnect: () {
      print('admin drug form post connect');
      super.onPostConnect();
    }, onConnectionFailed: () {
      super.onConnectionFailed();
      print('admin drug form connection failed');
    }).post(
        url: ApiConfig.adminUpsertDrug,
        body: jsonEncode({'drug': drug.toMap()}),
        json: true);
  }

  void send() {
    print('admin drug form controller submit');
    for (FieldBloc field in fields) {
      if (!field.state.isValid) return;
    }
    if (create)
      drug = Drug(name: drugName!.value, quantity: drugQuantity!.valueToInt);
    else
      drug = Get.find();
    drug.name = drugName!.value;
    drug.quantity = drugQuantity!.valueToInt;
    submitData();
  }
}
