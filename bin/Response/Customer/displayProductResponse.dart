// ignore_for_file: file_names

import 'dart:convert';
import 'package:shelf/shelf.dart';
import '../../ResponseMsg/CustomResponse.dart';
import '../../Services/Supabase/supabaseEnv.dart';

displayProductResponse(Request _, String type) async {
  try {
    final choosingType = await SupabaseEnv()
        .supabase
        .from("products")
        .select("type, description, price, owner_username")
        .eq("type", type);

    return CustomResponse()
        .successResponse(msg: "Successfully", data: choosingType);
  } catch (e) {
    return CustomResponse().errorResponse(msg: json.encode(e));
  }
}
