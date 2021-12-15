import 'package:get/get.dart';

class ItemsListController {
  Future initialFetch;

  ItemsListController(this.initialFetch);

  RxBool loading = false.obs;
  List items = [].obs;
  RxString message = ''.obs;

  Future init() async {
    preFetching();
    await initialFetch;
    postFetching();
  }

  void preFetching() {
    loading(true);
    items = [];
    message('');
  }

  void postFetching() {
    if (items.isNotEmpty) message('');
    loading(false);
  }
}
