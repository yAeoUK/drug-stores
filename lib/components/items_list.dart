import 'package:drug_stores/components/form_message.dart';
import 'package:drug_stores/components/list_message.dart';
import 'package:drug_stores/components/loading.dart';
import 'package:drug_stores/components/no_items.dart';
import 'package:drug_stores/components/submit_button.dart';
import 'package:drug_stores/configs/language_config.dart';
import 'package:drug_stores/controllers/items_list_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

class ItemsList extends GetView {
  final ItemsListController controller;
  final Widget Function(BuildContext, int) itemBuilder;
  final bool remoteData;

  ItemsList(
      {required this.controller,
      required this.itemBuilder,
      this.remoteData = true});

  @override
  Widget build(BuildContext context) {
    if (remoteData)
      return RefreshIndicator(
          child: _ItemListLocale(itemBuilder, controller),
          onRefresh: () => controller.init());
    controller.init();
    return _ItemListLocale(itemBuilder, controller);
  }
}

class _ItemListLocale extends GetView {
  final Widget Function(BuildContext, int) itemBuilder;
  final ItemsListController controller;

  _ItemListLocale(this.itemBuilder, this.controller);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.items.isEmpty) {
        if (controller.loading()) return Loading();
        if (controller.message() != '')
          return ListMessage(controller.message());
        return NoItems();
      }
      return ListView(
          shrinkWrap: true,
          physics: AlwaysScrollableScrollPhysics(),
          children: [
            if (controller.message().isNotEmpty)
              FormMessage(
                  message: controller.message(),
                  onDismiss: () => controller.message('')),
            ListView.builder(
                itemBuilder: itemBuilder,
                itemCount: controller.items.length,
                shrinkWrap: true,
                physics: AlwaysScrollableScrollPhysics()),
            SubmitButton(
                text: LanguageConfig.itemListLoadMore,
                loading: controller.loading(),
                onSubmit: () => controller.loadData(controller.items.length))
          ]);
    });
  }
}
