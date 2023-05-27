// ignore_for_file: file_names

import 'dart:convert';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:shelf/shelf.dart';
import '../../ResponseMsg/CustomResponse.dart';
import '../../Services/Supabase/SupabaseEnv.dart';

cancelReservationOwnerResponse(Request req) async {
  try {
    final body =
        json.decode(await req.readAsString()); //json - ex: meeting room
    final supabase = SupabaseEnv().supabase;
    final jwt = JWT.decode(req.headers["authorization"]!);
    final reservationId = supabase
        .from('reservations')
        .select('id')
        .eq("id_auth", jwt.payload["sub"]);

    await supabase
        .from('reservations')
        .delete()
        .eq('id', reservationId)
        .eq('product-type', body['type']);

    return CustomResponse().successResponse(msg: "deleted");
  } catch (error) {
    return CustomResponse().errorResponse(msg: "Sorry, try again later");
  }
}
