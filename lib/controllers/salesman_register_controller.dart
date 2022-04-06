import 'dart:convert';

import 'package:drug_stores/common/validators.dart';
import 'package:drug_stores/configs/api_config.dart';
import 'package:drug_stores/configs/language_config.dart';
import 'package:drug_stores/controllers/form_controller.dart';
import 'package:drug_stores/controllers/password_controller.dart';
import 'package:drug_stores/controllers/salesman_controller.dart';
import 'package:drug_stores/controllers/username_controller.dart';
import 'package:drug_stores/helper/network.dart';
import 'package:drug_stores/models/failure_response.dart';
import 'package:drug_stores/screens/salesman/home/home.dart';
// ignore: implementation_imports
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/route_manager.dart';

class SalesmanRegisterController extends FormController {
  final username = UsernameController();
  final password = PasswordController();
  final confirmPassword = TextFieldBloc(
    validators: [
      Validators(field: LanguageConfig.confirmPassword.tr()).required,
      Validators(
              field: LanguageConfig.confirmPassword.tr(), minimumCharacters: 6)
          .minNCharacters,
    ],
  );
  final TextFieldBloc fullName = TextFieldBloc(
      validators: [Validators(field: LanguageConfig.fullName.tr()).required]);

  SalesmanRegisterController() {
    print('initialising salesman register controller');
    confirmPassword.addValidators([
      Validators(
              field: LanguageConfig.confirmPassword.tr(),
              otherFieldName: LanguageConfig.password.tr(),
              otherFieldBloc: password)
          .identical
    ]);
    addFieldBlocs(fieldBlocs: [username, password, confirmPassword, fullName]);
  }

  Future submitData(
      {required String username,
      required String password,
      required String fullName}) {
    print('username: ' + username);
    print('password: ' + password);
    print('fullName: ' + fullName);
    return Network(onConnectionSucceed: (body) {
      print('salesman register connection succeed');
      super.onConnectionSucceed();
      Fluttertoast.showToast(
        msg: 'registerSuccess'.tr(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
      );
      SalesmanController salesmanController = Get.find();
      salesmanController.login(body['salesman'].toString());
      Get.offAndToNamed(SalesmanHomeScreen.routeName);
    }, onMessageReceived: (FailureResponse response) {
      super.onMessageReceived(response.content);
      print('admin salesman message received: ' + jsonEncode(response.content));
    }, onPreConnect: () {
      print('salesman register pre connect');
      super.onPreConnect();
    }, onPostConnect: () {
      print('salesman register post connect');
      super.onPostConnect();
    }, onConnectionFailed: () {
      super.onConnectionFailed();
      print('salesman register connection failed');
    }).post(url: ApiConfig.salesmanRegister, body: {
      'username': username,
      'password': password,
      'fullName': fullName
    });
  }

  @override
  void onSubmitting() {
    print('salesman controller submit');
    submitData(
        username: username.value,
        password: password.value,
        fullName: fullName.value);
  }
}
