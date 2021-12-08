import 'package:drug_stores/controllers/salesman_controller.dart';
import 'package:drug_stores/helper/shared_preferences_helper.dart';
import 'package:drug_stores/models/salesman.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';

main() {
  SalesmanController? salesmanController;
  setUpAll(() {
    salesmanController = Get.put(SalesmanController());
  });

  test('test logged in and login functions', () async {
    await SharedPreferencesHelper.clear();
    expect(salesmanController!.isLoggedIn(), false);
    await salesmanController!.login(Salesman.generate().toString());
    expect(salesmanController!.isLoggedIn(), true);
  });
}
