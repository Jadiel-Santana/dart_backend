import '../../apis/apis.dart';
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

    return instance;
  }
}
