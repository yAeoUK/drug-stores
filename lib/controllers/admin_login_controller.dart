import 'dart:convert';

import 'package:drug_stores/configs/api_config.dart';
import 'package:drug_stores/controllers/form_controller.dart';
import 'package:drug_stores/controllers/password_controller.dart';
import 'package:drug_stores/controllers/username_controller.dart';
import 'package:drug_stores/helper/network.dart';
import 'package:drug_stores/helper/shared_preferences_helper.dart';
import 'package:drug_stores/models/failure_response.dart';
import 'package:drug_stores/screens/admin/home/home.dart';

// ignore: implementation_imports
import 'package:easy_localization/src/public_ext.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/route_manager.dart';

class AdminLoginController extends FormController {
  final username = UsernameController();
  final password = PasswordController();

  AdminLoginController() {
    print('initialising admin login controller');
    addFieldBlocs(fieldBlocs: [username, password]);
  }

  Future submitData({required String? username, required String? password}) {
    print('username: ' + username!);
    print('password: ' + password!);
    return Network(onConnectionSucceed: (body) {
      print('admin login connection succeed');
      super.onConnectionSucceed();
      Fluttertoast.showToast(
        msg: 'loginSuccess'.tr(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
      );
      SharedPreferencesHelper.set("admin", body['admin'].toString());
      Get.offAndToNamed(AdminHomeScreen.routeName);
    }, onMessageReceived: (FailureResponse response) {
      super.onMessageReceived(response.content);
      print('admin login message received: ' + jsonEncode(response.content));
    }, onPreConnect: () {
      print('admin login pre connect');
      super.onPreConnect();
    }, onPostConnect: () {
      print('admin login post connect');
      super.onPostConnect();
    }, onConnectionFailed: () {
      super.onConnectionFailed();
      print('admin login connection failed');
    }).post(
        url: ApiConfig.adminLogin,
        body: {'username': username, 'password': password});
  }

  @override
  void onSubmitting() {
    print('controller submit');
    submitData(username: username.value, password: password.value);
  }
}
