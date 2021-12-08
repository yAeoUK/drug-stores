import 'package:drug_stores/models/salesman.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  test('test generate function', () {
    expect(Salesman.generate(), isA<Salesman>());
  });
}
