// ignore_for_file: file_names

import 'dart:convert';
import 'package:shelf/shelf.dart';
import '../../ResponseMsg/CustomResponse.dart';
import '../../Services/Supabase/SupabaseEnv.dart';

loginResponse(Request req) async {
  try {
    final body = json.decode(await req.readAsString());
    if (body["email"] == null || body["password"] == null) {
      return Response.badRequest(body: "add email and password please");
    }

    final auth = SupabaseEnv().supabase.auth;

    final userLogin = await auth.signInWithPassword(
      email: body["email"],
      password: body["password"],
    );

    String userType = "customer";
    final supabase = SupabaseEnv().supabase;
    final result = await supabase.from("owners").select().eq("email", body["email"]);

    final List idUser = result;
    if(idUser.isNotEmpty){
      userType = "owner";
    }

    return CustomResponse().successResponse(
      msg: "success",
      data: {
        "token": userLogin.session?.accessToken.toString(),
        "refresh Token": userLogin.session?.refreshToken.toString(),
        "UserType": userType,
      },
    );
  } catch (error) {
    return Response.badRequest(body: "Sorry, try again later");
  }
}
