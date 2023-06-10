import 'package:drug_stores/abstracts/model_base.dart';
import 'package:drug_stores/helper/random.dart';

class Pharmacy implements ModelBase {
  int? id;
  String? name;

  Pharmacy({
    this.id,
    this.name,
  });

  factory Pharmacy.fromMap(Map<String, dynamic> map) {
    return new Pharmacy(
      id: int.parse(map['id']),
      name: map['name'] as String?,
    );
  }

  static List<Pharmacy> fromList(dynamic map) {
    List<Pharmacy> pharmacies = [];
    List<dynamic> list = map;
    list.forEach((element) {
      pharmacies.add(Pharmacy.fromMap(element));
    });
    return pharmacies;
  }

  static Pharmacy generate() {
    return Pharmacy(
      id: Randoms.getRandomInt(),
      name: Randoms.getRandomString(),
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'name': this.name,
    };
  }
}
