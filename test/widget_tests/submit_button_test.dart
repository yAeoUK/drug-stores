import 'package:drug_stores/components/submit_button.dart';
import 'package:drug_stores/helper/random.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';

void main() {
  String? buttonText;
  setUpAll(() {
    buttonText = Randoms.getRandomString();
  });
  testWidgets('Test if the text passed is visible',
      (WidgetTester tester) async {
    // number is used as an indicator to know whether the function is running

    await tester.pumpWidget(GetMaterialApp(
      home: SubmitButton(text: buttonText!, onSubmit: () {}),
    ));
    expect(find.text(buttonText!), findsOneWidget);
  });

  testWidgets('test if the function passed is working', (tester) async {
    int number = Randoms.getRandomInt() - 1;
    int oldNumber = number;
    await tester.pumpWidget(GetMaterialApp(
      home: SubmitButton(text: buttonText!, onSubmit: () => number++),
    ));
    await tester.tap(find.text(buttonText!));
    expect(number, oldNumber + 1);
  });

  testWidgets('test if the loading widget is visible when loading is true',
      (tester) async {
    bool loading = Randoms.getRandomInt(max: 2) == 1;
    await tester.pumpWidget(GetMaterialApp(
      home: SubmitButton(
        text: buttonText!,
        onSubmit: () => {},
        loading: loading,
      ),
    ));

    expect(find.byKey(SubmitButton.loadingKey),
        loading ? findsOneWidget : findsNothing);
  });

  testWidgets('test if the color of the button is the primary color',
      (tester) async {
    await tester.pumpWidget(GetMaterialApp(
      home: SubmitButton(
        text: buttonText!,
        onSubmit: () => {},
      ),
    ));

    ElevatedButton button = tester.widget(find.byType(SubmitButton.buttonType));
    expect(button.style!.backgroundColor.toString(),
        MaterialStateProperty.all(Get.theme.primaryColor).toString());
  });

  testWidgets(
      'test if the color of the loading widget is the primary color light',
      (tester) async {
    await tester.pumpWidget(GetMaterialApp(
      home: SubmitButton(
        loading: true,
        text: buttonText!,
        onSubmit: () => {},
      ),
    ));

    CircularProgressIndicator loading =
        tester.widget(find.byType(SubmitButton.loadingType));
    expect(loading.color, Get.theme.primaryColorLight);
  });

  testWidgets('test if the color of the text is the background color',
      (tester) async {
    await tester.pumpWidget(GetMaterialApp(
      home: SubmitButton(
        text: buttonText!,
        onSubmit: () => {},
      ),
    ));

    Text text = tester.widget(find.text(buttonText!));
    expect(text.style!.color, Get.theme.backgroundColor);
  });
}
