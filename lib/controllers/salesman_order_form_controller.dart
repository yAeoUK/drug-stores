import 'dart:convert';
import 'dart:developer';

import 'package:drug_stores/common/validators.dart';
import 'package:drug_stores/configs/api_config.dart';
import 'package:drug_stores/controllers/form_controller.dart';
import 'package:drug_stores/helper/network.dart';
import 'package:drug_stores/models/drug.dart';
import 'package:drug_stores/models/drug_store.dart';
import 'package:drug_stores/models/failure_response.dart';
import 'package:drug_stores/models/order.dart';
import 'package:drug_stores/models/order_drug.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/route_manager.dart';
import 'package:get/get_instance/src/extension_instance.dart';

class SalesmanOrderFormController extends FormController {
  final RxList<DrugStore> drugStores = RxList.empty();
  final RxList<Drug> drugs = RxList.empty();
  final RxList<Drug> selectedDrugs = RxList.empty();
  final RxString message = ''.obs;
  final RxBool loading = false.obs;

  late SelectFieldBloc<DrugStore, dynamic> drugStoresSelect;
  late RxList<SelectFieldBloc<Drug, dynamic>> drugsSelectFields =
      RxList.empty();
  late RxList<TextFieldBloc> drugsQuantityFields = RxList.empty();
  late Order order;
  late RxList<OrderDrug> orderDrugs = RxList.empty();

  SalesmanOrderFormController() {
    create = !Get.isRegistered<Order>();
    if (!create) order = Get.find();
  }

  void initFields() {
    drugStoresSelect = SelectFieldBloc(
        items: drugStores,
        initialValue: (!create
            ? drugStores
                .firstWhere((element) => element.id == order.drugStoreId)
            : null),
        validators: [
          Validators(field: 'order.addForm.drugStore'.tr()).required
        ]);
    addFieldBlocs(fieldBlocs: [drugStoresSelect]);
    if (create) addDrugField();
  }

  void addDrugField() {
    List<Drug> allowdDrugs = List<Drug>.from(drugs);
    for (Drug drug in selectedDrugs) {
      allowdDrugs.remove(drug);
    }
    SelectFieldBloc<Drug, dynamic> newField = SelectFieldBloc(
        items: allowdDrugs,
        validators: [
          Validators(field: 'order.addForm.drugName'.tr()).required
        ]);
    TextFieldBloc quantity = TextFieldBloc(validators: [
      Validators(field: 'order.addForm.drugQuantity'.tr()).required,
      Validators(field: 'order.addForm.drugQuantity'.tr()).positiveNumber
    ]);
    drugsSelectFields.add(newField);
    drugsQuantityFields.add(quantity);
    addFieldBlocs(fieldBlocs: [newField, quantity]);
  }

  void removeDrugField(SelectFieldBloc field) {
    int index = drugsSelectFields.indexOf(field);
    drugsSelectFields.removeAt(index);
    drugsQuantityFields.removeAt(index);
    refreshDrugsFields();
  }

  void refreshDrugsFields() {
    selectedDrugs.clear();
    for (int c = 0; c < drugsSelectFields.length; c++) {
      SelectFieldBloc drugsSelectField = drugsSelectFields[c];
      if (drugsSelectField.value != null) {
        Drug drug = drugsSelectField.value as Drug;
        selectedDrugs.add(drug);
        drugsQuantityFields[c].updateValidators([
          Validators(field: 'order.addForm.drugQuantity'.tr()).required,
          Validators(field: 'order.addForm.drugQuantity'.tr()).positiveNumber,
          Validators(
                  field: 'order.addForm.drugQuantity'.tr(),
                  maximumValue: drug.quantity! +
                      (!create
                          ? orderDrugs
                              .firstWhere(
                                (element) => element.drug.id == drug.id,
                                orElse: () =>
                                    OrderDrug(drug: drug, drugsCount: 0),
                              )
                              .drugsCount
                          : 0))
              .maxValue
        ]);
      }
    }
    for (SelectFieldBloc drugsSelectField in drugsSelectFields) {
      List<Drug> fieldAllowedDrugs = List<Drug>.from(drugs);
      for (Drug drug in selectedDrugs) {
        if (drug != drugsSelectField.value) fieldAllowedDrugs.remove(drug);
      }
      drugsSelectField.updateItems(fieldAllowedDrugs);
    }
  }

  void send() {
    log('salesman order form controller submit');
    List<FieldBloc> fields = [];
    fields.add(drugStoresSelect);
    fields.addAll(drugsSelectFields);
    fields.addAll(drugsQuantityFields);
    for (FieldBloc field in fields) {
      field.validate();
      if (!field.state.isValid) return;
    }
    submitData();
  }

  Future submitData() {
    var requestBody = {
      'drug_store_id': (drugStoresSelect.value as DrugStore).id,
      'drugs': getDrugsArray()
    };
    if (!create) requestBody['order_id'] = order.id;
    return Network(onConnectionSucceed: (body) {
      print('salesman order form connection succeed');
      super.onConnectionSucceed();
      Fluttertoast.showToast(
        msg: (create
                ? 'order.addForm.createSuccess'
                : 'order.addForm.editSuccess')
            .tr(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
      );
      Get.back();
    }, onMessageReceived: (FailureResponse response) {
      super.onMessageReceived(response.content);
      log('salesaman order form message received: ' +
          jsonEncode(response.content));
    }, onPreConnect: () {
      log('salesman order form pre connect');
      super.onPreConnect();
    }, onPostConnect: () {
      log('salesman order form post connect');
      super.onPostConnect();
    }, onConnectionFailed: () {
      super.onConnectionFailed();
      log('salesman order form connection failed');
    }).post(
        url: ApiConfig.salesmanUpsertOrder,
        body: jsonEncode(requestBody),
        json: true);
  }

  List<Map> getDrugsArray() {
    List<Map> array = [];
    for (int c = 0; c < drugsSelectFields.length; c++) {
      array.add({
        'id': (drugsSelectFields[c].value as Drug).id,
        'quantity': (drugsQuantityFields[c].value)
      });
    }
    return array;
  }
}
