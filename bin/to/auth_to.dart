import 'dart:convert';

class AuthTO {
  final String email;
  final String password;

  const AuthTO({
    required this.email,
    required this.password,
  });

  factory AuthTO.fromRequest({required String body}) {
    final map = jsonDecode(body);
    return AuthTO(
      email: map['email'],
      password: map['password'],
    );
  }
}
