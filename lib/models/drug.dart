import 'package:drug_stores/helper/random.dart';

class Drug {
  int id;
  String? name;
  int? quantity;

  Drug({required this.id, this.name, this.quantity});

  factory Drug.fromMap(Map<String, dynamic> map) {
    return new Drug(
      id: map['id'] as int,
      name: map['name'] as String?,
      quantity: map['quantity'] as int?,
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

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'name': this.name,
      'quantity': this.quantity,
    };
  }

  static Drug generate() {
    return Drug(
        id: Randoms.getRandomInt(),
        name: Randoms.getRandomString(),
        quantity: Randoms.getRandomInt());
  }
}
