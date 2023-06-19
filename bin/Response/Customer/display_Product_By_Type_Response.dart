// ignore_for_file: file_names

import 'dart:convert';
import 'package:shelf/shelf.dart';
import '../../ResponseMsg/CustomResponse.dart';
import '../../Services/Supabase/supabaseEnv.dart';

displayProductByTypeResponse(Request _, String type) async {
  try {
    final choosingType = await SupabaseEnv()
        .supabase
        .from("products")
        .select()
        .eq("type", type);

    return Response.ok(json.encode(choosingType), headers:{"content-type": "application/json"});
  } catch (e) {
    print(e);

    return CustomResponse().errorResponse(msg: json.encode(e));
  }
}
