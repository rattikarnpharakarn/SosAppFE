// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sos/main.dart';
import 'package:sos/src/provider/accounts/login.dart';
import 'package:sos/src/provider/config.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sos/src/screen/common/snack_bar_sos.dart';
import 'package:sos/src/screen/user/uploadIDCard.dart';
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
                      List<String> msg = await login(
                          _controllerPhone.text, _controllerPass.text);
                      if (msg[0] == "0") {
                        print(1);
                        if (msg[1] != "") {
                          print(2);
                          showCupertinoModalPopup<void>(
                            context: context,
                            builder: (BuildContext context) {
                              return Container(
                                padding: const EdgeInsets.all(1),
                                child: Center(
                                  child: Card(
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    child: Container(
                                      margin: const EdgeInsets.all(10),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          Container(
                                            padding: const EdgeInsets.all(5),
                                            child: const Text(
                                              'ข้อมูลของคุณไม่ผ่านการยืนยันตัวตน',
                                              style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.black,
                                                decoration: TextDecoration.none,
                                                decorationStyle:
                                                    TextDecorationStyle.double,
                                                fontWeight: FontWeight.w300,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            padding: const EdgeInsets.all(5),
                                            child: Text(
                                              'เหตุผล : ${msg[1]}',
                                              style: const TextStyle(
                                                fontSize: 18,
                                                color: Colors.black,
                                                decoration: TextDecoration.none,
                                                decorationStyle:
                                                    TextDecorationStyle.double,
                                                fontWeight: FontWeight.w300,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                                            child:const Text(
                                              'ต้องการอัพเดทข้อมูล ใช่หรือไม่',
                                              style:  TextStyle(
                                                fontSize: 18,
                                                color: Colors.black,
                                                decoration: TextDecoration.none,
                                                decorationStyle:
                                                TextDecorationStyle.double,
                                                fontWeight: FontWeight.w300,
                                              ),
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Container(
                                                padding:
                                                    const EdgeInsets.all(1),
                                                child: ElevatedButton(
                                                  style: const ButtonStyle(
                                                      backgroundColor:
                                                          MaterialStatePropertyAll<
                                                                  Color>(
                                                              Colors.red)),
                                                  child: const Text(
                                                    'ไม่',
                                                    style:
                                                        TextStyle(fontSize: 16),
                                                  ),
                                                  onPressed: () =>
                                                      Navigator.pop(context),
                                                ),
                                              ),
                                              Container(
                                                padding:
                                                    const EdgeInsets.all(10),
                                              ),
                                              Container(
                                                padding:
                                                    const EdgeInsets.all(1),
                                                child: ElevatedButton(
                                                  style: const ButtonStyle(
                                                    backgroundColor:
                                                        MaterialStatePropertyAll<
                                                                Color>(
                                                            Colors.green),
                                                  ),
                                                  child: const Text(
                                                    'ใช่',
                                                    style:
                                                        TextStyle(fontSize: 16),
                                                  ),
                                                  onPressed: () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) {
                                                          return UploadIDCard(
                                                            username:
                                                                _controllerPhone
                                                                    .text
                                                                    .toString(),
                                                            password:
                                                                _controllerPass
                                                                    .text
                                                                    .toString(),
                                                          );
                                                        },
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            snackBarSos(
                                context,
                                const Text(
                                  'Login Success',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                                Colors.white),
                          );
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return const MyApp();
                              },
                            ),
                          );
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          snackBarSos(
                              context,
                              Text(
                                msg[1],
                                style:
                                    TextStyle(color: Colors.red, fontSize: 16),
                              ),
                              Colors.white),
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
