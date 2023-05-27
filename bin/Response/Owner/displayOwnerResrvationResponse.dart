import 'dart:convert';

import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:shelf/shelf.dart';

import '../../ResponseMsg/CustomResponse.dart';
import '../../Services/Supabase/SupabaseEnv.dart';

displayOwnerReservationResponse(Request req) async {
  try {
    final header = req.headers;

    final jwt = JWT.decode(header['authorization']!);
    final supabase = SupabaseEnv().supabase;

    final idOwner = await supabase
        .from("owners")
        .select("id")
        .eq("id_auth", jwt.payload["sub"]);

    final reservationsData = await supabase
        .from("reservations")
        .select(
          "id,customer_username,owner_username,product_type,product_price,created_at",
        )
        .eq("id_owner", idOwner[0]["id"]);

    return Response.ok(json.encode(reservationsData),
        headers: {'Content-Type': 'application/json'},);
  } catch (e) {
    print(e);

    return CustomResponse().errorResponse(msg: "Sorry, try again later");
  }
}
