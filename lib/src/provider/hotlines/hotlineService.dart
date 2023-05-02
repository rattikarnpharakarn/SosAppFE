import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sos/src/model/hotlines/response.dart';
import 'package:sos/src/model/hotlines/response.dart';
import 'package:sos/src/provider/config.dart';

Future<GetHotlineListModel> GetHotlineList() async {
  final response = await http.get(
    Uri.parse(urlHotline),
  );

  if (response.statusCode == 200) {
    final hotlineList = jsonDecode(response.body);

   var resp = GetHotlineListModel.fromJson(hotlineList);
    return resp;
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to create album.');
  }
}
