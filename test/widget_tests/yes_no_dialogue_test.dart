import 'package:drug_stores/configs/language_config.dart';
import 'package:drug_stores/dialogues/yes_no_dialogue.dart';
import 'package:drug_stores/helper/random.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

main() {
  String? title, content;
  setUpAll(() {
    title = Randoms.getRandomString();
    content = Randoms.getRandomString();
  });
  testWidgets('test dialogue title is visible', (WidgetTester tester) async {
    await tester.pumpWidget(
        GetMaterialApp(home: YesNoDialogue(title: title!, content: content!)));
    Finder finder = find.text(title!);
    expect(finder, findsOneWidget);
  });

  testWidgets('test dialogue content is visible', (WidgetTester tester) async {
    await tester.pumpWidget(
        GetMaterialApp(home: YesNoDialogue(title: title!, content: content!)));
    Finder finder = find.text(content!);
    expect(finder, findsOneWidget);
  });

  testWidgets('test \'yes\' button is visible', (WidgetTester tester) async {
    await tester.pumpWidget(
        GetMaterialApp(home: YesNoDialogue(title: title!, content: content!)));
    Finder finder = find.text(LanguageConfig.dialogueYes.tr());
    expect(finder, findsOneWidget);
  });

  testWidgets('test \'no\' button is visible', (WidgetTester tester) async {
    await tester.pumpWidget(
        GetMaterialApp(home: YesNoDialogue(title: title!, content: content!)));
    Finder finder = find.text(LanguageConfig.dialogueNo.tr());
    expect(finder, findsOneWidget);
  });
}
