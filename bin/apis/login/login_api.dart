import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../../infra/infra.dart';
import '../../services/services.dart';
import '../../to/to.dart';
import '../apis.dart';

class LoginApi extends Api {
  final SecurityService securityService;
  final LoginService loginService;

  LoginApi({
    required this.securityService,
    required this.loginService,
  });

  @override
  Handler getHandler({List<Middleware>? middlewares, bool isSecurity = false}) {
    final router = Router();

    router.post('/login', (Request req) async {
      final body = await req.readAsString();
      final authTO = AuthTO.fromRequest(body: body);

      final userID = await loginService.authenticate(authTO: authTO);

      if (userID > 0) {
        final token = await securityService.generateJWT(userId: userID.toString());
        return Response.ok(jsonEncode({'token': token}));
      } else {
        return Response(401);
      }
    });

    return createHandler(
      router: router,
      middlewares: middlewares,
      isSecurity: isSecurity,
    );
  }
}
