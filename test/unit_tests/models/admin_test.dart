import 'package:drug_stores/models/admin.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  test('test generate function', () {
    expect(Admin.generate(), isA<Admin>());
  });
}
