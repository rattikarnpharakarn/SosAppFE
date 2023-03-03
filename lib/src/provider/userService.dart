import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../model/user.dart';

Future<UserInfo> GetUserProfile() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? stringValue = prefs.getString('token');
  final response = await http.get(
    Uri.parse('http://10.0.2.2:80/SosApp/accounts/user/'),
    headers: <String, String>{
      'Authorization': 'Bearer ' + stringValue!,
    },
  );

  if (response.statusCode == 200) {
    final dataUser = jsonDecode(response.body);
    // ignore: use_build_context_synchronously

    final data = dataUser['data'];
    final idCard = data['idCard'];
    final address = data['address'];

    //
    // print('========================');
    // print(data['id']);
    // print(data['phoneNumber']);
    // print(data['firstName']);
    // print(data['lastName']);
    // print(data['email']);
    // print(data['birthday']);
    // print(data['gender']);
    // print(data['imageProfile']);
    //
    // print(idCard['textIDCard']);
    // print(idCard['pathImage']);
    //
    // print(address['address']);
    // print(address['subDistrict']);
    // print(address['district']);
    // print(address['province']);
    // print(address['postalCode']);
    // print(address['country']);
    // print('========================');


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
    throw Exception('Failed to create album.');
  }
}
