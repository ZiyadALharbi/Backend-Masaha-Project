// ignore_for_file: file_names

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import '../Middleware/CheckToken_Middleware.dart';
import '../Middleware/Customer/customerMiddleware.dart';
<<<<<<< HEAD
import '../Response/Customer/displayProductResponse.dart';

class CustomerRoute {
  Handler get handler {
    final router = Router()..get('/display-type/<choosing-type>', displayProductResponse);
=======
import '../Response/Customer/displayPrTypesResponse.dart';

class CustomerRoute {
  Handler get handler {
    final router = Router()..get('/product-type', displayPrTypesResponse);
>>>>>>> 380537d9ec31972e6d8a3692a592578032f11bb8

    final pipeline = Pipeline()
        .addMiddleware(checkTokenMiddleware())
        .addMiddleware(checkCustomer())
        .addHandler(router);

    return pipeline;
  }
}
