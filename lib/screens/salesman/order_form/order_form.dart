import 'package:drug_stores/components/form_header.dart';
import 'package:drug_stores/components/form_message.dart';
import 'package:drug_stores/components/submit_button.dart';
import 'package:drug_stores/components/submit_form.dart';
import 'package:drug_stores/configs/api_config.dart';
import 'package:drug_stores/configs/language_config.dart';
import 'package:drug_stores/controllers/salesman_order_form_controller.dart';
import 'package:drug_stores/helper/network.dart';
import 'package:drug_stores/models/drug.dart';
import 'package:drug_stores/models/drug_store.dart';
import 'package:drug_stores/models/failure_response.dart';
import 'package:drug_stores/models/order_drug.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

class SalesmanOrderForm extends GetView {
  static String rootName = "/salesman/orders/add";
  static String editRouteName = "/salesman/orders/edit";
  @override
  Widget build(BuildContext context) {
    SalesmanOrderFormController controller = SalesmanOrderFormController();
    Map<String, dynamic> requestBody = {};
    if (!controller.create) requestBody['order_id'] = controller.order.id;
    return Scaffold(
      body: FutureBuilder(
          future: Network(onConnectionSucceed: ((body) {
            controller.drugStores.value =
                DrugStore.fromList(body['drug_stores']);
            controller.drugs.value = Drug.fromList(body['drugs']);
            if (!controller.create)
              controller.orderDrugs.value =
                  OrderDrug.fromList(body['order_drugs']);
            for (OrderDrug orderDrug in controller.orderDrugs) {
              controller.selectedDrugs.add(orderDrug.drug);
            }
            for (OrderDrug orderDrug in controller.orderDrugs) {
              controller.addDrugField();
              controller.drugsSelectFields.last.updateInitialValue(controller
                  .drugs
                  .firstWhere((element) => element.id == orderDrug.drug.id));
              controller.drugsQuantityFields.last
                  .updateInitialValue(orderDrug.drugsCount.toString());
            }
            controller.refreshDrugsFields();
            controller.initFields();
          }), onMessageReceived: (FailureResponse failureResponse) {
            controller.message(failureResponse.content);
          }, onPostConnect: () {
            controller.loading(false);
          }, onPreConnect: () {
            controller.loading(true);
            controller.message('');
          }, onConnectionFailed: () {
            controller.message('form.noConnection'.tr());
          }).post(url: ApiConfig.salesmanAddOrderHelper, body: requestBody),
          builder: (_, __) => Obx(
                () {
                  if (controller.drugStores.isEmpty) {
                    if (controller.loading.value == true)
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    if (controller.message.value.isNotEmpty)
                      return Center(
                        child: Text(controller.message.value),
                      );
                  }
                  return SubmitForm([
                    FormMessage(
                        message: controller.message(),
                        onDismiss: () => controller.message('')),
                    FormHeader(controller.create
                        ? 'order.add'.tr()
                        : 'order.edit'.tr()),
                    DropdownFieldBlocBuilder<DrugStore>(
                        selectFieldBloc: controller.drugStoresSelect,
                        decoration: InputDecoration(
                            hintText: 'order.addForm.chooseDrugStore'.tr()),
                        itemBuilder: (context, drugStore) => FieldItem(
                              child: Text(drugStore.name!),
                            )),
                    ...controller.drugsSelectFields.map((field) {
                      return Row(children: [
                        Expanded(
                          flex: 3,
                          child: DropdownFieldBlocBuilder<Drug>(
                              decoration: InputDecoration(
                                  label: Text('order.addForm.chooseDrug'.tr())),
                              onChanged: (Drug? drug) {
                                if (drug != null) {
                                  controller.refreshDrugsFields();
                                }
                              },
                              selectFieldBloc: field,
                              selectedItemBuilder: (context, drug) =>
                                  Text(drug.name!),
                              itemBuilder: (context, drug) => FieldItem(
                                    child: Column(children: [
                                      Expanded(
                                          child: ListTile(
                                        title: Text(drug.name!),
                                        subtitle: Text('drugQuantity'
                                            .tr(namedArgs: {
                                          'quantity': drug.quantity.toString()
                                        })),
                                      )),
                                    ]),
                                  )),
                        ),
                        Expanded(
                          flex: 2,
                          child: TextFieldBlocBuilder(
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                hintText:
                                    'order.addForm.enterDrugQuantity'.tr()),
                            textFieldBloc: controller.drugsQuantityFields[
                                controller.drugsSelectFields.indexOf(field)],
                          ),
                        ),
                        if (controller.drugsSelectFields.length > 1)
                          IconButton(
                              onPressed: () {
                                controller.removeDrugField(field);
                              },
                              icon: Icon(
                                Icons.delete,
                                color: Colors.red,
                              ))
                      ]);
                    }).toList(),
                    TextButton(
                        onPressed: () => controller.addDrugField(),
                        child: Text('order.addForm.addDrug'.tr())),
                    SubmitButton(
                      loading: controller.loading(),
                      text: LanguageConfig.formOk.tr(),
                      onSubmit: () => controller.send(),
                    ),
                  ]);
                },
              )),
    );
  }
}
