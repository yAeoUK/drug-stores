import 'package:drug_stores/common/routes.dart';
import 'package:drug_stores/models/drug.dart';
import 'package:drug_stores/screens/admin/home/components/drug_item.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

main() {
  Drug? drug;
  setUpAll(() {
    drug = Drug.generate();
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
    finder = find.text('addDrug'.tr());
    expect(finder, findsOneWidget);
  });
}