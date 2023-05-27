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

    final owners = await supabase
        .from("owners")
        .select()
        .eq("id_auth", jwt.payload["sub"]);

    final idOwner = owners[0]["id"];
    final ownerUsername = owners[0]["username"];

    await supabase.from("products").insert(
        {"id_owner": idOwner, "owner_username": ownerUsername, ...body},);

    return CustomResponse().successResponse(msg: "Product added successfully!");
  } catch (error) {
    return CustomResponse().errorResponse(msg: "Sorry, try again later");
  }
}
