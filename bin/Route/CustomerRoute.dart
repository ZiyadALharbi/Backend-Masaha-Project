// ignore_for_file: file_names

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import '../Middleware/CheckToken_Middleware.dart';
import '../Middleware/Customer/customerMiddleware.dart';
import '../Response/Customer/addToBookmarkResponse.dart';
import '../Response/Customer/cancelReservationCustomerResponse.dart';
import '../Response/Customer/chooseProductResponse.dart';
import '../Response/Customer/displayBookmarkResponse.dart';
import '../Response/Customer/displayCustomerReservationsResponse.dart';
import '../Response/Customer/displayProductResponse.dart';
import '../Response/Customer/displayProductTypesResponse.dart';
// import '../Response/Customer/displayProfileResponse.dart';
import '../Response/Customer/removeFromBookmarkResponse.dart';

class CustomerRoute {
  Handler get handler {
    final router = Router()
      ..get('/display-product/<choosing-type>', displayProductResponse)
      ..get('/display-bookmark', displayBookmarkResponse)
      // ..get('/display-profile', displayProfileResponse)
      ..post("/choose-product", chooseProductResponse)
      ..post("/add-to-bookmark", addToBookmarktResponse)
      ..get("/display-type", displayProductTypesResponse)
      ..get("/display-customer-reservations", displayCustomerReservationsResponse)
      ..delete("/cancel-reservations", cancelReservationCustomerResponse )
      ..delete("/remove-from-bookmark", removeFromBookmarkResponse );

    final pipeline = Pipeline()
        .addMiddleware(checkTokenMiddleware())
        .addMiddleware(checkCustomer())
        .addHandler(router);

    return pipeline;
  }
}
