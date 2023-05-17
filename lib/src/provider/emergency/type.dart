import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sos/src/model/emergency/response.dart';
import 'package:sos/src/provider/config.dart';

// Type And SubType
Future<GetTypeListModel> getType() async {
  final response = await http.get(
    Uri.parse('${urlEmergency}type'),
  );

  if (response.statusCode == 200) {
    final res = jsonDecode(response.body);
    var resp = GetTypeListModel.fromJson(res);
    return resp;
  } else {
    throw Exception('Send APIName : GetInformList || statusCode : ${response.statusCode.toString()} || Msg : ${jsonDecode(response.body)}');
  }
}

Future<GetTypeByIdModel> getTypeById(id) async {
  final response = await http.get(
    Uri.parse('${urlEmergency}type/$id'),
  );

  if (response.statusCode == 200) {
    final res = jsonDecode(response.body);
    var resp = GetTypeByIdModel.fromJson(res);
    return resp;
  } else {
    throw Exception('Send APIName : GetInformList || statusCode : ${response.statusCode.toString()} || Msg : ${jsonDecode(response.body)}');
  }
}


Future<GetSubTypeListModel> getSubType() async {
  final response = await http.get(
    Uri.parse('${urlEmergency}subType'),
  );

  if (response.statusCode == 200) {
    final res = jsonDecode(response.body);
    var resp = GetSubTypeListModel.fromJson(res);
    return resp;
  } else {
    throw Exception('Send APIName : GetInformList || statusCode : ${response.statusCode.toString()} || Msg : ${jsonDecode(response.body)}');
  }
}