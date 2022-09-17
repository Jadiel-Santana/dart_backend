import 'package:mysql1/mysql1.dart';

import '../../utils/utils.dart';
import 'database.dart';

class MySqlDBConfig implements DBConfig {
  MySqlConnection? _connection;

  @override
  Future<MySqlConnection> get connection async {
    return _connection ??= await createConnection();
  }

  @override
  Future<MySqlConnection> createConnection() async {
    return await MySqlConnection.connect(
      ConnectionSettings(
        host: await CustomEnv.get<String>(key: 'db_host'),
        port: await CustomEnv.get<int>(key: 'db_port'),
        user: await CustomEnv.get<String>(key: 'db_user'),
        password: await CustomEnv.get<String>(key: 'db_pass'),
        db: await CustomEnv.get<String>(key: 'db_schema'),
      ),
    );
  }
}
