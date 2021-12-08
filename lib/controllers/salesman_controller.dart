import 'package:drug_stores/abstracts/user.dart';
import 'package:drug_stores/helper/shared_preferences_helper.dart';

class SalesmanController implements UserBase {
  static String _salesman = 'salesman';

  @override
  bool isLoggedIn() => SharedPreferencesHelper.hasKey(_salesman);

  @override
  Future login(String text) => SharedPreferencesHelper.set(_salesman, text);
}
