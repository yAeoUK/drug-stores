import 'package:drug_stores/components/form_message.dart';
import 'package:drug_stores/configs/language_config.dart';
import 'package:drug_stores/helper/random.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

main() {
  String? randomText;
  setUpAll(() {
    randomText = Randoms.getRandomString();
  });
  testWidgets('test ok button is displayed', (tester) async {
    await tester.pumpWidget(GetMaterialApp(
      home: FormMessage(
        message: randomText!,
        onDismiss: () {},
      ),
    ));
    Finder finder = find.text(LanguageConfig.formOk.tr());
    await tester.ensureVisible(finder);
    expect(finder, findsOneWidget);
  });
  testWidgets('test message is displayed', (tester) async {
    await tester.pumpWidget(GetMaterialApp(
      home: FormMessage(
        message: randomText!,
        onDismiss: () {},
      ),
    ));
    expect(find.text(randomText!), findsOneWidget);
  });
  testWidgets('test function is working', (tester) async {
    int randomNumber = Randoms.getRandomInt();
    int randomDecrement = Randoms.getRandomInt();
    print(randomNumber);
    print(randomDecrement);
    int subtraction = randomNumber - randomDecrement;
    await tester.pumpWidget(GetMaterialApp(
      home: FormMessage(
        message: randomText!,
        onDismiss: () => randomNumber -= randomDecrement,
      ),
    ));
    Finder finder = find.text(LanguageConfig.formOk.tr());
    await tester.ensureVisible(finder);
    await tester.tap(finder);
    expect(subtraction, randomNumber);
  });
}
