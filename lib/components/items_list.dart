import 'package:drug_stores/components/form_message.dart';
import 'package:drug_stores/components/list_message.dart';
import 'package:drug_stores/components/loading.dart';
import 'package:drug_stores/components/no_items.dart';
import 'package:drug_stores/components/submit_button.dart';
import 'package:drug_stores/configs/language_config.dart';
import 'package:drug_stores/controllers/items_list_controller.dart';

// ignore: implementation_imports
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

class ItemsList extends GetView {
  final ItemsListController controller;
  final bool remoteData;

  ItemsList({required this.controller, this.remoteData = true});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: controller.init(),
      builder: (BuildContext context, AsyncSnapshot asyncSnapshot) {
        if (remoteData)
          return RefreshIndicator(
              child: _ItemListLocale(controller),
              onRefresh: () {
                if (controller.loading()) return Future.value();
                return controller.init(refresh: true);
              });
        return _ItemListLocale(controller);
      },
    );
  }
}

class _ItemListLocale extends GetView {
  final ItemsListController controller;

  _ItemListLocale(this.controller);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.items.isEmpty) {
        if (controller.loading()) return Center(child: Loading());
        if (controller.message() != '')
          return ListMessage(controller.message());
        return NoItems();
      }
      return ListView(physics: AlwaysScrollableScrollPhysics(), children: [
        if (controller.message().isNotEmpty)
          FormMessage(
              message: controller.message(),
              onDismiss: () => controller.message('')),
        ListView.builder(
            itemBuilder: controller.itemBuilder,
            itemCount: controller.items.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics()),
        if (controller.loadMoreVisibility())
          SubmitButton(
              text: LanguageConfig.itemListLoadMore.tr(),
              loading: controller.loading(),
              onSubmit: () => controller.init(offset: controller.items.length))
      ]);
    });
  }
}
