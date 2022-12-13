import 'package:drug_stores/abstracts/model_base.dart';

class Order implements ModelBase {
  int id;
  String? salesmanName;
  String? drugStoreName;
  int? salesmanId;
  int? drugStoreId;
  int? drugsCount;

  Order(
      {required this.id,
      this.salesmanName,
      this.drugStoreName,
      this.salesmanId,
      this.drugStoreId,
      this.drugsCount});

  @override
  Map<String, dynamic> toMap() => {
        'id': this.id,
        'salesman_name': this.salesmanName,
        'drug_store_name': this.drugStoreName,
        'salesman_id': this.salesmanId,
        'drug_store_id': this.drugStoreId,
        'drugs_count': this.drugsCount
      };

  factory Order.fromMap(Map<String, dynamic> map) => Order(
        id: int.parse(map['id']),
        salesmanName: map['salesman_name'],
        drugStoreName: map['drug_store_name'],
        salesmanId: int.parse(map['salesman_id']),
        drugStoreId: int.parse(map['drug_store_id']),
        drugsCount: int.parse(map['drugs_count']),
      );
}
