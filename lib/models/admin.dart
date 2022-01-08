import 'package:drug_stores/helper/random.dart';

class Admin {
  int id;

  Admin({required this.id});

  static Admin generate() => Admin(id: Randoms.getRandomInt());
}
