abstract class ItemListControllerBase<T> {
  Future? loadData({int offset = 0, bool refresh = false});

  Future? deleteItem(int id);

  Future? addItem(T item);

  Future? editItem(T item);
}
