import 'package:shelf/shelf.dart';

Middleware checkOwner() => (innerHandler) => (Request req) {
      final header = req.headers;

      if (header['User-Type'] != 'owner') {
        return Response.unauthorized('Unauthorized!');
      }

      return innerHandler(req);
    };