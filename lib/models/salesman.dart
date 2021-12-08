import 'package:drug_stores/helper/random.dart';

class Salesman {
  late int? id;

  Salesman({this.id});

  static Salesman generate() => Salesman(id: Randoms.getRandomInt());
}
