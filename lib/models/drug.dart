import 'package:drug_stores/abstracts/model_base.dart';
import 'package:drug_stores/helper/random.dart';

class Drug implements ModelBase {
  int? id;
  String? name;
  int? quantity;

  Drug({this.id, this.name, this.quantity});

  factory Drug.fromMap(Map<String, dynamic> map) {
    return new Drug(
      id: int.parse(map['id']),
      name: map['name'] as String?,
      quantity: int.parse(map['quantity']),
    );
  }

  static List<Drug> fromList(dynamic map) {
    List<Drug> drugs = [];
    List<dynamic> list = map;
    list.forEach((element) {
      drugs.add(Drug.fromMap(element));
    });
    return drugs;
  }

  static Drug generate() {
    return Drug(
        id: Randoms.getRandomInt(),
        name: Randoms.getRandomString(),
        quantity: Randoms.getRandomInt());
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'name': this.name,
      'quantity': this.quantity,
    };
  }
}
