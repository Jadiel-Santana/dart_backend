import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../../infra/infra.dart';

class LoginApi {
  final SecurityService service;

  LoginApi({
    required this.service,
  });

  Handler get handler {
    final router = Router();

    router.post('/login', (Request req) async {
      final token = await service.generateJWT(userId: '1');
      final result = await service.validateJWT(token: token);
      return Response.ok((result != null).toString());
    });

    return router;
  }
}
