import 'package:drug_stores/configs/api_config.dart';
import 'package:drug_stores/controllers/items_list_controller.dart';
import 'package:drug_stores/models/drug.dart';
import 'package:drug_stores/screens/salesman/drug_list/components/drug_item.dart';

class SalesmanDrugListController extends ItemsListController<Drug> {
  SalesmanDrugListController()
      : super(
            indexUrl: ApiConfig.salesmanGetDrugs,
            itemBuilder: (context, index) => SalesmanDrugItem(index: index),
            plural: 'drugs');
}
