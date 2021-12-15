import 'package:drug_stores/components/form_header.dart';
import 'package:drug_stores/components/form_message.dart';
import 'package:drug_stores/components/password_field.dart';
import 'package:drug_stores/components/submit_button.dart';
import 'package:drug_stores/components/submit_form.dart';
import 'package:drug_stores/components/username_field.dart';
import 'package:drug_stores/configs/language_config.dart';
import 'package:drug_stores/controllers/salesman_login_controller.dart';

// ignore: implementation_imports
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

class SalesmanLoginTab extends GetView {
  final SalesmanLoginController salesmanLoginController =
      SalesmanLoginController();

  @override
  Widget build(BuildContext context) {
    return Obx(() => SubmitForm([
          if (salesmanLoginController.message() != '')
            FormMessage(
                message: salesmanLoginController.message(),
                onDismiss: () => salesmanLoginController.message('')),
          FormHeader(LanguageConfig.salesmanLogin.tr()),
          UsernameField(controller: salesmanLoginController.username),
          PasswordField(controller: salesmanLoginController.password),
          SubmitButton(
            loading: salesmanLoginController.loading(),
            text: LanguageConfig.formOk.tr(),
            onSubmit: () => salesmanLoginController.submit(),
          ),
        ]));
  }
}
