abstract class GenericService<T> {
  Future<T?> findOne({required int id});
  Future<List<T>> findAll();
  Future<bool> save({required T value});
  Future<bool> delete({required int id});
}
