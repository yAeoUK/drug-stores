import 'package:drug_stores/controllers/items_list_controller.dart';
import 'package:drug_stores/helper/random.dart';
import 'package:drug_stores/models/drug.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  test('test preFetching', () {
    ItemsListController itemsListController = ItemsListController();
    itemsListController.preListFetching();
    expect(itemsListController.message(), '');
    expect(itemsListController.items, []);
    expect(itemsListController.loading(), true);
  });

  test('test postFetching if items is not empty', () {
    ItemsListController itemsListController = ItemsListController();
    itemsListController.items = [Drug.generate()];
    itemsListController.postListFetching();
    expect(itemsListController.message(), '');
    expect(itemsListController.loading(), false);
    expect(itemsListController.itemsMessage.length,
        itemsListController.items.length);
    expect(itemsListController.itemsLoading.length,
        itemsListController.items.length);
  });

  test('test preItemLoading', () {
    ItemsListController itemsListController = ItemsListController();
    itemsListController.items = [Drug.generate()];
    itemsListController.postListFetching();
    int randomIndex = Randoms.getRandomInt(
        max: itemsListController.items.length);
    itemsListController.preItemLoading(randomIndex);
    expect(itemsListController.itemsLoading[randomIndex], true);
  });

  test('test postItemLoading', () {
    ItemsListController itemsListController = ItemsListController();
    itemsListController.items = [Drug.generate()];
    itemsListController.postListFetching();
    int randomIndex = Randoms.getRandomInt(
        max: itemsListController.items.length);
    itemsListController.postItemLoading(randomIndex);
    expect(itemsListController.itemsLoading[randomIndex], false);
  });
}
