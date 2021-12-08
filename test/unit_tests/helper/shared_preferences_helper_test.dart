import 'package:drug_stores/helper/random.dart';
import 'package:drug_stores/helper/shared_preferences_helper.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  setUpAll(() async {
    await SharedPreferencesHelper.init();
  });

  test('test if storage is cleared successfully', () async {
    await SharedPreferencesHelper.clear();
    var keys = SharedPreferencesHelper.getKeys();
    expect(keys.length, 0);
  });

  test('test if default value is given when keys does not exists', () async {
    String randomKey = Randoms.getRandomString();
    String randomDefaultValue = Randoms.getRandomString();
    await SharedPreferencesHelper.remove(randomKey);
    String value = await SharedPreferencesHelper.get(randomKey,
        defaultValue: randomDefaultValue);
    expect(value, randomDefaultValue);
  });

  test('test null is given when keys does not exists', () async {
    String randomKey = Randoms.getRandomString();
    await SharedPreferencesHelper.remove(randomKey);
    dynamic value = await SharedPreferencesHelper.get(randomKey);
    expect(value, null);
  });

  test('test a value is set successfully', () async {
    String randomKey = Randoms.getRandomString();
    String randomValue = Randoms.getRandomString();
    await SharedPreferencesHelper.set(randomKey, randomValue);
    dynamic value = await SharedPreferencesHelper.get(randomKey);
    expect(value, randomValue);
  });

  test('test a value is removed successfully', () async {
    String randomKey = Randoms.getRandomString();
    String randomValue = Randoms.getRandomString();
    await SharedPreferencesHelper.set(randomKey, randomValue);
    await SharedPreferencesHelper.remove(randomKey);
    expect(SharedPreferencesHelper.hasKey(randomKey), false);
  });

  test('test hasKey function returns false when value does not exists',
      () async {
    await SharedPreferencesHelper.clear();
    String randomKey = Randoms.getRandomString();
    expect(SharedPreferencesHelper.hasKey(randomKey), false);
  });

  test('test hasKey function returns true when value exists', () async {
    await SharedPreferencesHelper.clear();
    String randomKey = Randoms.getRandomString();
    String randomValue = Randoms.getRandomString();
    await SharedPreferencesHelper.set(randomKey, randomValue);
    expect(SharedPreferencesHelper.hasKey(randomKey), true);
  });
}
