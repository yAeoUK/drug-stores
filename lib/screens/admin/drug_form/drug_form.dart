import 'package:drug_stores/components/form_header.dart';
import 'package:drug_stores/components/form_message.dart';
import 'package:drug_stores/components/submit_button.dart';
import 'package:drug_stores/components/submit_form.dart';
import 'package:drug_stores/configs/language_config.dart';
import 'package:drug_stores/controllers/admin_drug_form_controller.dart';

// ignore: implementation_imports
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

class DrugForm extends GetView {
  static String addRouteName = 'admin/drugs/add';
  static String editRouteName = 'admin/drugs/edit';

  @override
  Widget build(BuildContext context) {
    final AdminDrugFormController adminDrugFormController =
        AdminDrugFormController();
    return Obx(
      () => SubmitForm([
        if (adminDrugFormController.message() != '')
          FormMessage(
              message: adminDrugFormController.message(),
              onDismiss: () => adminDrugFormController.message('')),
        FormHeader(adminDrugFormController.create
            ? 'drug.add'.tr()
            : 'drug.edit'.tr()),
        TextFieldBlocBuilder(
          textFieldBloc: adminDrugFormController.drugName!,
          decoration: InputDecoration(
            labelText: LanguageConfig.drugName.tr(),
          ),
        ),
        TextFieldBlocBuilder(
          textFieldBloc: adminDrugFormController.drugQuantity!,
          keyboardType:
              TextInputType.numberWithOptions(signed: true, decimal: false),
          decoration: InputDecoration(
            labelText: LanguageConfig.drugQuantity.tr(),
          ),
        ),
        SubmitButton(
          loading: adminDrugFormController.loading(),
          text: LanguageConfig.formOk.tr(),
          onSubmit: () => adminDrugFormController.send(),
        ),
      ]),
    );
  }
}
