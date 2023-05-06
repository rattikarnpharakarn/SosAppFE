import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sos/src/provider/config.dart';
import '../../model/accounts/user.dart';

Future<UserInfo> GetUserProfile() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? stringValue = prefs.getString('token') ?? '';
  if (stringValue == '') {
    UserInfo userInfoRes = UserInfo(
      id: "",
      phoneNumber: '',
      firstName: '',
      lastName: '',
      email: '',
      birthday: '',
      gender: '',
      imageProfile: '',
      // IDCard
      textIDCard: '',
      pathImage: '',
      // address
      address: '',
      subDistrict: '',
      district: '',
      province: '',
      postalCode: '',
      country: '',
    );
    return userInfoRes;
  }

  final response = await http.get(
    Uri.parse('${urlAccount}user/'),
    headers: <String, String>{
      'Authorization': 'Bearer ' + stringValue,
    },
  );


  if (response.statusCode == 200) {
    final dataUser = jsonDecode(response.body);
    // ignore: use_build_context_synchronously

    final data = dataUser['data'];
    final idCard = data['idCard'];
    final address = data['address'];

    UserInfo userInfoRes = UserInfo(
      id: data['id'],
      phoneNumber: data['phoneNumber'],
      firstName: data['firstName'],
      lastName: data['lastName'],
      email: data['email'],
      birthday: data['birthday'],
      gender: data['gender'],
      imageProfile: data['imageProfile'],
      // IDCard
      textIDCard: idCard['textIDCard'],
      pathImage: idCard['pathImage'],
      // address
      address: address['address'],
      subDistrict: address['subDistrict'],
      district: address['district'],
      province: address['province'],
      postalCode: address['postalCode'],
      country: address['country'],
    );
    return userInfoRes;
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Code : ' + response.statusCode.toString());
  }
}

Future<UserInfo> GetUserProfileById(userId) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? stringValue = prefs.getString('token') ?? '';
  final response = await http.get(
    Uri.parse('${urlAccount}user/' + userId.toString()),
    headers: <String, String>{
      'Authorization': 'Bearer ' + stringValue,
    },
  );

  if (response.statusCode == 200) {
    final dataUser = jsonDecode(response.body);
    // ignore: use_build_context_synchronously

    final data = dataUser['data'];
    final idCard = data['idCard'];
    final address = data['address'];

    UserInfo userInfoRes = UserInfo(
      id: data['id'],
      phoneNumber: data['phoneNumber'],
      firstName: data['firstName'],
      lastName: data['lastName'],
      email: data['email'],
      birthday: data['birthday'],
      gender: data['gender'],
      imageProfile: data['imageProfile'],
      // IDCard
      textIDCard: idCard['textIDCard'],
      pathImage: idCard['pathImage'],
      // address
      address: address['address'],
      subDistrict: address['subDistrict'],
      district: address['district'],
      province: address['province'],
      postalCode: address['postalCode'],
      country: address['country'],
    );
    return userInfoRes;
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.

    final dataUser = jsonDecode(response.body);

    String msg = "Code " +
        response.statusCode.toString() +
        "\n response : " +
        dataUser.toString();

    throw Exception(msg);
  }
}

Future<UserImage> GetUserImageById(userId) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? stringValue = prefs.getString('token') ?? '';
  final response = await http.get(
    Uri.parse('${urlAccount}user/image/' + userId.toString()),
    headers: <String, String>{
      'Authorization': 'Bearer ' + stringValue,
    },
  );

  if (response.statusCode == 200) {
    final dataUser = jsonDecode(response.body);
    final data = dataUser['data'];

    UserImage userInfoRes = UserImage(
      id: data['id'],
      imageProfile: data['imageProfile'],
    );
    return userInfoRes;
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to GetUserProfile.');
  }
}

Future<GetUserListModel> GetSearchUser(value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? stringValue = prefs.getString('token') ?? '';
  final response = await http.get(
    Uri.parse('${urlAccount}user/searchUser/' + value),
    headers: <String, String>{
      'Authorization': 'Bearer ' + stringValue,
    },
  );

  if (response.statusCode == 200) {
    final res = jsonDecode(response.body);
    var resp = GetUserListModel.fromJson(res);
    return resp;
  } else {
    final res = jsonDecode(response.body);
    var resp = GetUserListModel.fromJson(res);
    throw Exception(resp);
  }
}
