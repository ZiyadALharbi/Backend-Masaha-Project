// ignore_for_file: file_names

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import '../Middleware/CheckToken_Middleware.dart';
import '../Middleware/Customer/customerMiddleware.dart';
import '../Response/Customer/add_To_Bookmark_Response.dart';
import '../Response/Customer/cancel_Reservation_Customer_Response.dart';
import '../Response/Customer/add_Reservation_Response.dart';
import '../Response/Customer/display_Bookmark_Response.dart';
import '../Response/Customer/display_Customer_Reservations_Response.dart';
import '../Response/Customer/display_Product_By_Type_Response.dart';
import '../Response/Customer/display_Product_Types_Response.dart';

import '../Response/Customer/remove_From_Bookmark_Response.dart';

import '../Response/Customer/display_Products_Response.dart';
import '../Response/display_profile_response.dart';

class CustomerRoute {
  Handler get handler {
    final router = Router()
      ..get('/display-bookmark', displayBookmarkResponse)
      ..get('/display-profile', displayProfileResponse)
      ..get("/display-product", displayProductsResponse)
      ..get('/display-product/<choosing-type>', displayProductByTypeResponse)
      ..post("/add-reservation", addReservationResponse)
      ..post("/add-to-bookmark", addToBookmarktResponse)
      ..get("/display-type", displayProductTypesResponse)
      ..get(
          "/display-customer-reservations", displayCustomerReservationsResponse)
      ..delete("/cancel-reservations", cancelReservationCustomerResponse)
      ..delete("/remove-from-bookmark", removeFromBookmarkResponse);

    final pipeline =
        Pipeline().addMiddleware(checkTokenMiddleware()).addHandler(router);

    return pipeline;
  }
}

// .addMiddleware(checkCustomer())