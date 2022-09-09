import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:shelf/shelf.dart';

import '../../utils/utils.dart';
import 'security.dart';

class SecurityServiceImp implements SecurityService<JWT> {
  @override
  Future<String> generateJWT({required String userId}) async {
    final jwt = JWT({
      'iat': DateTime.now().millisecondsSinceEpoch,
      'userID': userId,
      'roles': ['admin', 'user'],
    });

    String key = await CustomEnv.get(key: 'jwt_key');
    return jwt.sign(SecretKey(key));
  }

  @override
  Future<JWT?> validateJWT({required String token}) async {
    try {
      String key = await CustomEnv.get(key: 'jwt_key');
      return JWT.verify(token, SecretKey(key));
    } on JWTInvalidError {
      return null;
    } on JWTExpiredError {
      return null;
    } on JWTNotActiveError {
      return null;
    } on JWTUndefinedError {
      return null;
    } catch (e) {
      return null;
    }
  }

  @override
  Middleware get authorization {
    return (Handler handler) {
      return (Request req) async {
        String? authorizationHeader = req.headers['Authorization'];
        JWT? jwt;

        if(authorizationHeader != null && authorizationHeader.startsWith('Bearer ')) {
          String token = authorizationHeader.substring(7);
          jwt = await validateJWT(token: token);
        }
        final request = req.change(context: {'jwt': jwt});

        return handler(request);
      };
    };
  }

  @override
  Middleware get verifyJWT => createMiddleware(
    requestHandler: (Request req) {
      if(req.context['jwt'] == null) {
        return Response.forbidden('Not authorized');
      }
      return null;
    },
  );
}
