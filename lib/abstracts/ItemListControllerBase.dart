abstract class ItemListControllerBase {
  Future? loadData(int offset);

  Future? deleteItem(int id);
}
