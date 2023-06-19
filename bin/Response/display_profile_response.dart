// ignore_for_file: file_names

import 'dart:convert';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:shelf/shelf.dart';
import '../ResponseMsg/CustomResponse.dart';
import '../Services/Supabase/SupabaseEnv.dart';

displayProfileResponse(Request req) async {
  try {
    final header = req.headers;
    final jwt = JWT.decode(header['authorization']!.toString().trim());
    final supabase = SupabaseEnv().supabase;

    if (header["user-type"] == "customer") {
      final customerId = await supabase
          .from("customers")
          .select()
          .eq("id_auth", jwt.payload["sub"]);

      final customerProfile = await supabase
          .from("customers")
          .select()
          .eq("id", customerId[0]["id"]);

      return Response.ok(json.encode(customerProfile));
    } else if (header["user-type"] == "owner") {
      final ownerId = await supabase
          .from("owners")
          .select()
          .eq("id_auth", jwt.payload["sub"]);

      final ownerProfile =
          await supabase.from("owners").select().eq("id", ownerId[0]["id"]);
      return Response.ok(json.encode(ownerProfile));
    }
  } catch (error) {
    print(error);

    return CustomResponse().errorResponse(
      msg: "sorry, please check your information",
    );
  }
}
