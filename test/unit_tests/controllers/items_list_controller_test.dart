import 'package:drug_stores/controllers/items_list_controller.dart';
import 'package:drug_stores/models/drug.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  test('test preFetching', () {
    ItemsListController itemsListController =
        ItemsListController(Future.delayed(Duration()));
    itemsListController.preFetching();
    expect(itemsListController.message(), '');
    expect(itemsListController.items, []);
    expect(itemsListController.loading(), true);
  });

  test('test postFetching if items is not empty', () {
    ItemsListController itemsListController =
        ItemsListController(Future.delayed(Duration()));
    itemsListController.items = [Drug.generate()];
    itemsListController.postFetching();
    expect(itemsListController.message(), '');
    expect(itemsListController.loading(), false);
  });
}
