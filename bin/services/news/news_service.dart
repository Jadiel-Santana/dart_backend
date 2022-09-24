import '../../dao/news/news_dao.dart';
import '../../models/models.dart';
import '../services.dart';

class NewsService implements GenericService<NewsModel> {
  final NewsDAO dao;

  const NewsService({
    required this.dao,
  });

  @override
  Future<bool> delete({required int id}) async {
    return await dao.delete(id: id);
  }

  @override
  Future<List<NewsModel>> findAll() async {
    return await dao.findAll();
  }

  @override
  Future<NewsModel?> findOne({required int id}) async {
    return await dao.findOne(id: id);
  }

  @override
  Future<bool> save({required NewsModel value}) async {
    if (value.id == null) {
      return await dao.create(value: value);
    } else {
      return await dao.update(value: value);
    }
  }
}
