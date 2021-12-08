import 'package:drug_stores/configs/language_config.dart';

// ignore: implementation_imports
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

class PasswordField extends GetView {
  final TextFieldBloc controller;
  final String label;

  PasswordField(
      {required this.controller, this.label = LanguageConfig.password});

  @override
  Widget build(BuildContext context) {
    return TextFieldBlocBuilder(
      textFieldBloc: controller,
      autofillHints: [AutofillHints.password],
      suffixButton: SuffixButton.obscureText,
      decoration: InputDecoration(
        labelText: label.tr(),
        prefixIcon: Icon(Icons.lock),
      ),
    );
  }
}
