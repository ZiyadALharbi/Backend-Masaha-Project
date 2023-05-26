import 'dart:io';
import 'dart:math';

import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:shelf/shelf.dart';

import '../../Services/Supabase/SupabaseEnv.dart';

addProductImageResponse(Request req, String type) async {
  final byte = await req.read().expand((element) => element).toList();
  final userInfo = JWT.decode(req.headers["authorization"]!);

  final randomNumber = Random().nextInt(9999999);
  final image = await createImage(byte: byte, randomNumber: randomNumber);

  final ownerID = await getIDOwner(idAuth: userInfo.payload["sub"]);
  final productID = await getIDProduct(ownerID: ownerID, type: type);

  final url = await uploadImage(
    file: image,
    randomNumber: randomNumber,
  );

  await image.delete();
  await sendURL(url: url, productID: productID);

  return Response.ok("Image added successfully!");
}

Future<File> createImage(
    {required List<int> byte, required randomNumber}) async {
  final file = File("bin/images/$randomNumber.png");
  await file.writeAsBytes(byte);

  return file;
}

getIDOwner({required String idAuth}) async {
  final supabase = SupabaseEnv().supabase;

  final ownerID = (await supabase
      .from("owners")
      .select("id")
      .eq("id_auth", idAuth))[0]["id"];

  return ownerID;
}

getIDProduct({required ownerID, required String type}) async {
  final supabase = SupabaseEnv().supabase;

  final productID = (await supabase
      .from("products")
      .select("id")
      .eq("id_owner", ownerID)
      .eq("type", type))[0]["id"];

  return productID;
}

uploadImage({required randomNumber, required File file}) async {
  final supabase = SupabaseEnv().supabase.storage.from("ProductImages");

  await supabase.upload('images/$randomNumber.png', file);

  final url = await supabase.getPublicUrl('images/$randomNumber.png');

  return url;
}

sendURL({required int productID, required String url}) async {
  final supabase = SupabaseEnv().supabase.from("images");

  final result =
      await supabase.upsert({"id_product": productID, "url_image": url});

  return result;
}
