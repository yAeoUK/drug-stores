import 'package:drug_stores/abstracts/ItemListControllerBase.dart';
import 'package:get/get.dart';

class ItemsListController implements ItemListControllerBase {
  RxBool loading = false.obs;
  List items = [].obs;
  RxString message = ''.obs;

  RxList itemsLoading = [].obs;
  List itemsMessage = [];

  Future init() async {
    preListFetching();
    await loadData(items.length);
    postListFetching();
  }

  void preListFetching() {
    loading(true);
    message('');
  }

  void postListFetching() {
    if (items.isNotEmpty) message('');
    loading(false);
    for (int c = itemsLoading.length; c < items.length; c++) {
      itemsLoading.add(false);
      itemsMessage.add('');
    }
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
  Future? deleteItem(int id) =>null;

  @override
  Future? loadData(int offset) =>null;


}
