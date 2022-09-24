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

    router.get('/news', (Request req) async {
      String? id = req.url.queryParameters['id'];
      if(id == null) {
        return Response(400);
      }
      final news = await service.findOne(id: int.parse(id));
      if(news == null) {
        return Response(400);
      }
      return Response.ok(jsonEncode(news.toMap()));
    });

    router.get('/news/all', (Request req) async {
      List<NewsModel> news = await service.findAll();
      List<Map> newsMap = news.map((e) => e.toMap()).toList();

      return Response.ok(jsonEncode(newsMap));
    });

    router.post('/news', (Request req) async {
      final body = await req.readAsString();
      final result = await service.save(value: NewsModel.fromRequest(jsonDecode(body)));
      return result ? Response(201) : Response(500);
    });

    router.put('/news', (Request req) async {
      final body = await req.readAsString();
      final result = await service.save(value: NewsModel.fromRequest(jsonDecode(body)));
      return result ? Response(200) : Response(500);
    });

    router.delete('/news', (Request req) async {
      String? id = req.url.queryParameters['id'];
      if(id == null) {
        return Response(400);
      }
      final result = await service.delete(id: int.parse(id));
      return result ? Response(200) : Response(500);
    });

    return createHandler(
      router: router,
      middlewares: middlewares,
      isSecurity: isSecurity,
    );
  }
}
