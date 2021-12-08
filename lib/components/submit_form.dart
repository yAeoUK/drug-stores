import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SubmitForm extends GetView {
  final List<Widget> children;

  SubmitForm(this.children);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Builder(
          builder: (BuildContext context) {
            return AutofillGroup(
              child: ListView(
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  children: children),
            );
          },
        ));
  }
}
