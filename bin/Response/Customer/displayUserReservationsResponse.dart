import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:shelf/shelf.dart';

import '../../Services/Supabase/supabaseEnv.dart';

displayUserReservationsResponse(Request req) async {
  final header = req.headers;

  final jwt = JWT.decode(header['authorization']!.toString().trim());
  final supabase = SupabaseEnv().supabase;

  final idcustomer = await supabase
      .from("customers")
      .select("id")
      .eq("id_auth", jwt.payload["sub"]);

  final ReservationsData = await supabase
      .from("reservations")
      .select(
        "customer-username,owner-username,product-type,product-price,credted-at",
      )
      .eq("id_customer", idcustomer);

  return (ReservationsData);
}
