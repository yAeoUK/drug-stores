import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SharedPreferencesHelper extends GetxService {
  static Future init() => GetStorage().initStorage;

  static Future clear() => GetStorage().erase();

  static Iterable getKeys() => GetStorage().getKeys();

  static dynamic get(String key, {dynamic defaultValue}) =>
      GetStorage().read(key) ?? defaultValue;

  static Future set(String key, dynamic value) =>
      GetStorage().write(key, value);

  static Future remove(String key) => GetStorage().remove(key);

  static bool hasKey(String key) => GetStorage().hasData(key);
}
