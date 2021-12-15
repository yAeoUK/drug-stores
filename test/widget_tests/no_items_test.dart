import 'package:drug_stores/components/no_items.dart';
import 'package:drug_stores/configs/language_config.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

main() {
  testWidgets('Test no content text is visible', (WidgetTester tester) async {
    await tester.pumpWidget(GetMaterialApp(
      home: NoItems(),
    ));
    Finder finder = find.text(LanguageConfig.itemListEmpty.tr());
    expect(finder, findsOneWidget);
  });
}
