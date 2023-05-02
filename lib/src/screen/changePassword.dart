import 'dart:convert';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sos/main.dart';
import 'package:sos/src/model/accounts/response.dart';
import 'package:sos/src/model/accounts/signup.dart';
import 'package:sos/src/provider/config.dart';
import 'package:sos/src/screen/LoadingPage.dart';
import 'package:sos/src/sharedInfo/user.dart';

import 'home.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({Key? key}) : super(key: key);

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final _formKey = GlobalKey<FormState>();

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 500), () async {
      await _getNameProfile();
    });
  }

  String _token = '';

  _getNameProfile() async {
    var token = await getUserTokenSf();
    setState(() {
      _token = token;
      isLoading = true;
    });
  }

  String _OldPassword = '';
  String _NewPassword = '';
  String _confirmPassword = '';

  late ChangePassword changePassword;
  bool isPasswordError = true;

  void setDataUserInfo() {
    if (_NewPassword != _confirmPassword || _NewPassword == '' || _confirmPassword == '') {
      setState(() {
        isPasswordError = false;
      });
    } else {
      setState(() {
        isPasswordError = true;
      });

      setState(() {
        changePassword = ChangePassword(
          oldPassword: _OldPassword,
          newPassword: _NewPassword,
          confirmPassword: _confirmPassword,
        );
      });
    }

    changePasswordInfo();
  }

  Future<ReturnResponse> changePasswordInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String id = prefs.getString('id') ?? '';
    String url = '${urlAccount}user/changePassword/${id}';
    final response = await http.put(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${_token}'
      },
      body: jsonEncode(changePassword),
    );

    if (response.statusCode == 200) {
      await removeValues();

      // ignore: use_build_context_synchronously
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return const MyApp();
      }));

      return ReturnResponse.fromJson(jsonDecode(response.body));
    } else {
      // print(response.body);
      var dataResponse = jsonDecode(response.body);

      throw Exception(dataResponse);
    }
  }

  @override
  Widget build(BuildContext context) => isLoading == false
      ? const LoadingPage()
      : Scaffold(
          backgroundColor: const Color.fromARGB(255, 255, 255, 255),
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
            toolbarHeight: 70,
            automaticallyImplyLeading: false,
            iconTheme: const IconThemeData(
              color: Colors.black, // <-- SEE HERE
            ),
            leading:
                const BackButton(color: Color.fromARGB(255, 255, 255, 255)),
            titleSpacing: 0,
            backgroundColor: const Color.fromARGB(255, 248, 0, 0),
            elevation: 0,
            title: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                          child: const Text(
                            'ChangePassword',
                            style: TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255),
                              fontSize: 29.8,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                          child: const Text(
                            'Please enter your Password',
                            style: TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255),
                              fontSize: 17,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(0),
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.fromLTRB(30, 15, 30, 0),
                        child: isPasswordError == false
                            ? const Text(
                                "*** Password and Confirm Password do not match.",
                                style: TextStyle(
                                  color: Color.fromARGB(255, 245, 18, 18),
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            : const Text(
                                "Set Password.",
                                style: TextStyle(
                                  color: Color.fromARGB(255, 0, 0, 0),
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      ),
                      Container(
                        padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter OldPassword *';
                            }
                          },
                          decoration: const InputDecoration(
                            labelText: 'OldPassword.',
                            labelStyle: TextStyle(
                                color: Color.fromARGB(255, 93, 93, 93)),
                            // helperText: 'Ex. 0812345678',
                            // helperStyle: TextStyle(color: Colors.white),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  width: 1,
                                  color: Color.fromARGB(255, 114, 114, 114)),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  width: 1,
                                  color: Color.fromARGB(255, 87, 87, 87)),
                            ),
                          ),
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: true,
                          enableSuggestions: false,
                          autocorrect: false,
                          style: const TextStyle(color: Colors.black),
                          onChanged: (value) => setState(
                            () {
                              _OldPassword = value;
                            },
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter NewPassword *';
                            }
                          },
                          decoration: const InputDecoration(
                            labelText: 'NewPassword.',
                            labelStyle: TextStyle(
                                color: Color.fromARGB(255, 93, 93, 93)),
                            // helperText: 'Ex. 0812345678',
                            // helperStyle: TextStyle(color: Colors.white),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  width: 1,
                                  color: Color.fromARGB(255, 114, 114, 114)),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  width: 1,
                                  color: Color.fromARGB(255, 87, 87, 87)),
                            ),
                          ),
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: true,
                          enableSuggestions: false,
                          autocorrect: false,
                          style: const TextStyle(color: Colors.black),
                          onChanged: (value) => setState(
                            () {
                              _NewPassword = value;
                            },
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter Password *';
                            }
                          },
                          decoration: const InputDecoration(
                            labelText: 'Confirm Password.',
                            labelStyle: TextStyle(
                                color: Color.fromARGB(255, 93, 93, 93)),
                            // helperText: 'Ex. 0812345678',
                            // helperStyle: TextStyle(color: Colors.white),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  width: 1,
                                  color: Color.fromARGB(255, 114, 114, 114)),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  width: 1,
                                  color: Color.fromARGB(255, 87, 87, 87)),
                            ),
                          ),
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: true,
                          enableSuggestions: false,
                          autocorrect: false,
                          style: const TextStyle(color: Colors.black),
                          onChanged: (value) => setState(
                            () {
                              _confirmPassword = value;
                            },
                          ),
                        ),
                      ),
                      Center(
                        child: Container(
                          padding: const EdgeInsets.fromLTRB(0, 45, 0, 50),
                          child: SizedBox(
                            width: 312.48,
                            height: 63.4,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.black),
                                shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.29),
                                    side: const BorderSide(
                                        width: 3, color: Colors.black),
                                  ),
                                ),
                              ),
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  setDataUserInfo();
                                }
                              },
                              child: const Text(
                                "Save",
                                style: TextStyle(fontSize: 24),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
}
