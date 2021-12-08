import 'package:drug_stores/components/submit_form.dart';
import 'package:drug_stores/helper/random.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

main() {
  testWidgets('test last widget is accessible', (WidgetTester tester) async {
    int acceptedNumberOfElements = 5000;
    int randomNumberOfWidgets =
        Randoms.getRandomInt(max: acceptedNumberOfElements);
    print(randomNumberOfWidgets);
    List<Widget> widgets = List<Widget>.generate(
        randomNumberOfWidgets,
        (i) => Text(
              i.toString(),
              key: ValueKey(i),
            ));
    await tester.pumpWidget(GetMaterialApp(home: SubmitForm(widgets)));
    var finder = find.byKey(ValueKey(randomNumberOfWidgets - 1));
    await tester.scrollUntilVisible(finder, 500.0,
        maxScrolls: randomNumberOfWidgets);
    expect(finder, findsOneWidget);
  });
}
