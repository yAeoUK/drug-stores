import 'package:drug_stores/abstracts/model_base.dart';
import 'package:drug_stores/helper/random.dart';

class Salesman implements ModelBase {
  int id;
  String name;

  Salesman({required this.id, required this.name});

  static Salesman generate() =>
      Salesman(id: Randoms.getRandomInt(), name: Randoms.getRandomString());

  @override
  Map<String, dynamic> toMap() => {'id': this.id, 'name': this.name};

  factory Salesman.fromMap(Map<String, dynamic> map) =>
      Salesman(id: int.parse(map['id']), name: map['name']);
}
