typedef InstanceCreator<T> = T Function();

class DependencyInjectorContainer {
  DependencyInjectorContainer._();

  static final _singleton = DependencyInjectorContainer._();

  factory DependencyInjectorContainer() => _singleton;

  final _instanceMap = <Type, _InstanceGenerator<Object>>{};

  void register<T extends Object>(
    InstanceCreator<T> instance, {
    bool isSingleton = false,
  }) {
    _instanceMap[T] = _InstanceGenerator(
      instanceGenerator: instance,
      isSingleton: isSingleton,
    );
  }

  T get<T extends Object>() {
    final instance = _instanceMap[T]?.getInstance();

    if (instance != null && instance is T) {
      return instance;
    }
    throw Exception('[ERROR -> Instance ${T.toString()} not found]');
  }
}

class _InstanceGenerator<T> {
  T? _instance;
  bool _isFirstGet = false;

  final InstanceCreator<T> instanceGenerator;

  _InstanceGenerator({
    required this.instanceGenerator,
    required bool isSingleton,
  }) : _isFirstGet = isSingleton;

  T? getInstance() {
    if (_isFirstGet) {
      _instance = instanceGenerator();
      _isFirstGet = false;
    }
    return _instance ?? instanceGenerator();
  }
}
