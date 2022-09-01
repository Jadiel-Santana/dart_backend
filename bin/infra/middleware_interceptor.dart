import 'package:shelf/shelf.dart';

class MiddlewareInterceptor {
  Middleware get middleware => createMiddleware(
    responseHandler: (Response res) => res.change(
      headers: {
        'content-type': 'application/json',
      },
    ),
  );
}
