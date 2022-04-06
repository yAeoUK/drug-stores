import 'package:drug_stores/models/drug.dart';

class OrderDrug {
  Drug drug;
  int quantity;

  OrderDrug({required this.drug, required this.quantity});

  factory OrderDrug.fromMap(Map<String, dynamic> map) {
    return OrderDrug(
        drug: Drug.fromMap(map['drug']), quantity: map['quantity'] as int);
  }
}
