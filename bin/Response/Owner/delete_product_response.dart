import 'dart:convert';

import 'package:shelf/shelf.dart';

import '../../ResponseMsg/CustomResponse.dart';
import '../../Services/Supabase/SupabaseEnv.dart';

deleteProductResponse(Request _, String id) async{
  try{
    final supabase = SupabaseEnv().supabase;

    await supabase.from("products").delete().eq("id", int.parse(id));

    return CustomResponse().successResponse(msg: "Product is Deleted Successfully");
  } catch (error){
    return CustomResponse().errorResponse(msg: "sorry, Couldn't delete product");
  }
}