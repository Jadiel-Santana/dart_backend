import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../../services/services.dart';

class BlogApi {
  final GenericService service;

  const BlogApi({
    required this.service,
  });

  Handler get handler {
    final router = Router();

    router.get('/blog/noticias', (Request req) {
      // service.findAll();
      return Response.ok('Choveu hoje');
    });

    router.post('/blog/noticias', (Request req) {
      // service.save(value: null);
      return Response.ok('Choveu hoje');
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