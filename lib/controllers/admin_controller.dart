import 'package:drug_stores/abstracts/user.dart';
import 'package:drug_stores/helper/shared_preferences_helper.dart';

class AdminController implements UserBase {
  static String _admin = 'admin';

  @override
  bool isLoggedIn() => SharedPreferencesHelper.hasKey(_admin);

  @override
  Future login(String text) => SharedPreferencesHelper.set(_admin, text);
}
