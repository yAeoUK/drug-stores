import 'package:drug_stores/controllers/admin_controller.dart';
import 'package:drug_stores/helper/shared_preferences_helper.dart';
import 'package:drug_stores/models/admin.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';

main() {
  AdminController? adminController;
  setUpAll(() async {
    adminController = Get.put(AdminController());
    await SharedPreferencesHelper.clear();
  });

  test('test logged in and login functions', () async {
    expect(adminController!.isLoggedIn(), false);
    await adminController!.login(Admin.generate().toString());
    expect(adminController!.isLoggedIn(), true);
  });
}
