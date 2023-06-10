import 'package:drug_stores/components/form_header.dart';
import 'package:drug_stores/components/form_message.dart';
import 'package:drug_stores/components/submit_button.dart';
import 'package:drug_stores/components/submit_form.dart';
import 'package:drug_stores/configs/language_config.dart';

// ignore: implementation_imports
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

import '../../../controllers/admin_pharmacy_form_controller.dart';

class AdminPharmacyForm extends GetView {
  static String addRouteName = '/admin/pharmacies/add';
  static String editRouteName = '/admin/pharmacies/edit';

  @override
  Widget build(BuildContext context) {
    final AdminPharmacyFormController adminPharmacyFormController =
        AdminPharmacyFormController();
    return Obx(
      () => SubmitForm([
        if (adminPharmacyFormController.message() != '')
          FormMessage(
              message: adminPharmacyFormController.message(),
              onDismiss: () => adminPharmacyFormController.message('')),
        FormHeader(adminPharmacyFormController.create
            ? 'pharmacy.add'.tr()
            : 'pharmacy.edit'.tr()),
        TextFieldBlocBuilder(
          textFieldBloc: adminPharmacyFormController.pharmacyName!,
          decoration: InputDecoration(
            labelText: LanguageConfig.pharmacyName.tr(),
          ),
        ),
        SubmitButton(
          loading: adminPharmacyFormController.loading(),
          text: LanguageConfig.formOk.tr(),
          onSubmit: () => adminPharmacyFormController.send(),
        ),
      ]),
    );
  }
}
