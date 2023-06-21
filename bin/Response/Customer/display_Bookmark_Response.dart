// ignore_for_file: file_names

import 'dart:convert';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:shelf/shelf.dart';
import '../../ResponseMsg/CustomResponse.dart';
import '../../Services/Supabase/supabaseEnv.dart';

displayBookmarkResponse(Request req) async {
  try {
    final header = req.headers;
    final jwt = JWT.decode(header['authorization']!.toString().trim());
    final supabase = SupabaseEnv().supabase;

    final idCustomer = await supabase
        .from("customers")
        .select("id")
        .eq("id_auth", jwt.payload["sub"]);

    final bookmarkData = await supabase
        .from("bookmarks")
        .select("*, products(*)")
        .eq("id_customer", idCustomer[0]["id"]);

    print(bookmarkData);

    // List images = [];
    // for (final item in bookmarkData) {
    //    images = await supabase
    //       .from("images")
    //       .select()
    //       .eq("id_product", item["products"]["id"]);
    //   item["images"] = images;
    // }
    print(bookmarkData);

    return Response.ok(
      json.encode(bookmarkData),
      headers: {'Content-Type': 'application/json'},
    );
  } catch (e) {
    print(e);

    return CustomResponse().errorResponse(msg: "Sorry, try again later");
  }
}

 // for (final item in bookmarkData) {
    //   item["images"] = images;
    // }
