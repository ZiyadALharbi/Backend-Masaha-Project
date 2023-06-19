// ignore_for_file: file_names

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import '../Middleware/CheckToken_Middleware.dart';
import '../Middleware/Owner/ownerMiddleware.dart';
import '../Response/Owner/delete_product_response.dart';
import '../Response/Owner/add_product_Image_response.dart';
import '../Response/Owner/add_product_Response.dart';
import '../Response/Owner/cancel_reservation.dart';
import '../Response/Owner/display_owner_products.dart';
import '../Response/Owner/display_owner_resrvation_response.dart';

class OwnerRoute {
  Handler get handler {
    final router = Router()
      ..post("/add-product", addProductResponse)
      ..post("/add-product-image/<productID>", addProductImageResponse)
      ..delete('/cancel-reservation-owner', cancelReservationOwnerResponse)
      ..delete("/delete-product/<id>", deleteProductResponse)
      ..get("/display-owner-reservations", displayOwnerReservationResponse)
      ..get("/display-owner-product", displayOwnerProducts);

    final pipeline = Pipeline()
        .addMiddleware(checkTokenMiddleware())
        .addHandler(router);

    return pipeline;
  }
}

  // .addMiddleware(checkOwner())