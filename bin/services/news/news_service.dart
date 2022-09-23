import '../../models/models.dart';
import '../../utils/utils.dart';
import '../services.dart';

class NewsService implements GenericService<NewsModel> {
  final List<NewsModel> _listMock = [];

  @override
  Future<bool> delete({required int id}) async {
    _listMock.removeWhere((element) => element.id == id);
    return true;
  }

  @override
  Future<List<NewsModel>> findAll() async {
    return _listMock;
  }

  @override
  Future<NewsModel?> findOne({required int id}) async {
    return _listMock.firstWhere((element) => element.id == id);
  }

  @override
  Future<bool> save({required NewsModel value}) async {
    NewsModel? model = _listMock.firstWhereOrNull((e) => e.id == value.id);
    if (model == null) {
      _listMock.add(value);
    } else {
      var index = _listMock.indexOf(model);
      _listMock[index] = value;
    }

    return true;
  }
}