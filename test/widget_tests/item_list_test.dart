import 'package:drug_stores/components/items_list.dart';
import 'package:drug_stores/components/list_message.dart';
import 'package:drug_stores/components/no_items.dart';
import 'package:drug_stores/configs/language_config.dart';
import 'package:drug_stores/controllers/items_list_controller.dart';
import 'package:drug_stores/helper/random.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

main() {
  ItemsListController itemsListController =
      ItemsListController(Future.delayed(Duration(seconds: 1)));
  Widget Function(BuildContext, int) itemBuilder =
      (BuildContext context, int index) => Text(index.toString());
  testWidgets('test message is visible', (WidgetTester tester) async {
    itemsListController.message(Randoms.getRandomString());
    itemsListController.items = [];
    await tester.pumpWidget(GetMaterialApp(
      home: ItemsList(
        controller: itemsListController,
        itemBuilder: itemBuilder,
      ),
    ));
    Finder finder = find.byType(ListMessage);
    expect(finder, findsOneWidget);

    finder = find.text(itemsListController.message());
    expect(finder, findsOneWidget);
  });

  testWidgets('test no items are visible when there is no data',
      (WidgetTester tester) async {
    itemsListController.message('');
    itemsListController.items = [];
    await tester.pumpWidget(GetMaterialApp(
      home: ItemsList(
        controller: itemsListController,
        itemBuilder: itemBuilder,
      ),
    ));
    Finder finder = find.byType(NoItems);
    expect(finder, findsOneWidget);

    finder = find.text(LanguageConfig.itemListEmpty.tr());
    expect(finder, findsOneWidget);
  });

  testWidgets('test last item is visible', (WidgetTester tester) async {
    itemsListController.items = [];
    int randomNumberOfWidgets = Randoms.getRandomInt(max: Randoms.acceptedInt);
    for (int c = 0; c < randomNumberOfWidgets; c++) {
      itemsListController.items.add(Randoms.getRandomString());
    }
    await tester.pumpWidget(GetMaterialApp(
      home: ItemsList(
        controller: itemsListController,
        itemBuilder: itemBuilder,
      ),
    ));

    var finder = find.text((randomNumberOfWidgets - 1).toString());
    await tester.scrollUntilVisible(finder, 500.0,
        maxScrolls: randomNumberOfWidgets);
    expect(finder, findsOneWidget);
  });
}
