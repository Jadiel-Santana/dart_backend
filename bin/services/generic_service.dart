abstract class GenericService<T> {
  T findOne({required int id});
  List<T> findAll();
  bool save({required T value});
  bool delete({required int id});
}
