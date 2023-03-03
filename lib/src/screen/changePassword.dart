import 'dart:convert';
import 'package:flutter/material.dart';


import 'package:http/http.dart' as http;
import 'package:sos/src/model/signup.dart';

import 'home.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({Key? key}) : super(key: key);

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {

  final _formKey = GlobalKey<FormState>();

  String _OldPassword = '';
  String _NewPassword = '';
  String _confirmPassword = '';

  late ChangePassword changePassword;
  bool isPasswordError = true;
  void setDataUserInfo() {
    if (_NewPassword != _confirmPassword) {
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

      // createUserInfo();

      // print('======> UserInfo  <======\n');
      // print('phoneNumber : ' + userInfoRes!.phoneNumber);
      // print('password :' + userInfoRes!.password);
      // print('confirmPassword : ' + userInfoRes!.confirmPassword);
      // print('firstName : ' + userInfoRes!.firstName);
      // print('lastName : ' + userInfoRes!.lastName);
      // print('email : ' + userInfoRes!.email);
      // print('birthday : ' + userInfoRes!.birthday);
      // print('gender : ' + userInfoRes!.gender);
      // print('imageProfile : ' + userInfoRes!.imageProfile);
      // print('======> UserInfo  <======\n');

      // print('======> idCard  <======\n');
      // print('pathImage : ' + userInfoRes!.idCard.pathImage);
      // print('textIDCard : ' + userInfoRes!.idCard.textIDCard);
      // print('======> idCard  <======\n');

      // print('======> address  <======\n');
      // print('address : ' + userInfoRes!.address.address);
      // print('country : ' + userInfoRes!.address.country);
      // print('district : ' + userInfoRes!.address.district);
      // print('postalCode : ' + userInfoRes!.address.postalCode);
      // print('province : ' + userInfoRes!.address.province);
      // print('subDistrict : ' + userInfoRes!.address.subDistrict);
      // print('======> address  <======\n');

      // print('======> verify  <======\n');
      // print('otp : ' + userInfoRes!.verify.otp);
      // print('verifyCode : ' + userInfoRes!.verify.verifyCode);
      // print('======> verify  <======\n');

    }
  }
  //
  // Future<ReturnResponse> createUserInfo() async {
  //   final response = await http.post(
  //     Uri.parse('http://10.0.2.2:80/SosApp/accounts/createUser'),
  //     headers: <String, String>{
  //       'Content-Type': 'application/json; charset=UTF-8',
  //     },
  //     body: jsonEncode(userInfoRes),
  //   );
  //
  //   if (response.statusCode == 200) {
  //     print(response.body);
  //     // ignore: use_build_context_synchronously
  //     Navigator.push(context, MaterialPageRoute(builder: (context) {
  //       return const Home();
  //     }));
  //
  //     return ReturnResponse.fromJson(jsonDecode(response.body));
  //   } else {
  //     // print(response.body);
  //     var dataResponse = jsonDecode(response.body);
  //
  //     throw Exception(dataResponse);
  //   }
  // }

  // upload Image to base64

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        toolbarHeight: 70,
        automaticallyImplyLeading: false,
        iconTheme: const IconThemeData(
          color: Colors.black, // <-- SEE HERE
        ),
        leading: const BackButton(color: Color.fromARGB(255, 255, 255, 255)),
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
                      decoration: const InputDecoration(
                        labelText: 'OldPassword.',
                        labelStyle:
                        TextStyle(color: Color.fromARGB(255, 93, 93, 93)),
                        // helperText: 'Ex. 0812345678',
                        // helperStyle: TextStyle(color: Colors.white),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              width: 1,
                              color: Color.fromARGB(255, 114, 114, 114)),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              width: 1, color: Color.fromARGB(255, 87, 87, 87)),
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
                      decoration: const InputDecoration(
                        labelText: 'NewPassword.',
                        labelStyle:
                        TextStyle(color: Color.fromARGB(255, 93, 93, 93)),
                        // helperText: 'Ex. 0812345678',
                        // helperStyle: TextStyle(color: Colors.white),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              width: 1,
                              color: Color.fromARGB(255, 114, 114, 114)),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              width: 1, color: Color.fromARGB(255, 87, 87, 87)),
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
                    child: TextField(
                      decoration: const InputDecoration(
                        labelText: 'Confirm Password.',
                        labelStyle:
                        TextStyle(color: Color.fromARGB(255, 93, 93, 93)),
                        // helperText: 'Ex. 0812345678',
                        // helperStyle: TextStyle(color: Colors.white),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              width: 1,
                              color: Color.fromARGB(255, 114, 114, 114)),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              width: 1, color: Color.fromARGB(255, 87, 87, 87)),
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
                            setDataUserInfo();
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
}

