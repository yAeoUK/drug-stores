import 'dart:convert';

import 'package:drug_stores/configs/api_config.dart';
import 'package:drug_stores/controllers/main_controller.dart';
import 'package:drug_stores/helper/network.dart';
import 'package:drug_stores/helper/random.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get_connect.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'admin_login_controller_test.mocks.dart';

@GenerateMocks([GetHttpClient])
Future<void> main() async {
  late MockGetHttpClient client;

  setUpAll(() async {
    MainController.testing = true;
    await MainController.initServices();
    client = MockGetHttpClient();
  });

  test('test credentials are invalid', () async {
    final invalidCredentials = {
      'username': Randoms.getRandomString(),
      'password': Randoms.getRandomString()
    };
    String responseBody =
        '{"result":"1","message":"\u062e\u0637\u0623 \u0641\u064a \u0627\u0633\u0645 \u0627\u0644\u0645\u0633\u062a\u062e\u062f\u0645 \u0623\u0648 \u0643\u0644\u0645\u0629 \u0627\u0644\u0633\u0631, \u062a\u062d\u0642\u0642 \u0645\u0646 \u0627\u0644\u0628\u064a\u0627\u0646\u0627\u062a \u0627\u0644\u0645\u062f\u062e\u0644\u0629 \u0648\u062d\u0627\u0648\u0644 \u0645\u062c\u062f\u062f\u0627\u064b"}';
    when(client.post(ApiConfig.adminLogin,
            body: invalidCredentials, headers: Network.headers))
        .thenAnswer((realInvocation) async =>
            Response(statusCode: HttpStatus.ok, body: responseBody));
    Response response = await GetHttpClient().post(ApiConfig.adminLogin,
        body: invalidCredentials, headers: Network.headers);
    print(response.bodyString);
    expect(response.statusCode, HttpStatus.ok);
    var body = jsonDecode(responseBody);
    expect(body["result"], "1");
    expect(body["message"],
        "\u062e\u0637\u0623 \u0641\u064a \u0627\u0633\u0645 \u0627\u0644\u0645\u0633\u062a\u062e\u062f\u0645 \u0623\u0648 \u0643\u0644\u0645\u0629 \u0627\u0644\u0633\u0631, \u062a\u062d\u0642\u0642 \u0645\u0646 \u0627\u0644\u0628\u064a\u0627\u0646\u0627\u062a \u0627\u0644\u0645\u062f\u062e\u0644\u0629 \u0648\u062d\u0627\u0648\u0644 \u0645\u062c\u062f\u062f\u0627\u064b");
  });

  test('test credentials are valid', () async {
    final validCredentials = {
      'username': 'ahmad.rajab',
      'password': 'abcdefgh'
    };
    String responseBody =
        '{"admin":{"id":"1","username":"ahmad.rajab","password":"abcdefgh","type":"1","appId":"1","created_at":"2021-11-17 19:18:00","updated_at":"0000-00-00 00:00:00"},"result":"0"}';
    when(client.post(ApiConfig.adminLogin,
            body: validCredentials, headers: Network.headers))
        .thenAnswer((realInvocation) async =>
            Response(statusCode: HttpStatus.ok, body: responseBody));
    Response response = await GetHttpClient().post(ApiConfig.adminLogin,
        body: validCredentials, headers: Network.headers);
    expect(response.statusCode, HttpStatus.ok);
    var body = jsonDecode(responseBody);
    expect(body["result"], "0");
    expect(body["admin"], {
      "id": "1",
      "username": "ahmad.rajab",
      "password": "abcdefgh",
      "type": "1",
      "appId": "1",
      "created_at": "2021-11-17 19:18:00",
      "updated_at": "0000-00-00 00:00:00"
    });
  });
}
