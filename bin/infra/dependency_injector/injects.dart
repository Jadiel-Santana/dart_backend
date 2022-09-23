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

    instance.register<GenericService<NewsModel>>(() => NewsService());
    instance.register<NewsApi>(
      () => NewsApi(service: instance<GenericService<NewsModel>>()),
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

    instance.register<LoginService>(
      () => LoginService(service: instance<GenericService<UserModel>>()),
    );
    instance.register<LoginApi>(
      () => LoginApi(
        securityService: instance<SecurityService>(),
        loginService: instance<LoginService>(),
      ),
    );
    return instance;
  }
}
