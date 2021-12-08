import 'package:drug_stores/helper/random.dart';

class Admin {
  late int? id;

  Admin({this.id});

  static Admin generate() => Admin(id: Randoms.getRandomInt());
}
