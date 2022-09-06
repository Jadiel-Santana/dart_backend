import 'package:shelf/shelf.dart';

import 'apis/apis.dart';
import 'infra/infra.dart';
import 'services/services.dart';
import 'utils/utils.dart';

Future<void> main() async {
  CustomEnv.fromFile('.env-dev');
  final service = SecurityServiceImp();

  final cascadeHandler = Cascade()
      .add(LoginApi(service: service).handler)
      .add(BlogApi(service: NewsService()).handler)
      .handler;

  final handler = Pipeline()
      .addMiddleware(logRequests())
      .addMiddleware(MiddlewareInterceptor().middleware)
      .addMiddleware(service.authorization)
      .addMiddleware(service.verifyJWT)
      .addHandler(cascadeHandler);

  await CustomServer().initialize(
    handler: handler,
    address: await CustomEnv.get<String>(key: 'server_address'),
    port: await CustomEnv.get<int>(key: 'server_port'),
  );
}
