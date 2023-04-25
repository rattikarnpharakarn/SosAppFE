import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:sos/src/model/messenger/response.dart';

Future<GetChatListModel> GetChatList() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? stringValue = prefs.getString('token') ?? '';
  final response = await http.get(
    Uri.parse('http://10.0.2.2:83/SosApp/messenger/user/getChatList'),
    headers: <String, String>{
      'Authorization': 'Bearer ' + stringValue,
    },
  );

  if (response.statusCode == 200) {
    final res = jsonDecode(response.body);
    var resp = GetChatListModel.fromJson(res);
    return resp;
  } else {
    throw Exception('Failed to GetChatData.');
  }
}