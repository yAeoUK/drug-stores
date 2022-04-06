// ignore: implementation_imports
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

class FormMessage extends GetView {
  final Function onDismiss;
  final String message;

  FormMessage({required this.message, required this.onDismiss});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: MaterialBanner(
        actions: [
          OutlinedButton(
            onPressed: () => onDismiss.call(),
            child: Text('form.ok').tr(),
          )
        ],
        content: Text(
          message,
        ),
      ),
    );
  }
}
