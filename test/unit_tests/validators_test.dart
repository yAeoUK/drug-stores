import 'dart:math';

import 'package:drug_stores/common/validators.dart';
import 'package:drug_stores/helper/random.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  String randomField = Randoms.getRandomString();
  group('test required validator', () {
    test('test required validator returns error when using empty string', () {
      String? error = Validators(field: randomField).required('');
      expect(error, 'form.fieldRequired'.tr(namedArgs: {'field': randomField}));
    });
    test('test required validator returns error when using null value', () {
      String? error = Validators(field: randomField).required(null);
      expect(error, 'form.fieldRequired'.tr(namedArgs: {'field': randomField}));
    });
    test('test required validator returns null when value is entered', () {
      String? error =
          Validators(field: randomField).required(Randoms.getRandomString());
      expect(error, null);
    });
  });

  group('test minCharacters validator', () {
    int minRequiredCharacters = Random().nextInt(20) + 2;
    test(
        'test minCharacters validator returns error when using less than required characters',
        () {
      String? error = Validators(
              field: randomField, minimumCharacters: minRequiredCharacters)
          .minNCharacters(Randoms.getRandomString(
              length: Random().nextInt(minRequiredCharacters)));
      expect(
          error,
          'form.minNCharacters'.tr(namedArgs: {
            'field': randomField,
            'min': minRequiredCharacters.toString()
          }));
    });
    test(
        'test minCharacters validator returns null when entering sufficient number of characters',
        () {
      int randomNumber = Random().nextInt(20);
      String randomString =
          Randoms.getRandomString(length: minRequiredCharacters + randomNumber);
      String? error = Validators(
              field: randomField, minimumCharacters: minRequiredCharacters)
          .minNCharacters(randomString);
      print("minimum required characters: " + minRequiredCharacters.toString());
      print("Random number: " + randomNumber.toString());
      print("Random string: " + randomString);
      expect(error, null);
    });
  });
}
