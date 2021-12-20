import 'package:drug_stores/common/routes.dart';
import 'package:drug_stores/controllers/admin_drugs_list_controller.dart';
import 'package:drug_stores/dialogues/yes_no_dialogue.dart';
import 'package:drug_stores/helper/random.dart';
import 'package:drug_stores/models/drug.dart';
import 'package:drug_stores/screens/admin/drug_form/drug_form.dart';
import 'package:drug_stores/screens/admin/home/components/drug_item.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/instance_manager.dart';

main() {
  Drug? drug;
  setUpAll(() {
    drug = Drug.generate();
    Get.put(AdminDrugsListController());
  });
  testWidgets('test drug name is visible', (tester) async {
    await tester.pumpWidget(GetMaterialApp(
        home: Scaffold(
      body: DrugItem(
        drug: drug!,
      ),
    )));
    Finder finder = find.text(drug!.name!);
    expect(finder, findsOneWidget);
  });

  testWidgets('test drug quantity is visible', (tester) async {
    await tester.pumpWidget(GetMaterialApp(
        home: Scaffold(
      body: DrugItem(
        drug: drug!,
      ),
    )));
    Finder finder = find.text(
        'drugQuantity'.tr(namedArgs: {'quantity': drug!.quantity.toString()}));
    expect(finder, findsOneWidget);
  });

  testWidgets('test message is visible when there is a message',
      (tester) async {
    Get.delete<AdminDrugsListController>();
    AdminDrugsListController itemsListController = AdminDrugsListController();
    itemsListController.items = [drug!];
    String randomMessage = Randoms.getRandomString();
    itemsListController.itemsMessage = [randomMessage];
    Get.put(itemsListController);
    await tester.pumpWidget(GetMaterialApp(
        home: Scaffold(
      body: DrugItem(
        drug: drug!,
      ),
    )));
    Finder finder = find.text(randomMessage);
    expect(finder, findsOneWidget);
  });

  testWidgets('test edit icon is visible', (tester) async {
    await tester.pumpWidget(GetMaterialApp(
        home: Scaffold(
      body: DrugItem(
        drug: drug!,
      ),
    )));
    Finder finder = find.byIcon(Icons.edit);
    expect(finder, findsOneWidget);
  });

  testWidgets('test edit icon click opens the drug form screen',
      (tester) async {
    await tester.pumpWidget(GetMaterialApp(
        routes: routes,
        home: Scaffold(
          body: DrugItem(
            drug: drug!,
          ),
        )));
    Finder finder = find.byIcon(Icons.edit);
    await tester.tap(finder);
    await tester.pumpAndSettle();
    finder = find.byType(DrugForm);
    expect(finder, findsOneWidget);
  });

  testWidgets('test delete icon is visible', (tester) async {
    await tester.pumpWidget(GetMaterialApp(
        home: Scaffold(
      body: DrugItem(
        drug: drug!,
      ),
    )));
    Finder finder = find.byIcon(Icons.delete);
    expect(finder, findsOneWidget);
  });

  testWidgets('test delete icon click opens a confirm dialogue',
      (tester) async {
    await tester.pumpWidget(GetMaterialApp(
        routes: routes,
        home: Scaffold(
          body: DrugItem(
            drug: drug!,
          ),
        )));
    Finder finder = find.byIcon(Icons.delete);
    await tester.tap(finder);
    await tester.pumpAndSettle();
    finder = find.byType(YesNoDialogue);
    expect(finder, findsOneWidget);

    finder = find.text('drug.dialogue.delete.title'.tr());
    expect(finder, findsOneWidget);

    finder = find.text('drug.dialogue.delete.content'.tr());
    expect(finder, findsOneWidget);
  });
}
