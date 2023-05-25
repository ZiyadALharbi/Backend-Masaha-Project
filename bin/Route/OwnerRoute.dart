import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../Middleware/CheckToken_Middleware.dart';
import '../Middleware/Owner/ownerMiddleware.dart';

class OwnerRoute {
  Handler get handler {
    final router = Router();

    final pipeline =
        Pipeline().addMiddleware(checkTokenMiddleware()).addMiddleware(checkOwner()).addHandler(router);

    return pipeline;
  }
}