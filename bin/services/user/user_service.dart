import '../../dao/dao.dart';
import '../../models/models.dart';
import '../services.dart';

class UserService implements GenericService<UserModel> {
  final CustomDAO<UserModel> dao;

  UserService({
    required this.dao,
  });

  @override
  Future<bool> delete({required int id}) async {
    return dao.delete(id: id);
  }

  @override
  Future<List<UserModel>> findAll() async {
    return dao.findAll();
  }

  @override
  Future<UserModel?> findOne({required int id}) async {
    return dao.findOne(id: id);
  }

  @override
  Future<bool> save({required UserModel value}) async {
    return (value.id == null)
        ? dao.create(value: value)
        : dao.update(value: value);
  }
}
