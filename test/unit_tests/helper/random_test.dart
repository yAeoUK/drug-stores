import 'package:drug_stores/helper/random.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('test random int less than given int', () {
    int length = Randoms.getRandomInt();
    int random = Randoms.getRandomInt(max: length);
    expect(random < length, true);
  });

  test('test random string length equals length parameter', () {
    int length = Randoms.getRandomInt(max: Randoms.acceptedInt);
    String randomString = Randoms.getRandomString(length: length);
    expect(randomString.length, length);
  });

  /// Test random string contains allowed characters by the following algorithm
  /// 1- loop through the characters list
  /// 2- replace each instance of the character in the [randomString] by empty string
  /// 3- check if the [randomString] is empty
  test('test random string characters are within the allowed characters', () {
    String randomString = Randoms.getRandomString();
    for (int c = 0; c < Randoms.characters.length; c++) {
      String char = Randoms.characters[c];
      randomString = randomString.replaceAll(char, '');
    }
    expect(randomString, '');
  });
}
