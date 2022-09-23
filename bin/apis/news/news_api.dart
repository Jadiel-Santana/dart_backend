import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../../models/models.dart';
import '../../services/services.dart';
import '../apis.dart';

class NewsApi extends Api {
  final GenericService<NewsModel> service;

  NewsApi({
    required this.service,
  });

  @override
  Handler getHandler({List<Middleware>? middlewares, bool isSecurity = false}) {
    final router = Router();

    router.get('/blog/news', (Request req) async {
      List<NewsModel> news = await service.findAll();
      List<Map> newsMap = news.map((e) => e.toMap()).toList();

      return Response.ok(jsonEncode(newsMap));
    });

    router.post('/blog/news', (Request req) async {
      var body = await req.readAsString();
      service.save(value: NewsModel.fromMap(jsonDecode(body)));
      return Response(201);
    });

    router.put('/blog/news', (Request req) {
      String? id = req.url.queryParameters['id'];
      // service.save(value: id);
      return Response.ok('Choveu hoje');
    });

    router.delete('/blog/news', (Request req) {
      String? id = req.url.queryParameters['id'];
      // service.delete(id: id);
      return Response.ok('Choveu hoje');
    });

    return createHandler(
      router: router,
      middlewares: middlewares,
      isSecurity: isSecurity,
    );
  }
}
