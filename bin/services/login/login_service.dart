import 'package:password_dart/password_dart.dart';

import '../../to/to.dart';
import '../services.dart';

class LoginService {
  final UserService service;

  const LoginService({
    required this.service,
  });

  Future<int> authenticate({required AuthTO authTO}) async {
    try {
      final user = await service.findByEmail(email: authTO.email);
      if (user == null) {
        return -1;
      } else {
        return Password.verify(authTO.password, user.password!) ? user.id! : -1;
      }
    } catch (e) {
      print('[ERROR] -> in Authenticate method by email ${authTO.email}');
      return -1;
    }
  }
}
