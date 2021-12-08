import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FormHeader extends GetView {
  final String title;

  FormHeader(this.title);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(title,
          textAlign: TextAlign.center, style: Get.textTheme.headline5),
    );
  }
}
