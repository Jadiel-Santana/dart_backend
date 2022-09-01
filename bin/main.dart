import 'package:shelf/shelf.dart';

import 'apis/apis.dart';
import 'infra/infra.dart';
import 'services/services.dart';
import 'utils/utils.dart';

Future<void> main() async {
  CustomEnv.fromFile('.env-dev');

  final cascadeHandler =
      Cascade().add(BlogApi(service: NewsService()).handler).handler;

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
