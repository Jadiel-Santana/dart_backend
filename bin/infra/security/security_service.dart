import 'package:shelf/shelf.dart';

abstract class SecurityService<T> {
  Future<String> generateJWT({required String userId});

  Future<T?> validateJWT({required String token});

  Middleware get authorization;

  Middleware get verifyJWT;
}
