import 'dart:convert';

import 'package:drug_stores/configs/api_config.dart';
import 'package:drug_stores/controllers/form_controller.dart';
import 'package:drug_stores/controllers/password_controller.dart';
import 'package:drug_stores/controllers/salesman_controller.dart';
import 'package:drug_stores/controllers/username_controller.dart';
import 'package:drug_stores/helper/network.dart';
import 'package:drug_stores/models/failure_response.dart';
import 'package:drug_stores/screens/salesman/home/home.dart';

// ignore: implementation_imports
import 'package:easy_localization/src/public_ext.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/route_manager.dart';

class SalesmanLoginController extends FormController {
  final username = UsernameController();
  final password = PasswordController();

  SalesmanLoginController() {
    print('initialising salesman login controller');
    addFieldBlocs(fieldBlocs: [username, password]);
  }

  Future submitData({required String? username, required String? password}) {
    print('username: ' + username!);
    print('password: ' + password!);
    return Network(onConnectionSucceed: (body) {
      print('salesman login connection succeed');
      super.onConnectionSucceed();
      Fluttertoast.showToast(
        msg: 'loginSuccess'.tr(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
      );
      SalesmanController salesmanController = Get.find<SalesmanController>();
      salesmanController.login(body["salesman"]);
      Get.offAndToNamed(SalesmanHomeScreen.routeName);
    }, onMessageReceived: (FailureResponse response) {
      super.onMessageReceived(response.content);
      print('admin salesman message received: ' + jsonEncode(response.content));
    }, onPreConnect: () {
      print('salesman login pre connect');
      super.onPreConnect();
    }, onPostConnect: () {
      print('salesman login post connect');
      super.onPostConnect();
    }, onConnectionFailed: () {
      super.onConnectionFailed();
      print('salesman login connection failed');
    }).post(
        url: ApiConfig.salesmanLogin,
        body: {'username': username, 'password': password});
  }

  @override
  void onSubmitting() {
    print('salesman controller submit');
    submitData(username: username.value, password: password.value);
  }
}
