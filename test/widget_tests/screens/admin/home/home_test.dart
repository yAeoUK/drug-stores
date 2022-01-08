import 'package:drug_stores/common/routes.dart';
import 'package:drug_stores/screens/admin/drug_form/drug_form.dart';
import 'package:drug_stores/screens/admin/home/home.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

main() {
  testWidgets('test add drug button is visible', (WidgetTester tester) async {
    await tester.pumpWidget(GetMaterialApp(
      home: AdminHomeScreen(),
    ));
    Finder finder = find.byIcon(Icons.add);
    expect(finder, findsOneWidget);
  });

  testWidgets('test add drug button click navigates to the add drug form',
      (WidgetTester tester) async {
    await tester.pumpWidget(GetMaterialApp(
      routes: routes,
      home: AdminHomeScreen(),
    ));
    Finder finder = find.byIcon(Icons.add);
    await tester.tap(finder);
    await tester.pumpAndSettle();
    finder = find.byType(AdminDrugForm);
    expect(finder, findsOneWidget);

    finder = find.text('addDrug'.tr());
    expect(finder, findsOneWidget);
  });
}
