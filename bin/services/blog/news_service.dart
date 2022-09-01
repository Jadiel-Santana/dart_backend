import '../../models/models.dart';
import '../../utils/utils.dart';
import '../services.dart';

class NewsService implements GenericService<NewsModel> {
  final List<NewsModel> _listMock = [];

  @override
  bool delete({required int id}) {
    _listMock.removeWhere((element) => element.id == id);
    return true;
  }

  @override
  List<NewsModel> findAll() {
    return _listMock;
  }

  @override
  NewsModel findOne({required int id}) {
    return _listMock.firstWhere((element) => element.id == id);
  }

  @override
  bool save({required NewsModel value}) {
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