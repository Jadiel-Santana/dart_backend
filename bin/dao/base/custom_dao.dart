abstract class CustomDAO<T> {
  Future<bool> create({required T value});
  Future<T?> findOne({required int id});
  Future<List<T>> findAll();
  Future<bool> update({required T value});
  Future<bool> delete({required int id});
}
