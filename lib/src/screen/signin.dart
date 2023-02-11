import 'dart:developer';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert' as convert;

import 'package:http/http.dart' as http;
import 'package:file/local.dart';
import 'package:sos/src/screen/home.dart';
import 'package:sos/src/screen/signupPhoneNumber.dart';

class Signin extends StatefulWidget {
  const Signin({Key? key}) : super(key: key);

  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> {
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

  // Future<http.Response> siging(String phone, String pass) {
  //   final url = "http://sos-app.thddns.net:7330/SosApp/signIn";
  //   log('response  : $phone');
  //   log('response  : $pass');

  //   Map<String, String> boby = {
  //     'username': '0815476439',
  //     'password': '123456789'
  //   };
  //   String jsonString = convert.json.encode(boby);

  //   return http.post(Uri.parse(url),
  //       headers: <String, String>{
  //         'Content-Type': 'application/json',
  //       },
  //       body: jsonString);
  // }

  // static const String _baseUrl = "http://sos-app.thddns.net:7330/SosApp/signIn";

  onLogin() async {
    try {
      final url = "http://10.0.2.2:81/SosApp/signIn";
      // final url = "http://localhost:8123//SosApp/signIn";
      // const url = "http://192.168.16.1:8123//SosApp/signIn";

      String phone = _controllerPhone.text;
      String pass = _controllerPass.text;
      Map<String, String> boby = {'username': phone, 'password': pass};
      String jsonString = convert.json.encode(boby);
      var response = await post(Uri.parse(url),
          headers: <String, String>{
            'Content-Type': 'application/json',
          },
          body: jsonString);
      log(response.body);
    } catch (e) {
      log(e.toString());
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
                  decoration: InputDecoration(
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
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                margin: const EdgeInsets.all(15),
                child: TextField(
                  controller: _controllerPass,
                  decoration: InputDecoration(
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
                  style: TextStyle(color: Colors.white),
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
                    // onPressed: () {
                    //   Navigator.push(context,
                    //       MaterialPageRoute(builder: (context) {
                    //     return const Home();
                    //   }));
                    // },
                    onPressed: onLogin,
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
                        return const SignupPhoneNumber();
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

  jsonDecode(Uint8List bodyBytes) {}
}
