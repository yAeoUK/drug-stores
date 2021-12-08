import 'package:drug_stores/configs/language_config.dart';
import 'package:drug_stores/controllers/form_controller.dart';
import 'package:drug_stores/helper/random.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  FormController? controller;
  setUpAll(() => controller = FormController());
  test('test message is displayed', () {
    String randomMessage = Randoms.getRandomString();
    controller!.onMessageReceived(randomMessage);
    expect(controller!.message(), randomMessage);
  });

  group('test preConnect', () {
    test('test loading is true', () {
      controller!.onPreConnect();
      expect(controller!.loading(), true);
    });
    test('test message is empty', () {
      controller!.onPreConnect();
      expect(controller!.message(), '');
    });
  });

  test('test loading is false on post connect', () {
    controller!.onPostConnect();
    expect(controller!.loading(), false);
  });

  test('test message is no connection when connection fails', () {
    controller!.onConnectionFailed();
    expect(controller!.message(), LanguageConfig.formNoConnection.tr());
  });
}
