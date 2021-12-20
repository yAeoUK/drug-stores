import 'package:drug_stores/common/enums.dart';
import 'package:drug_stores/configs/language_config.dart';

// ignore: implementation_imports
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:get/route_manager.dart';

class YesNoDialogue extends GetView {
  final String title, content;

  YesNoDialogue({required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        title,
        overflow: TextOverflow.ellipsis,
      ),
      content: SingleChildScrollView(
        child: Text(content),
      ),
      actions: [
        TextButton(
            onPressed: () => Get.back(result: DialogueResponse.no),
            child: Text(LanguageConfig.dialogueNo.tr())),
        TextButton(
            style: ButtonStyle(
                textStyle: MaterialStateProperty.all(
                    TextStyle(color: Get.theme.primaryColor))),
            onPressed: () => Get.back(result: DialogueResponse.yes),
            child: Text(LanguageConfig.dialogueYes.tr()))
      ],
    );
  }
}
