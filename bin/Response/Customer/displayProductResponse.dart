// ignore_for_file: file_names

import 'dart:convert';

import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:shelf/shelf.dart';
import '../../ResponseMsg/CustomResponse.dart';
import '../../Services/Supabase/supabaseEnv.dart';

displayProductResponse(Request req, String type) async {
  try {
    final jwt = JWT.decode(req.headers["authorization"]!);
    final supabase = SupabaseEnv().supabase;
    final table = await supabase.from("products");
//-------------- here start get id from table user by use id auth

    table.select("type").eq("id_owner", jwt.payload["sub"]);
//-------------- here start get contact
    final choosingType = table.select().eq("type", type);

    return CustomResponse()
        .successResponse(msg: "Your type is: ", data: choosingType);

    // return ResponseCustom().successResponse(msg: "success", data: user);
  } catch (e) {
    return CustomResponse().errorResponse(msg: json.encode(e));
  }
}
