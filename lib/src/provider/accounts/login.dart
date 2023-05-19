import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sos/src/provider/config.dart';
import 'package:sos/src/sharedInfo/user.dart';

addStringToSF(String token) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('token', token);
  await addUserProfileToSF();
}

Future<List<String>> login(String username, String password) async {
  List<String> res = ["0",""];

  final response = await http.post(
    Uri.parse('${urlAccount}signIn'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'username': username,
      'password': password,
    }),
  );
  if (response.statusCode == 200) {
    final m1 = jsonDecode(response.body);
    if (m1['token'] != null) {
      await addStringToSF(m1['token']);
      res[0] = '0';
      return res;
    } else {

      // print(m1['data']);
      String message = m1['data'];
      res[1] = message;
      return res;
    }

  } else {
    final m1 = jsonDecode(response.body);
    String message = m1['message'];
    res[0] = "";
    res[1] = message;
    print(
        'Send APIName : login || statusCode : ${response.statusCode.toString()} || Msg : ${jsonDecode(response.body)}');
    return res;
  }
}
