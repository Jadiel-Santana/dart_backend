import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../../models/models.dart';
import '../../services/services.dart';
import '../apis.dart';

class UserApi extends Api {
  final GenericService<UserModel> service;

  UserApi({
    required this.service,
  });

  @override
  Handler getHandler({List<Middleware>? middlewares, bool isSecurity = false}) {
    final router = Router();

    router.post('/users', (Request req) async {
      final body = await req.readAsString();
      if(body.isEmpty) {
        return Response(400);
      }
      final result = await service.save(value: UserModel.fromRequest(jsonDecode(body)));
      return (result) ? Response(201) : Response(500);
    });

    // router.get('/news/noticias', (Request req) async {
    //   List<NewsModel> news = await service.findAll();
    //   List<Map> newsMap = news.map((e) => e.toMap()).toList();
    //
    //   return Response.ok(jsonEncode(newsMap));
    // });
    //
    // router.put('/news/noticias', (Request req) {
    //   String? id = req.url.queryParameters['id'];
    //   // service.save(value: id);
    //   return Response.ok('Choveu hoje');
    // });
    //
    // router.delete('/news/noticias', (Request req) {
    //   String? id = req.url.queryParameters['id'];
    //   // service.delete(id: id);
    //   return Response.ok('Choveu hoje');
    // });

    return createHandler(
      router: router,
      middlewares: middlewares,
      isSecurity: isSecurity,
    );
  }
}
