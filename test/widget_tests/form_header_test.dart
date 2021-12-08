import 'package:drug_stores/components/form_header.dart';
import 'package:drug_stores/helper/random.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

main() {
  testWidgets('test that passed text is displayed',
      (WidgetTester tester) async {
    String randomText = Randoms.getRandomString();
    await tester.pumpWidget(GetMaterialApp(
      home: FormHeader(randomText),
    ));
    expect(find.text(randomText), findsOneWidget);
  });
}
