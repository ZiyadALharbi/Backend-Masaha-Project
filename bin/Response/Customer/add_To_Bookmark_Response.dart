// ignore_for_file: file_names

import 'dart:convert';

import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:shelf/shelf.dart';
import '../../ResponseMsg/CustomResponse.dart';
import '../../Services/Supabase/SupabaseEnv.dart';

addToBookmarktResponse(Request req) async {
  try {
    final jwt = JWT.decode(req.headers["authorization"]!);
    final body = json.decode(await req.readAsString());

    final supabase = SupabaseEnv().supabase;

    final customerId = await supabase
        .from("customers")
        .select("id")
        .eq("id_auth", jwt.payload["sub"]);

    final data = await supabase.from("products").select().eq("id", body["id"]);

    await supabase.from("bookmarks").insert({
      "id_customer": customerId[0]["id"],
      "id_product": data[0]["id"],
    });
  
    return CustomResponse()
        .successResponse(msg: "Added to bookmark successfully!");
  } catch (error) {
    print(error);
    return CustomResponse().errorResponse(msg: "Sorry, try again later");
  }
}
