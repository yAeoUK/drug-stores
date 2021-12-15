import 'package:drug_stores/models/drug.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  test('test generate function', () {
    expect(Drug.generate(), isA<Drug>());
  });
}
