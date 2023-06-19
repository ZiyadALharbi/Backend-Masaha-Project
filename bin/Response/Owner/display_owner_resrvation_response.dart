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
        .select()
        .eq("id_owner", idOwner[0]["id"]);

    return Response.ok(json.encode(reservationsData),
        headers: {'Content-Type': 'application/json'},);
  } catch (e) {
    return CustomResponse().errorResponse(msg: "Sorry, try again later");
  }
}

