import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:sos/src/model/emergency/request.dart';
import 'package:sos/src/model/emergency/response.dart';
import 'package:sos/src/provider/config.dart';


Future<GetInformListModel> GetInformList() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? stringValue = prefs.getString('token') ?? '';
  final response = await http.get(
    Uri.parse('${urlEmergency}user/'),
    headers: <String, String>{
      'Authorization': 'Bearer ' + stringValue,
    },
  );

  if (response.statusCode == 200) {
    final res = jsonDecode(response.body);
    var resp = GetInformListModel.fromJson(res);
    return resp;
  } else {
    throw Exception('Send APIName : GetInformList || statusCode : ${response.statusCode.toString()} || Msg : ${jsonDecode(response.body)}');
  }
}

Future<GetInformListModel> GetInformListOps() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? stringValue = prefs.getString('token') ?? '';
  final response = await http.get(
    Uri.parse('${urlEmergency}ops/'),
    headers: <String, String>{
      'Authorization': 'Bearer ' + stringValue,
    },
  );

  if (response.statusCode == 200) {
    final res = jsonDecode(response.body);
    var resp = GetInformListModel.fromJson(res);
    return resp;
  } else {
    throw Exception('Send APIName : GetInformList || statusCode : ${response.statusCode.toString()} || Msg : ${jsonDecode(response.body)}');
  }
}

Future<GetInformListModel> GetInformListAll() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? stringValue = prefs.getString('token') ?? '';
  final response = await http.get(
    Uri.parse('${urlEmergency}ops/all'),
    headers: <String, String>{
      'Authorization': 'Bearer ' + stringValue,
    },
  );

  if (response.statusCode == 200) {
    final res = jsonDecode(response.body);
    var resp = GetInformListModel.fromJson(res);
    return resp;
  } else {
    throw Exception('Send APIName : GetInformList || statusCode : ${response.statusCode.toString()} || Msg : ${jsonDecode(response.body)}');
  }
}

Future<GetInformByIdModel> GetInformListById(id) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? stringValue = prefs.getString('token') ?? '';
  final response = await http.get(
    Uri.parse('${urlEmergency}user/'+id),
    headers: <String, String>{
      'Authorization': 'Bearer ' + stringValue,
    },
  );

  if (response.statusCode == 200) {
    final res = jsonDecode(response.body);
    var resp = GetInformByIdModel.fromJson(res);
    return resp;
  } else {
    throw Exception('Send APIName : GetInformListById || statusCode : ${response.statusCode.toString()} || Msg : ${jsonDecode(response.body)}');
  }
}

Future<GetInformByIdModel> GetInformByIdOps(id) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? stringValue = prefs.getString('token') ?? '';
  final response = await http.get(
    Uri.parse('${urlEmergency}ops/'+id),
    headers: <String, String>{
      'Authorization': 'Bearer ' + stringValue,
    },
  );

  if (response.statusCode == 200) {
    final res = jsonDecode(response.body);
    var resp = GetInformByIdModel.fromJson(res);
    return resp;
  } else {
    throw Exception('Send APIName : GetInformListById || statusCode : ${response.statusCode.toString()} || Msg : ${jsonDecode(response.body)}');
  }
}

Future<ReturnResponse> PostInform(Inform req) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? stringValue = prefs.getString('token') ?? '';
  final response = await http.post(
    Uri.parse('${urlEmergency}user/'),
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



Future<ReturnResponse> UpdateInformOps(UpdateInform req, String informId) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? stringValue = prefs.getString('token') ?? '';
  final response = await http.put(
    Uri.parse('${urlEmergency}ops/'+informId),
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
