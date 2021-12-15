import 'package:drug_stores/controllers/items_list_controller.dart';

class AdminDrugsListController extends ItemsListController{
  AdminDrugsListController(Future initialFetch) : super(initialFetch);
  // Network(
  // onConnectionSucceed: (body) =>
  // adminDrugsListController!.items = Drug.fromList(body['drugs']),
  // onMessageReceived: (failureResponse) =>
  // adminDrugsListController!.message(failureResponse.content),
  // onConnectionFailed: () => adminDrugsListController!
  //     .message(LanguageConfig.formNoConnection.tr())).post(
  // url: ApiConfig.adminGetDrugs,
  // body: {'limit': AppConfig.listItemsInitialCount, 'offset': 0})
}