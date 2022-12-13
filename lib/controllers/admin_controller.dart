import 'dart:convert';

import 'package:drug_stores/abstracts/user_base.dart';
import 'package:drug_stores/helper/shared_preferences_helper.dart';

class AdminController implements UserBase {
  static String _admin = 'admin';

  @override
  bool isLoggedIn() => SharedPreferencesHelper.hasKey(_admin);

  @override
  Future login(Map object) =>
      SharedPreferencesHelper.set(_admin, jsonEncode(object));

  @override
  Future logout() => SharedPreferencesHelper.remove(_admin);

  @override
  int? getId() {
    if (isLoggedIn())
      return int.parse(jsonDecode(SharedPreferencesHelper.get(_admin))['id']);
    return null;
  }
}
