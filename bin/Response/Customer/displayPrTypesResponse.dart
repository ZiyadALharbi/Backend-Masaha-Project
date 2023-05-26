import 'dart:convert';
import 'package:shelf/shelf.dart';

displayPrTypesResponse(Request req) async {
  try {
    Map<String, List<String>> productTypeMap = {
      "Product Type": [
        "Dedicated-Desk",
        "Private-Office",
        "Meeting-Room",
        "Workshops&Conference",
        "Business-Lounge",
      ],
    };

    return Response.ok(
      json.encode({...productTypeMap}),
      headers: {'content-type': 'application/json'},
    );
  } catch (error) {
    return Response.badRequest(body: error);
  }
}
