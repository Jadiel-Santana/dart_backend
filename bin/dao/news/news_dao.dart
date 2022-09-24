import '../../infra/infra.dart';
import '../../models/models.dart';
import '../dao.dart';

class NewsDAO implements CustomDAO<NewsModel> {
  final DBConfig dbConfig;

  const NewsDAO({
    required this.dbConfig,
  });

  @override
  Future<bool> create({required NewsModel value}) async {
    final result = await dbConfig.executeSQL(
      sql: 'INSERT INTO noticias (titulo, descricao, id_usuario) VALUES (?, ?, ?)',
      params: [value.title, value.description, value.userId],
    );
    return result.affectedRows > 0;
  }

  @override
  Future<bool> delete({required int id}) async {
    final result = await dbConfig.executeSQL(
      sql: 'DELETE FROM noticias WHERE id = ?',
      params: [id],
    );
    return result.affectedRows > 0;
  }

  @override
  Future<List<NewsModel>> findAll() async {
    final result = await dbConfig.executeSQL(sql: 'SELECT * FROM noticias');
    return result
        .map((r) => NewsModel.fromMap(r.fields))
        .toList()
        .cast<NewsModel>();
  }

  @override
  Future<NewsModel?> findOne({required int id}) async {
    final result = await dbConfig.executeSQL(
      sql: 'SELECT * FROM noticias WHERE id = ?',
      params: [id],
    );
    return (result.isEmpty)
        ? null
        : NewsModel.fromMap(result.first.fields);
  }

  @override
  Future<bool> update({required NewsModel value}) async {
    final result = await dbConfig.executeSQL(
      sql: 'UPDATE noticias SET titulo = ?, descricao = ? WHERE id = ?',
      params: [value.title, value.description, value.id],
    );
    return result.affectedRows > 0;
  }
}
