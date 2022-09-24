abstract class DBConfig {
  Future<dynamic> createConnection();

  Future<dynamic> get connection;

  Future<dynamic> executeSQL({required String sql, List? params});
}