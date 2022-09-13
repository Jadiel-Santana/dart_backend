import 'package:shelf/shelf.dart';

import '../../infra/infra.dart';

abstract class Api {
  Handler getHandler({List<Middleware>? middlewares, bool isSecurity});

  Handler createHandler({
    required Handler router,
    List<Middleware>? middlewares,
    bool isSecurity = false,
  }) {
    middlewares ??= [];

    if (isSecurity) {
      final service = DependencyInjectorContainer().get<SecurityService>();
      middlewares.addAll([
        service.authorization,
        service.verifyJWT,
      ]);
    }

    Pipeline pipeline = Pipeline();
    for (var m in middlewares) {
      pipeline = pipeline.addMiddleware(m);
    }

    return pipeline.addHandler(router);
  }
}
