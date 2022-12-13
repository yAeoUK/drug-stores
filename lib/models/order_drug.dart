import 'package:drug_stores/models/drug.dart';

class OrderDrug {
  Drug drug;
  int drugsCount;

  OrderDrug({required this.drug, required this.drugsCount});

  factory OrderDrug.fromMap(Map<String, dynamic> map) {
    return OrderDrug(
        drug: Drug.fromMap(map), drugsCount: int.parse(map['drugs_count']));
  }

  static List<OrderDrug> fromList(dynamic map) {
    List<OrderDrug> orderDrugs = [];
    List<dynamic> list = map;
    list.forEach((element) {
      orderDrugs.add(OrderDrug.fromMap(element));
    });
    return orderDrugs;
  }
}
