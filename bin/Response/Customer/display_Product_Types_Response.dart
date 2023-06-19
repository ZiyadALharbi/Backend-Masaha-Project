// ignore_for_file: file_names

import 'dart:convert';
import 'package:shelf/shelf.dart';

displayProductTypesResponse(Request _) async {
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
