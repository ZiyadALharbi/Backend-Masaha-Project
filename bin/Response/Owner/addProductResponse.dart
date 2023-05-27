// ignore_for_file: file_names

import 'dart:convert';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:shelf/shelf.dart';
import '../../ResponseMsg/CustomResponse.dart';
import '../../Services/Supabase/SupabaseEnv.dart';

addProductResponse(Request req) async {
  try {
    final body = json.decode(await req.readAsString());
    final jwt = JWT.decode(req.headers["authorization"]!);
    final supabase = SupabaseEnv().supabase;

    final idOwner = (await supabase
        .from("owners")
        .select()
        .eq("id_auth", jwt.payload["sub"]))[0]['id'];

    await supabase.from("products").insert(
      {"id_owner": idOwner, ...body},
    );

    return CustomResponse().successResponse(msg: "Product added successfully!");
  } catch (error) {
    return CustomResponse().errorResponse(msg: "Sorry, try again later");
  }
}
