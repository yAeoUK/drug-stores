abstract class ItemListControllerBase<T> {
  Future? loadData({int offset = 0, bool refresh = false});

  void deleteItem(int id);

  void addItem(T item);

  void editItem(T item);
}
