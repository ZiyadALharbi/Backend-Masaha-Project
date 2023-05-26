// ignore_for_file: file_names

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import '../Middleware/CheckToken_Middleware.dart';
import '../Middleware/Customer/customerMiddleware.dart';
import '../Response/Customer/displayProductResponse.dart';

class CustomerRoute {
  Handler get handler {
    final router = Router()..get('/display-type/<choosing-type>', displayProductResponse);

    final pipeline = Pipeline()
        .addMiddleware(checkTokenMiddleware())
        .addMiddleware(checkCustomer())
        .addHandler(router);

    return pipeline;
  }
}
