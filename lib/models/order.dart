import 'package:drug_stores/abstracts/model_base.dart';

class Order implements ModelBase {
  int id;
  String salesmanName;
  int? drugsCount;

  Order({required this.id, required this.salesmanName, this.drugsCount});

  @override
  Map<String, dynamic> toMap() => {
        'id': this.id,
        'salesman_name': this.salesmanName,
        'drugs_count': this.drugsCount
      };

  factory Order.fromMap(Map<String, dynamic> map) => Order(
      id: int.parse(map['id']),
      salesmanName: map['salesman_name'],
      drugsCount: int.parse(map['drugs_count']));
}
