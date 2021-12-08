import 'dart:math';

class Randoms {
  static const characters =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz';
  static const int _maximumInt = 4294967296;
  static const int acceptedInt = 7992;

  static String getRandomString({int length = acceptedInt}) {
    Random r = Random();
    return String.fromCharCodes(Iterable.generate(
        length, (_) => characters.codeUnitAt(r.nextInt(characters.length))));
  }

  static int getRandomInt({int max = _maximumInt}) {
    Random r = Random();
    return r.nextInt(max);
  }
}
