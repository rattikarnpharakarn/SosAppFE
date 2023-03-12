import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:sos/src/model/emergency/request.dart';
import 'package:sos/src/model/emergency/response.dart';

Future<ReturnResponse> PostInform(Inform req) async {
  final response = await http.post(
    Uri.parse('http://10.0.2.2:81/SosApp/emergency/user/'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(req),
  );

  if (response.statusCode == 200) {
    final res = jsonDecode(response.body);

    var resp = ReturnResponse.fromJson(res);
    return resp;
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to create album.');
  }
}
