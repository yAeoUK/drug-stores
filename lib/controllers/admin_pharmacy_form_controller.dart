import 'dart:convert';

import 'package:drug_stores/common/validators.dart';
import 'package:drug_stores/configs/api_config.dart';
import 'package:drug_stores/configs/language_config.dart';
import 'package:drug_stores/controllers/form_controller.dart';
import 'package:drug_stores/helper/network.dart';
import 'package:drug_stores/models/failure_response.dart';
import 'package:drug_stores/models/pharmacy.dart';

// ignore: implementation_imports
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/route_manager.dart';

class AdminPharmacyFormController extends FormController {
  TextFieldBloc? pharmacyName;

  late List<FieldBloc> fields;
  late Pharmacy pharmacy;

  AdminPharmacyFormController() {
    create = !Get.isRegistered<Pharmacy>();
    if (!create) pharmacy = Get.find();
    pharmacyName = TextFieldBloc(
        initialValue: !create ? pharmacy.name! : '',
        validators: [
          Validators(field: LanguageConfig.pharmacyName.tr()).required
        ]);
    fields = [pharmacyName!];
    addFieldBlocs(fieldBlocs: fields);
  }

  Future submitData() {
    print('pharmacy: ' + pharmacy.toString());
    return Network(onConnectionSucceed: (body) {
      print('admin pharmacy form connection succeed');
      super.onConnectionSucceed();
      Fluttertoast.showToast(
        msg: create
            ? 'pharmacy.createSuccess'.tr()
            : 'pharmacy.editSuccess'.tr(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
      );
      Get.back(result: body["pharmacy"]);
    }, onMessageReceived: (FailureResponse response) {
      super.onMessageReceived(response.content);
      print('admin pharmacy form message received: ' +
          jsonEncode(response.content));
    }, onPreConnect: () {
      print('admin pharmacy form pre connect');
      super.onPreConnect();
    }, onPostConnect: () {
      print('admin pharmacy form post connect');
      super.onPostConnect();
    }, onConnectionFailed: () {
      super.onConnectionFailed();
      print('admin pharmacy form connection failed');
    }).post(
        url: ApiConfig.adminUpsertPharmacy,
        body: jsonEncode({'pharmacy': pharmacy.toMap()}),
        json: true);
  }

  void send() {
    print('admin pharmacy form controller submit');
    for (FieldBloc field in fields) {
      if (!field.state.isValid) return;
    }
    if (create)
      pharmacy = Pharmacy(name: pharmacyName!.value);
    else
      pharmacy = Get.find();
    pharmacy.name = pharmacyName!.value;
    submitData();
  }
}
