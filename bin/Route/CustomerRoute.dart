import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../Middleware/CheckToken_Middleware.dart';
import '../Middleware/Customer/customerMiddleware.dart';

class CustomerRoute {
  Handler get handler {
    final router = Router();

    final pipeline =
        Pipeline().addMiddleware(checkTokenMiddleware()).addMiddleware(checkCustomer()).addHandler(router);

    return pipeline;
  }
}