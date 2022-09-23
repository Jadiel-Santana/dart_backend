import '../infra/infra.dart';
import '../models/models.dart';
import '../dao/dao.dart';

class UserDAO implements CustomDAO<UserModel> {
  final DBConfig dbConfig;

  const UserDAO({
    required this.dbConfig,
  });

  @override
  Future<bool> create({required UserModel value}) async {
    final result = await _executeSQL(
      sql: 'INSERT INTO usuarios (nome, email, senha) VALUES (?, ?, ?)',
      params: [value.name, value.email, value.password],
    );
    return result.affectedRows > 0;
  }

  @override
  Future<bool> delete({required int id}) async {
    final result = await _executeSQL(
      sql: 'DELETE FROM usuarios WHERE id = ?',
      params: [id],
    );
    return result.affectedRows > 0;
  }

  @override
  Future<List<UserModel>> findAll() async {
    final result = await _executeSQL(sql: 'SELECT * FROM usuarios');
    return result
        .map((r) => UserModel.fromMap(r.fields))
        .toList()
        .cast<UserModel>();
  }

  @override
  Future<UserModel?> findOne({required int id}) async {
    final result = await _executeSQL(
      sql: 'SELECT * FROM usuarios WHERE id = ?',
      params: [id],
    );
    return (result.affectedRows == 0)
        ? null
        : UserModel.fromMap(result.first.fields);
  }

  @override
  Future<bool> update({required UserModel value}) async {
    final result = await _executeSQL(
      sql: 'UPDATE usuarios SET nome = ?, senha = ? WHERE id = ?',
      params: [value.name, value.password, value.id],
    );
    return result.affectedRows > 0;
  }

  Future<UserModel?> findByEmail({required String email}) async {
    final result = await _executeSQL(
      sql: 'SELECT * FROM usuarios WHERE email = ?',
      params: [email],
    );
    return (result.affectedRows == 0)
        ? null
        : UserModel.fromEmail(result.first.fields);
  }

  Future _executeSQL({required String sql, List? params}) async {
    final connection = await dbConfig.connection;
    return await connection.query(sql, params);
  }
}
