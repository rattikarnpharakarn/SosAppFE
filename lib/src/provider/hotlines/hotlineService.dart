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
    throw Exception('Send APIName : GetHotlineList || statusCode : ${response.statusCode.toString()} || Msg : ${jsonDecode(response.body)}');
  }
}


Future<ReturnResponse> postHotline(int hotlineId,int  userId) async {
  final response = await http.post(
    Uri.parse('${urlHotline}'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>{
      'hotlineId': hotlineId,
      'userId': userId
    }),
  );

  if (response.statusCode == 200) {
    final res = jsonDecode(response.body);
    var resp = ReturnResponse.fromJson(res);
    return resp;
  } else {
    throw Exception('Send APIName : PostMessage || statusCode : ${response.statusCode.toString()} || Msg : ${jsonDecode(response.body)}');
  }
}