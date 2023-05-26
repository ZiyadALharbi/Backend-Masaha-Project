import 'dart:io';

import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:shelf/shelf.dart';

import '../../Services/Supabase/SupabaseEnv.dart';

addProductImageResponse(Request req, String name) async {
  final byte = await req.read().expand((element) => element).toList();
  final userInfo = JWT.decode(req.headers["authorization"]!);

  final image = await createImage(byte: byte, name: name);

  final ownerID = await getIDOwner(idAuth: userInfo.payload["sub"]);
  final productID = await getIDProduct(ownerID: ownerID);

  final url = await uploadImage(file: image,name: name,);

  await image.delete();
  await sendURL(url: url,productID: productID );

  return Response.ok("Image added successfully!");
}

Future<File> createImage(
    {required List<int> byte, required String name}) async {
  final file = File("bin/images/$name.png");
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

getIDProduct({required ownerID}) async {
  final supabase = SupabaseEnv().supabase;

  final productID = (await supabase
      .from("products")
      .select("id")
      .eq("id_owner", ownerID))[0]["id"];

  return productID;
}

uploadImage({required String name, required File file}) async {
  final supabase =  SupabaseEnv()
      .supabase
      .storage
      .from("ProductImages");

      await supabase.upload('images/$name.png', file);
  
  final url = await supabase.getPublicUrl('images/$name.png');

  return url;
}


sendURL({required int productID, required String url}) async {
  final supabase = SupabaseEnv().supabase.from("image");

  final result = await supabase.upsert({"id_product": productID, "urlimage": url});

  return result;
}