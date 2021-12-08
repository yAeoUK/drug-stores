import 'package:drug_stores/components/form_header.dart';
import 'package:drug_stores/components/message.dart';
import 'package:drug_stores/components/password_field.dart';
import 'package:drug_stores/components/submit_button.dart';
import 'package:drug_stores/components/submit_form.dart';
import 'package:drug_stores/components/username_field.dart';
import 'package:drug_stores/configs/language_config.dart';
import 'package:drug_stores/controllers/admin_login_controller.dart';

// ignore: implementation_imports
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

class AdminLoginTab extends GetView {
  final AdminLoginController adminLoginController = AdminLoginController();

  @override
  Widget build(BuildContext context) {
    return Obx(() => SubmitForm([
          if (adminLoginController.message() != '')
            Message(
                message: adminLoginController.message(),
                onDismiss: () => adminLoginController.message('')),
          FormHeader(LanguageConfig.adminLogin.tr()),
          UsernameField(controller: adminLoginController.username),
          PasswordField(controller: adminLoginController.password),
          SubmitButton(
            loading: adminLoginController.loading(),
            text: LanguageConfig.formOk.tr(),
            onSubmit: () => adminLoginController.submit(),
          ),
        ]));
  }
}
