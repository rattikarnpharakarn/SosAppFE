import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:sos/src/model/emergency/request.dart';
import 'package:sos/src/model/emergency/response.dart';


Future<GetInformListModel> GetInformList() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? stringValue = prefs.getString('token') ?? '';
  final response = await http.get(
    Uri.parse('http://10.0.2.2:81/SosApp/emergency/user/'),
    headers: <String, String>{
      'Authorization': 'Bearer ' + stringValue,
    },
  );

  if (response.statusCode == 200) {
    final res = jsonDecode(response.body);
    var resp = GetInformListModel.fromJson(res);
    return resp;
  } else {
    throw Exception('Failed to GetInformListModel.');
  }
}



Future<ReturnResponse> PostInform(Inform req) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? stringValue = prefs.getString('token') ?? '';
  final response = await http.post(
    Uri.parse('http://10.0.2.2:81/SosApp/emergency/user/'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer ' + stringValue,
    },
    body: jsonEncode(req),
  );

  if (response.statusCode == 200) {
    final res = jsonDecode(response.body);

    var resp = ReturnResponse.fromJson(res);
    return resp;
  } else {
    final res = jsonDecode(response.body);

    var resp = ReturnResponse.fromJson(res);
    return resp;
  }
}
