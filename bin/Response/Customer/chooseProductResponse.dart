import 'dart:convert';

import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:shelf/shelf.dart';

import '../../ResponseMsg/CustomResponse.dart';
import '../../Services/Supabase/SupabaseEnv.dart';

chooseProductResponse(Request req) async {
  try {
    final header = req.headers;
    final body = json.decode(await req.readAsString());
    final jwt = JWT.decode(header['authorization']!);
    final supabase = SupabaseEnv().supabase;

    final customerUsername = await supabase
        .from("customers")
        .select("username, id")
        .eq("id_auth", jwt.payload["sub"]);

    final reservationData = await supabase
        .from("products")
        .select("id, type, price, id_owner, owner_username")
        .eq("type", body["type"])
        .eq("owner_username", body["owner_username"]);

    await supabase.from("reservations").insert({
      "id_owner": reservationData[0]["id_owner"],
      "id_customer": customerUsername[0]["id"],
      "id_product": reservationData[0]["id"],
      "customer_username": customerUsername[0]["username"],
      "owner_username": reservationData[0]["owner_username"],
      "product_type": reservationData[0]["type"],
      "product_price": reservationData[0]["price"],
    });

    return CustomResponse().successResponse(msg: "Successful Reservation");
  } catch (e) {
    print(e);

    return CustomResponse().errorResponse(msg: "Sorry,try again later");
  }
}
