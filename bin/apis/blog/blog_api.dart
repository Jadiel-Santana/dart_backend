import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../../models/models.dart';
import '../../services/services.dart';

class BlogApi {
  final GenericService<NewsModel> service;

  const BlogApi({
    required this.service,
  });

  Handler get handler {
    final router = Router();

    router.get('/blog/noticias', (Request req) {
      List<NewsModel> news = service.findAll();
      List<Map> newsMap = news.map((e) => e.toMap()).toList();

      return Response.ok(jsonEncode(newsMap));
    });

    router.post('/blog/noticias', (Request req) async {
      var body = await req.readAsString();
      service.save(value: NewsModel.fromMap(jsonDecode(body)));
      return Response(201);
    });

    router.put('/blog/noticias', (Request req) {
      String? id = req.url.queryParameters['id'];
      // service.save(value: id);
      return Response.ok('Choveu hoje');
    });

    router.delete('/blog/noticias', (Request req) {
      String? id = req.url.queryParameters['id'];
      // service.delete(id: id);
      return Response.ok('Choveu hoje');
    });

    return router;
  }
}