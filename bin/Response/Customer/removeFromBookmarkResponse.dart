// ignore_for_file: file_names

import 'dart:convert';

import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:shelf/shelf.dart';
import '../../ResponseMsg/CustomResponse.dart';
import '../../Services/Supabase/SupabaseEnv.dart';

removeFromBookmarkResponse(Request req) async {
  try {
    final body = json.decode(await req.readAsString());
    JWT.decode(req.headers['authorization']!.toString().trim());
    final supabase = SupabaseEnv().supabase;

    await supabase
        .from('bookmarks')
        .delete()
        .eq("id_product", body["id_product"]);

    return CustomResponse().successResponse(msg: "deleted");
  } catch (error) {
    return CustomResponse().errorResponse(msg: "Sorry, try again later");
  }
}
