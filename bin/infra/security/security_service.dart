abstract class SecurityService<T> {
  Future<String> generateJWT({required String userId});

  Future<T?> validateJWT({required String token});
}
