import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../Middleware/CheckToken_Middleware.dart';
import '../Middleware/Owner/ownerMiddleware.dart';
import '../Response/Owner/addProductImageResponse.dart';
import '../Response/Owner/addProductResponse.dart';

class OwnerRoute {
  Handler get handler {
    final router = Router()
    ..post("/add-product", addProductResponse)
    ..post("/add-product-image/<type>", addProductImageResponse);

    final pipeline =
        Pipeline().addMiddleware(checkTokenMiddleware()).addMiddleware(checkOwner()).addHandler(router);

    return pipeline;
  }
}