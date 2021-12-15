import 'package:drug_stores/configs/language_config.dart';
// ignore: implementation_imports
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

class NoItems extends GetView {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text(LanguageConfig.itemListEmpty.tr()));
  }
}
