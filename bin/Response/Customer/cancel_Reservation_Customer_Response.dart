import 'dart:convert';

import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:shelf/shelf.dart';
import '../../ResponseMsg/CustomResponse.dart';
import '../../Services/Supabase/SupabaseEnv.dart';

cancelReservationCustomerResponse(Request req) async {
  try {
    final body = json.decode(await req.readAsString());
    final supabase = SupabaseEnv().supabase;
    final jwt = JWT.decode(req.headers["authorization"]!);

    await supabase
        .from('reservations')
        .delete()
        .eq('id', body["id"]);

    return CustomResponse()
        .successResponse(msg: "Reservation Canceled Successfully");
  } catch (error) {
    print(error);

    return CustomResponse().errorResponse(msg: "Sorry, try again later");
  }
}
