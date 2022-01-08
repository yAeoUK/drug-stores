import 'package:drug_stores/configs/api_config.dart';
import 'package:drug_stores/controllers/items_list_controller.dart';
import 'package:drug_stores/screens/admin/order_list/components/order_item.dart';

class AdminOrdersListController extends ItemsListController {
  AdminOrdersListController()
      : super(
            itemBuilder: (context, index) => OrderItem(index: index),
            plural: 'orders',
            indexUrl: ApiConfig.adminGetOrders);
}
