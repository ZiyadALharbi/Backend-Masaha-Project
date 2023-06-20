// ignore_for_file: file_names

import 'dart:convert';
import 'package:shelf/shelf.dart';
import 'package:supabase/supabase.dart';
import '../../Models/UserModel.dart';
import '../../ResponseMsg/CustomResponse.dart';
import '../../Services/Supabase/SupabaseEnv.dart';

createAccountResponse(Request req) async {
  try {
    final header = req.headers;
    final body = json.decode(await req.readAsString());
    final supabase = SupabaseEnv().supabase;
    final auth = supabase.auth;

    UserResponse userInfo = await auth.admin.createUser(
      AdminUserAttributes(email: body["email"], password: body["password"]),
    );

    UserModel userObject = UserModel(
      email: userInfo.user!.email!,
      idAuth: userInfo.user!.id,
      name: body["name"],
      username: body["username"],
      phone: body["phone"],
    );

    await auth.signInWithOtp(email: body['email']);

    if (body["user-type"] == "customer") {
      await supabase.from("customers").insert(userObject.toMap());
    } else if (body["user-type"] == "owner") {
      await supabase.from("owners").insert(userObject.toMap());
    }

    return CustomResponse().successResponse(
      msg: "Account created successfully!",
      data: {"email": body['email'], "username": body['username']},
    );
  } catch (error) {
    print(error);

    return CustomResponse().errorResponse(
      msg: "sorry, please check your information",
    );
  }
}
