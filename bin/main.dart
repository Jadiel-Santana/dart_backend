import 'package:mysql1/mysql1.dart';
import 'package:shelf/shelf.dart';

import 'apis/apis.dart';
import 'dao/dao.dart';
import 'infra/infra.dart';
import 'models/models.dart';
import 'utils/utils.dart';

Future<void> main() async {
  CustomEnv.fromFile('.env-dev');

  final instance = Injects.initialize();

  final user = UserModel()
    ..id = 6
    ..name = 'XPTO'
    ..email = 'xpto@email.com'
    ..password = '123';

  UserDAO dao = UserDAO(dbConfig: instance.get<DBConfig>());
  (await dao.findAll()).forEach(print);
  print(await dao.findOne(id: 1));
  print(await dao.create(value: user));
  (await dao.findAll()).forEach(print);
  user.name = 'XPTO ATUALIZADO';
  print(await dao.update(value: user));
  (await dao.findAll()).forEach(print);
  print(await dao.delete(id: user.id!));
  (await dao.findAll()).forEach(print);

  final cascadeHandler = Cascade()
      .add(instance.get<LoginApi>().getHandler())
      .add(instance.get<BlogApi>().getHandler(isSecurity: true))
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
