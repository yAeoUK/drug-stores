import 'dart:convert';

import 'package:drug_stores/abstracts/ItemListControllerBase.dart';
import 'package:drug_stores/abstracts/model_base.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ItemsListController<T> implements ItemListControllerBase {
  RxBool loading = false.obs;
  List items = [].obs;
  RxString message = ''.obs;

  RxList itemsLoading = [].obs;
  List itemsMessage = [];

  RxBool loadMoreVisibility = true.obs;

  final Widget Function(BuildContext, int) itemBuilder;

  ItemsListController(this.itemBuilder);

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
      if (items[c].id.toString() == id.toString()) return c;
    return null;
  }

  @override
  Future? deleteItem(int id) {
    int? index = getItemIndex(id);
    items.removeAt(index!);
    itemsMessage.removeAt(index);
    itemsLoading.removeAt(index);
  }

  @override
  Future? loadData({int offset = 0, bool refresh = false}) => null;

  @override
  Future? addItem(item) {
    if (item is T) {
      if (items.length > 0) {
        items.insert(0, item);
        itemsMessage.insert(0, '');
        itemsLoading.insert(0, false);
      } else {
        items.add(item);
        itemsMessage.add('');
        itemsLoading.add(false);
      }
    }
  }

  @override
  Future? editItem(item) {
    if (item is T && item is ModelBase) {
      int index = getItemIndex(jsonDecode(jsonEncode(item.toMap()))['id'])!;
      items[index] = item;
    }
  }
}
