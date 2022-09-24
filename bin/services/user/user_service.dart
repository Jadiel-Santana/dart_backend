import 'package:password_dart/password_dart.dart';

import '../../dao/dao.dart';
import '../../models/models.dart';
import '../services.dart';

class UserService implements GenericService<UserModel> {
  final UserDAO dao;

  const UserService({
    required this.dao,
  });

  @override
  Future<bool> delete({required int id}) async {
    return await dao.delete(id: id);
  }

  @override
  Future<List<UserModel>> findAll() async {
    return await dao.findAll();
  }

  @override
  Future<UserModel?> findOne({required int id}) async {
    return await dao.findOne(id: id);
  }

  @override
  Future<bool> save({required UserModel value}) async {
    if (value.id == null) {
      value.password = Password.hash(value.password!, PBKDF2());
      return await dao.create(value: value);
    } else {
      return await dao.update(value: value);
    }
  }

  Future<UserModel?> findByEmail({required String email}) async {
    return await dao.findByEmail(email: email);
  }
}
