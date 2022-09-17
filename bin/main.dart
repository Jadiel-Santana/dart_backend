import 'package:mysql1/mysql1.dart';
import 'package:shelf/shelf.dart';

import 'apis/apis.dart';
import 'infra/infra.dart';
import 'models/models.dart';
import 'utils/utils.dart';

Future<void> main() async {
  CustomEnv.fromFile('.env-dev');

  final instance = Injects.initialize();

  final connection = await instance.get<DBConfig>().connection;

  final resultUsers = await connection.query('SELECT * FROM usuarios');
  final resultNews = await connection.query('SELECT * FROM noticias');

  for(ResultRow r in resultUsers) {
    final user = UserModel.fromMap(r.fields);
    print(user.toString());
  }
  print('------------------------------------');
  for(ResultRow r in resultNews) {
    print(r.fields);
  }
  print('------------------------------------');


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
