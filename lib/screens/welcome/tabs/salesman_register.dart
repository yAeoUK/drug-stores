import 'package:drug_stores/components/form_header.dart';
import 'package:drug_stores/components/form_message.dart';
import 'package:drug_stores/components/password_field.dart';
import 'package:drug_stores/components/submit_button.dart';
import 'package:drug_stores/components/submit_form.dart';
import 'package:drug_stores/components/username_field.dart';
import 'package:drug_stores/configs/language_config.dart';
import 'package:drug_stores/controllers/salesman_register_controller.dart';

// ignore: implementation_imports
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

class SalesmanRegisterTab extends GetView {
  final SalesmanRegisterController salesmanRegisterController =
      SalesmanRegisterController();

  @override
  Widget build(BuildContext context) {
    return Obx(() => SubmitForm([
          if (salesmanRegisterController.message() != '')
            FormMessage(
                message: salesmanRegisterController.message(),
                onDismiss: () => salesmanRegisterController.message('')),
          FormHeader(LanguageConfig.salesmanRegister.tr()),
          UsernameField(controller: salesmanRegisterController.username),
          PasswordField(controller: salesmanRegisterController.password),
          PasswordField(
            controller: salesmanRegisterController.confirmPassword,
            label: LanguageConfig.confirmPassword,
          ),
          SubmitButton(
            loading: salesmanRegisterController.loading(),
            text: LanguageConfig.formOk.tr(),
            onSubmit: () => salesmanRegisterController.submit(),
          ),
        ]));
  }
}
