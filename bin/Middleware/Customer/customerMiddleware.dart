// ignore_for_file: file_names

import 'package:shelf/shelf.dart';

Middleware checkCustomer() => (innerHandler) => (Request req) {
      final header = req.headers;

      if (header['User-Type'] != 'customer') {
        return Response.unauthorized('Unauthorized!');
      }

      return innerHandler(req);
    };