import 'package:drug_stores/abstracts/model_base.dart';
import 'package:drug_stores/models/salesman.dart';

class Order implements ModelBase {
  int id;
  Salesman salesman;
  int? drugsCount;

  Order({required this.id, required this.salesman, this.drugsCount});

  @override
  Map<String, dynamic> toMap() => {
        'id': this.id,
        'salesman': this.salesman,
        'drugs_count': this.drugsCount
      };

  factory Order.fromMap(Map<String, dynamic> map) => Order(
      id: int.parse(map['id']),
      salesman: Salesman.fromMap(map['salesman']),
      drugsCount: int.parse(map['drugs_count']));
}
