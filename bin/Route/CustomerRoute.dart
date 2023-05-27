// ignore_for_file: file_names

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import '../Middleware/CheckToken_Middleware.dart';
import '../Middleware/Customer/customerMiddleware.dart';
import '../Response/Customer/cancelReservationCustomerResponse.dart';
import '../Response/Customer/chooseProductResponse.dart';
import '../Response/Customer/displayCustomerReservationsResponse.dart';
import '../Response/Customer/displayProductResponse.dart';
import '../Response/Customer/displayProductTypesResponse.dart';

class CustomerRoute {
  Handler get handler {
    final router = Router()
      ..get('/display-product/<choosing-type>', displayProductResponse)
      ..post("/choose-product", chooseProductResponse)
      ..get("/display-type", displayProductTypesResponse)
      ..get("/display-customer-reservations", displayCustomerReservationsResponse)
      ..delete("/cancel-reservations", cancelReservationCustomerResponse );

    final pipeline = Pipeline()
        .addMiddleware(checkTokenMiddleware())
        .addMiddleware(checkCustomer())
        .addHandler(router);

    return pipeline;
  }
}
