import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../../infra/infra.dart';
import '../apis.dart';

class LoginApi extends Api {
  final SecurityService service;

  LoginApi({
    required this.service,
  });

  @override
  Handler getHandler({List<Middleware>? middlewares}) {
    final router = Router();

    router.post('/login', (Request req) async {
      final token = await service.generateJWT(userId: '1');
      final result = await service.validateJWT(token: token);
      return Response.ok((result != null).toString());
    });

    return createHandler(router: router, middlewares: middlewares);
  }
}
