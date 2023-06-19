// ignore_for_file: file_names

import 'dart:convert';

import 'package:shelf/shelf.dart';
import '../../ResponseMsg/CustomResponse.dart';
import '../../Services/Supabase/SupabaseEnv.dart';

cancelReservationOwnerResponse(Request req) async {
  try {
    final body =
        json.decode(await req.readAsString()); //json - ex: meeting room
    final supabase = SupabaseEnv().supabase;

    await supabase.from('reservations').delete().eq('id', body["id"]);

    return CustomResponse().successResponse(msg: "deleted");
  } catch (error) {
    return CustomResponse().errorResponse(msg: "Sorry, try again later");
  }
}
