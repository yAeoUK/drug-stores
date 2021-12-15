import 'package:drug_stores/components/form_header.dart';
import 'package:drug_stores/components/submit_form.dart';

// ignore: implementation_imports
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

class DrugForm extends GetView {
  static String addRouteName = 'admin/drugs/add';
  static String editRouteName = 'admin/drugs/edit';

  @override
  Widget build(BuildContext context) {
    //TODO implement submit form
    return SubmitForm([FormHeader('addDrug'.tr())]);
  }
}
