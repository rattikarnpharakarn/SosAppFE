import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:sos/src/model/messenger/response.dart';
import 'package:sos/src/provider/config.dart';

Future<GetChatListModel> GetChatList() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? stringValue = prefs.getString('token') ?? '';
  final response = await http.get(
    Uri.parse('${urlMessenger}user/getChatList'),
    headers: <String, String>{
      'Authorization': 'Bearer ' + stringValue,
    },
  );

  if (response.statusCode == 200) {
    final res = jsonDecode(response.body);
    var resp = GetChatListModel.fromJson(res);
    return resp;
  } else {
    throw Exception('Send APIName : GetChatList || statusCode : ${response.statusCode.toString()} || Msg : ${jsonDecode(response.body)}');
  }
}

Future<GetMessageModel> GetMessageById(id) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? stringValue = prefs.getString('token') ?? '';
  final response = await http.get(
    Uri.parse('${urlMessenger}user/chat/message/' + id),
    headers: <String, String>{
      'Authorization': 'Bearer ' + stringValue,
    },
  );

  if (response.statusCode == 200) {
    final res = jsonDecode(response.body);
    var resp = GetMessageModel.fromJson(res);
    return resp;
  } else {
    throw Exception('Send APIName : GetMessageById || statusCode : ${response.statusCode.toString()} || Msg : ${jsonDecode(response.body)}');
  }
}

Future<GetMemberRoomChatModel> GetMembersRoomChat(roomChatId) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? stringValue = prefs.getString('token') ?? '';
  final response = await http.get(
    Uri.parse('${urlMessenger}user/getMembersRoomChat/' + roomChatId),
    headers: <String, String>{
      'Authorization': 'Bearer ' + stringValue,
    },
  );

  if (response.statusCode == 200) {
    final res = jsonDecode(response.body);
    var resp = GetMemberRoomChatModel.fromJson(res);
    return resp;
  } else {
    throw Exception('Send APIName : GetMembersRoomChat || statusCode : ${response.statusCode.toString()} || Msg : ${jsonDecode(response.body)}');
  }
}

Future<ReturnResponse> PostMessage(roomChatID, message, image) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? stringValue = prefs.getString('token') ?? '';
  final response = await http.post(
    Uri.parse('${urlMessenger}user/chat/message'),
    headers: <String, String>{
      'Authorization': 'Bearer ' + stringValue,
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>{
      'roomChatID': roomChatID,
      'message': message,
      'image': image,
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

Future<ReturnResponse> CreateRoomChat(roomName, userid) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? stringValue = prefs.getString('token') ?? '';
  Map<String, dynamic> usersId = {"userID": userid};
  final response = await http.post(
    Uri.parse('${urlMessenger}user/createRoomChat'),
    headers: <String, String>{
      'Authorization': 'Bearer ' + stringValue,
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>{
      'roomName': roomName,
      'groupChat': usersId,
    }),
  );

  if (response.statusCode == 200) {
    final res = jsonDecode(response.body);
    var resp = ReturnResponse.fromJson(res);
    return resp;
  } else {
    throw Exception('Send APIName : CreateRoomChat || statusCode : ${response.statusCode.toString()} || Msg : ${jsonDecode(response.body)}');
  }
}

Future<ReturnResponse> JoinRoomChat(roomChatIdStr, userid) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? stringValue = prefs.getString('token') ?? '';
  var roomChatId = int.parse(roomChatIdStr);
  final response = await http.post(
    Uri.parse('${urlMessenger}user/joinChat'),
    headers: <String, String>{
      'Authorization': 'Bearer ' + stringValue,
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>{
      'roomChatID': roomChatId,
      'userid' : userid,
    }),
  );

  if (response.statusCode == 200) {
    final res = jsonDecode(response.body);
    var resp = ReturnResponse.fromJson(res);
    return resp;
  } else {
    throw Exception('Send APIName : JoinRoomChat || statusCode : ${response.statusCode.toString()} || Msg : ${jsonDecode(response.body)}');
  }
}
