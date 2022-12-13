import 'package:drug_stores/abstracts/model_base.dart';
import 'package:drug_stores/helper/random.dart';

class DrugStore implements ModelBase {
  int? id;
  String? name;

  DrugStore({this.id, this.name});

  factory DrugStore.fromMap(Map<String, dynamic> map) {
    return new DrugStore(
      id: int.parse(map['id']),
      name: map['name'] as String?,
    );
  }

  static List<DrugStore> fromList(dynamic map) {
    List<DrugStore> drugStores = [];
    List<dynamic> list = map;
    list.forEach((element) {
      drugStores.add(DrugStore.fromMap(element));
    });
    return drugStores;
  }

  static DrugStore generate() {
    return DrugStore(
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
