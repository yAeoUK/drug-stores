import 'package:drug_stores/abstracts/ItemListControllerBase.dart';
import 'package:drug_stores/configs/app_config.dart';
import 'package:drug_stores/configs/language_config.dart';
import 'package:drug_stores/helper/network.dart';
// ignore: implementation_imports
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

abstract class ItemsListController<T> implements ItemListControllerBase {
  RxBool loading = false.obs;
  RxList items = [].obs;
  RxString message = ''.obs;

  RxList itemsLoading = [].obs;
  List itemsMessage = [];

  RxBool loadMoreVisibility = true.obs;

  final Widget Function(BuildContext, int) itemBuilder;
  bool remote;
  String plural;
  String indexUrl;

  ItemsListController(
      {required this.itemBuilder,
      this.remote = true,
      required this.plural,
      required this.indexUrl});

  Future init({int offset = 0, bool refresh = false}) async {
    if (refresh) loadMoreVisibility(refresh);
    preListFetching();
    await loadData(offset: offset, refresh: refresh);
    postListFetching();
  }

  void preListFetching() {
    loading(true);
    message('');
  }

  void postListFetching() {
    if (items.isNotEmpty) message('');
    loading(false);
    // for (int c = itemsLoading.length; c < items.length; c++) {
    //   itemsLoading.add(false);
    //   itemsMessage.add('');
    // }
  }

  void preItemLoading(int index) {
    itemsLoading[index] = true;
  }

  void postItemLoading(int index) {
    itemsLoading[index] = false;
  }

  int? getItemIndex(int id) {
    for (int c = 0; c < items.length; c++)
      if (items[c]['id'].toString() == id.toString()) return c;
    return null;
  }

  @override
  void deleteItem(int id) {
    int? index = getItemIndex(id);
    items.removeAt(index!);
    itemsMessage.removeAt(index);
    itemsLoading.removeAt(index);
  }

  Future? loadData({int offset = 0, bool refresh = false}) {
    if (remote) return _getRemoteData(offset: offset, refresh: refresh);
    return null;
  }

  Future? _getRemoteData({required int offset, required bool refresh}) {
    return Network(
        onConnectionSucceed: (body) {
          if (refresh) {
            items.clear();
            itemsLoading.clear();
            itemsMessage.clear();
          }
          var newItems = body[plural];
          int oldCount = itemsLoading.length;
          for (int c = 0; c < newItems.length; c++) {
            itemsLoading.add(false);
            itemsMessage.add('');
          }
          items.addAll(newItems);
          if (items.length - oldCount < AppConfig.listItemsInitialCount)
            loadMoreVisibility(false);
        },
        onMessageReceived: (failureResponse) =>
            message(failureResponse.content),
        onConnectionFailed: () =>
            message(LanguageConfig.formNoConnection.tr())).post(
        url: indexUrl,
        body: {'limit': AppConfig.listItemsInitialCount, 'offset': offset});
  }

  @override
  void addItem(item) {
    // if (item is T) {
    if (items.length > 0) {
      items.insert(0, item);
      itemsMessage.insert(0, '');
      itemsLoading.insert(0, false);
    } else {
      items.add(item);
      itemsMessage.add('');
      itemsLoading.add(false);
    }
    // }
  }

  @override
  void editItem(item) {
    /// [item] is null when the edit screen is closed without editting an item successfully
    if (item != null) {
      int index = getItemIndex(int.parse(item['id']))!;
      items[index] = item;
    }
  }
}
