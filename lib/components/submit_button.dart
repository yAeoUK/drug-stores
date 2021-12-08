// ignore: implementation_imports
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

// ignore: must_be_immutable
class SubmitButton extends GetView {
  String text;
  Function onSubmit;
  final bool loading;
  static ValueKey loadingKey = ValueKey('loading');

  static Type buttonType = ElevatedButton;
  static Type loadingType = CircularProgressIndicator;

  SubmitButton(
      {this.loading = false, required this.text, required this.onSubmit});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          print('submitting button clicked');
          if (!loading) onSubmit.call();
        },
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Get.theme.primaryColor)),
        child: Padding(
          padding: EdgeInsets.all(4),
          child: Row(children: [
            Visibility(
              child: CircularProgressIndicator(
                key: loadingKey,
                color: Get.theme.primaryColorLight,
              ),
              visible: loading,
            ),
            Expanded(
                child: Text(
              text,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: Get.theme.backgroundColor),
            )),
          ]),
        ));
  }
}
