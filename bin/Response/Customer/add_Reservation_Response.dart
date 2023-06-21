import 'dart:convert';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:shelf/shelf.dart';

import '../../ResponseMsg/CustomResponse.dart';
import '../../Services/Supabase/SupabaseEnv.dart';

addReservationResponse(Request req) async {
  try {
    final header = req.headers;
    final body = json.decode(await req.readAsString());
    final jwt = JWT.decode(header['authorization']!);
    final supabase = SupabaseEnv().supabase;

    final customerUsername = await supabase
        .from("customers")
        .select("username, id")
        .eq("id_auth", jwt.payload["sub"]);

    final productData = await supabase
        .from("products")
        .select("id, type, price, id_owner, owner_username,name,plan_type")
        .eq("id", body["id"]);

    await supabase.from("reservations").insert({
      "id_owner": productData[0]["id_owner"],
      "id_customer": customerUsername[0]["id"],
      "id_product": productData[0]["id"],
      "customer_username": customerUsername[0]["username"],
      "owner_username": productData[0]["owner_username"],
      "product_type": productData[0]["type"],
      "product_price": productData[0]["price"],
      "product_name": productData[0]["name"],
      "product_plan": productData[0]["plan_type"],
      "customer_email": body["email"],
      "customer_name": body["name"],
      "customer_phone": body["phone"],
      "date": body["date"],
    });

    return CustomResponse().successResponse(msg: "Successful Reservation");
  } catch (e) {
    print(e);

    return CustomResponse().errorResponse(msg: "Sorry,try again later");
  }
}
