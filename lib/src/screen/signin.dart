import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sos/src/screen/home.dart';
import 'package:sos/src/screen/signupPhoneNumber.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../provider/userService.dart';

class Signin extends StatefulWidget {
  const Signin({Key? key}) : super(key: key);

  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  final TextEditingController _controller = TextEditingController();
  Future<Album>? _futureAlbum;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  final TextEditingController _controllerPhone = TextEditingController();

  final TextEditingController _controllerPass = TextEditingController();

  String _phone = '';

  String _pass = '';

  bool _isObscure = true;

  void _toggle() {
    log('_phone : $_phone');
    log('_pass : $_pass');

    setState(() {
      _isObscure = !_isObscure;
    });
  }

  @override
  void initState() {
    super.initState();
    _controllerPhone.addListener(() {
      setState(() {
        _phone = _controllerPhone.text;
      });
    });
    _controllerPass.addListener(() {
      setState(() {
        _pass = _controllerPass.text;
      });
    });
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _controllerPhone.dispose();
    _controllerPass.dispose();
    super.dispose();
  }

  addStringToSF(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token', token);
    addUserProfileToSF();
  }

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

  addUserProfileToSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var data = await GetUserProfile();
    prefs.setString('id', data.id);
    prefs.setString('phoneNumber', data.phoneNumber);
    prefs.setString('firstName', data.firstName);
    prefs.setString('lastName', data.lastName);
    prefs.setString('email', data.email);
    prefs.setString('birthday', data.birthday);
    prefs.setString('gender', data.gender);
    prefs.setString('imageProfile', data.imageProfile);

    prefs.setString('textIDCard', data.textIDCard);
    prefs.setString('pathImage', data.pathImage);

    prefs.setString('address', data.address);
    prefs.setString('subDistrict', data.subDistrict);
    prefs.setString('district', data.district);
    prefs.setString('province', data.province);
    prefs.setString('postalCode', data.postalCode);
    prefs.setString('country', data.country);
  }

  // static const String _baseUrl = "http://sos-app.thddns.net:7330/SosApp/signIn";
  login(String username, String password) async {
    final response = await http.post(
      Uri.parse('http://10.0.2.2:80/SosApp/accounts/signIn'),
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
      addStringToSF(m1['token']);

      // ignore: use_build_context_synchronously
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return const Home();
          },
        ),
      );
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to create album.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: const Color.fromARGB(248, 228, 44, 44),
      backgroundColor: const Color.fromARGB(255, 248, 0, 0),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Form(
            child: Column(children: <Widget>[
              Container(
                padding: const EdgeInsets.fromLTRB(10, 100, 10, 0),
                margin: const EdgeInsets.all(15),
                child: const Text(
                  "SOS",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 102,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                margin: const EdgeInsets.all(15),
                child: TextField(
                  controller: _controllerPhone,
                  decoration: const InputDecoration(
                    labelText: 'Phone number',
                    labelStyle: TextStyle(color: Colors.white),
                    // helperText: 'Ex. 0812345678',
                    // helperStyle: TextStyle(color: Colors.white),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(width: 1, color: Colors.white),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(width: 3, color: Colors.white),
                    ),
                  ),
                  keyboardType: TextInputType.phone,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                margin: const EdgeInsets.all(15),
                child: TextField(
                  controller: _controllerPass,
                  decoration: const InputDecoration(
                    suffixIcon: IconButton(
                        icon: Icon(Icons.remove_red_eye), onPressed: null),
                    labelText: 'Password',
                    labelStyle: TextStyle(color: Colors.white),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(width: 1, color: Colors.white),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(width: 3, color: Colors.white),
                    ),
                  ),
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                  enableSuggestions: false,
                  autocorrect: false,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(10, 160, 10, 0),
                child: SizedBox(
                  width: 312.48,
                  height: 63.4,
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.white),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.29),
                            side: const BorderSide(
                                width: 3, color: Colors.white)))),
                    onPressed: () {
                      login(_controllerPhone.text, _controllerPass.text);
                    },
                    child: const Text("Login",
                        style: TextStyle(color: Colors.black, fontSize: 24)),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
                child: SizedBox(
                  width: 312.48,
                  height: 63.4,
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.black),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.29),
                            side: const BorderSide(
                                width: 3, color: Colors.black)))),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return SignupPhoneNumber();
                      }));
                    },
                    child: const Text(
                      "Signup",
                      style: TextStyle(fontSize: 24),
                    ),
                  ),
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }

// jsonDecode(Uint8List bodyBytes) {}
}

class Album {
  final String token;

  const Album({required this.token});

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      token: json['token'],
    );
  }
}
