import 'dart:convert';

import 'package:shelf/shelf.dart';

import '../../ResponseMsg/CustomResponse.dart';
import '../../Services/Supabase/SupabaseEnv.dart';

displayProductsResponse(Request _) async {
  try {
    final List products = await SupabaseEnv()
        .supabase
        .from("products")
        .select();

    return Response.ok(
      json.encode(products),
      headers: {"content-type": "application/json"},
    );
  } catch (e) {
    print(e);

    return CustomResponse().errorResponse(msg: json.encode(e));
  }
}

// '*, images(id, url_image, id_product)'
 // final imageUrl = '';
    // final newProducts = products.map(
    //   (product) => {
    //     ...product,
    //     'image_urls': imageUrl,
    //   },
    // );