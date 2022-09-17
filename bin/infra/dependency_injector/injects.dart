import '../../apis/apis.dart';
import '../../dao/dao.dart';
import '../../models/models.dart';
import '../../services/services.dart';
import '../infra.dart';

class Injects {
  static DependencyInjectorContainer initialize() {
    final instance = DependencyInjectorContainer();

    instance.register<DBConfig>(() => MySqlDBConfig());

    instance.register<SecurityService>(() => SecurityServiceImp());

    instance.register<LoginApi>(
      () => LoginApi(service: instance<SecurityService>()),
    );

    instance.register<GenericService<NewsModel>>(() => NewsService());
    instance.register<BlogApi>(
      () => BlogApi(service: instance<GenericService<NewsModel>>()),
    );

    instance.register<CustomDAO<UserModel>>(
      () => UserDAO(dbConfig: instance<DBConfig>()),
    );
    instance.register<GenericService<UserModel>>(
      () => UserService(dao: instance<CustomDAO<UserModel>>()),
    );
    instance.register<UserApi>(
      () => UserApi(service: instance<GenericService<UserModel>>()),
    );

    return instance;
  }
}
