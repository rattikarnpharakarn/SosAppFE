import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sos/main.dart';
import 'package:sos/src/provider/config.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sos/src/screen/common/snack_bar_sos.dart';
import 'package:sos/src/sharedInfo/user.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'signupPhoneNumber.dart';

class Signin extends StatefulWidget {
  const Signin({Key? key}) : super(key: key);

  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  final TextEditingController _controllerPhone = TextEditingController();
  final formKey = GlobalKey<FormState>();

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
    await addUserProfileToSF();
  }

  // static const String _baseUrl = "http://sos-app.thddns.net:7330/SosApp/signIn";
  Future<String> login(String username, String password) async {
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
      print(2);

      final m1 = jsonDecode(response.body);
      await addStringToSF(m1['token']);
      return '0';
    } else {
      final m1 = jsonDecode(response.body);
      String code = m1['message'];
      print(
          'Send APIName : login || statusCode : ${response.statusCode.toString()} || Msg : ${jsonDecode(response.body)}');
      return code;
    }
  }

  String Icons_remove_red_eye = 'Close';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: const Color.fromARGB(248, 228, 44, 44),
      backgroundColor: const Color.fromARGB(255, 248, 0, 0),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
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
                child: TextFormField(
                  controller: _controllerPhone,
                  validator: RequiredValidator(errorText: "กรุณากรอกเบอร์"),
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
                    errorStyle: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                  keyboardType: TextInputType.phone,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                margin: const EdgeInsets.all(15),
                child: TextFormField(
                  validator: RequiredValidator(errorText: "กรุณาใส่รหัสผ่าน"),
                  controller: _controllerPass,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                        icon: Icons_remove_red_eye != "Close"
                            ? const Icon(
                                Icons.visibility_off,
                                color: Colors.white,
                              )
                            : const Icon(
                                Icons.visibility,
                                color: Colors.white,
                              ),
                        onPressed: () {
                          setState(() {
                            if (Icons_remove_red_eye == "Open") {
                              Icons_remove_red_eye = 'Close';
                            } else {
                              Icons_remove_red_eye = 'Open';
                            }
                          });
                        }),
                    labelText: 'Password',
                    labelStyle: const TextStyle(color: Colors.white),
                    enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(width: 1, color: Colors.white),
                    ),
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(width: 3, color: Colors.white),
                    ),
                    errorStyle:
                        const TextStyle(color: Colors.white, fontSize: 14),
                  ),
                  keyboardType: Icons_remove_red_eye == "Close"
                      ? TextInputType.visiblePassword
                      : TextInputType.text,
                  obscureText: Icons_remove_red_eye == "Close" ? true : false,
                  enableSuggestions:
                      Icons_remove_red_eye == "Close" ? false : true,
                  autocorrect: Icons_remove_red_eye == "Close" ? false : true,
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
                    onPressed: () async {
                      String msg = await login(
                          _controllerPhone.text, _controllerPass.text);
                      if (msg == '0') {
                        ScaffoldMessenger.of(context).showSnackBar(
                          snackBarSos(
                            context,
                           const Text(
                              'Login Success',
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                            Colors.white,
                            115,
                          ),
                        );
                        // ignore: use_build_context_synchronously
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return const MyApp();
                            },
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          snackBarSos(
                            context,
                            Text(
                              msg,
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                            Colors.white,
                            115,
                          ),
                        );
                        // Fluttertoast.showToast(
                        //   msg: msg,
                        //   gravity: ToastGravity.TOP_RIGHT,
                        //   //backgroundColor: Colors.red,
                        // );
                      }
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
