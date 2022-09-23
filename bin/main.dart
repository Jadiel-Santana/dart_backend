import 'package:shelf/shelf.dart';

import 'apis/apis.dart';
import 'infra/infra.dart';
import 'utils/utils.dart';

Future<void> main() async {
  CustomEnv.fromFile('.env-dev');

  final instance = Injects.initialize();

  final cascadeHandler = Cascade()
      .add(instance.get<LoginApi>().getHandler())
      .add(instance.get<NewsApi>().getHandler(isSecurity: true))
      .add(instance.get<UserApi>().getHandler(isSecurity: true))
      .handler;

  final handler = Pipeline()
      .addMiddleware(logRequests())
      .addMiddleware(MiddlewareInterceptor().middleware)
      .addHandler(cascadeHandler);

  await CustomServer().initialize(
    handler: handler,
    address: await CustomEnv.get<String>(key: 'server_address'),
    port: await CustomEnv.get<int>(key: 'server_port'),
  );
}
