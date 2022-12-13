import 'dart:convert';

import 'package:drug_stores/abstracts/user_base.dart';
import 'package:drug_stores/helper/shared_preferences_helper.dart';

class SalesmanController implements UserBase {
  static String _salesman = 'salesman';

  @override
  bool isLoggedIn() => SharedPreferencesHelper.hasKey(_salesman);

  @override
  Future login(Map object) =>
      SharedPreferencesHelper.set(_salesman, jsonEncode(object));

  @override
  Future logout() => SharedPreferencesHelper.remove(_salesman);

  @override
  int? getId() {
    if (isLoggedIn())
      return int.parse(
          jsonDecode(SharedPreferencesHelper.get(_salesman))['id']);
    return null;
  }
}
