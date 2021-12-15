import 'package:drug_stores/components/list_message.dart';
import 'package:drug_stores/helper/random.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';

main() {
  testWidgets('test message is displayed', (WidgetTester tester) async {
    String message = Randoms.getRandomString();
    await tester.pumpWidget(GetMaterialApp(
      home: ListMessage(message),
    ));
    Finder finder = find.text(message);
    expect(finder, findsOneWidget);
  });
}
