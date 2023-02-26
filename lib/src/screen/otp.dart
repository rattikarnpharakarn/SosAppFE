import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:sos/src/screen/signup.dart';

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sos/src/screen/signupPhoneNumber.dart';
import 'dart:developer' as developer;

import '../model/signup.dart';

class OTP extends StatefulWidget {
  const OTP({Key? key, required this.data}) : super(key: key);

  final Param data;

  @override
  State<OTP> createState() => _OTPState();
}

class _OTPState extends State<OTP> {
  final TextEditingController _controllerBox1 = TextEditingController();
  final TextEditingController _controllerBox2 = TextEditingController();
  final TextEditingController _controllerBox3 = TextEditingController();
  final TextEditingController _controllerBox4 = TextEditingController();

  Future<Data>? _futureOTP;
  String _Box1 = '';
  String _Box2 = '';
  String _Box3 = '';
  String _Box4 = '';

  @override
  void initState() {
    super.initState();
    _controllerBox1.addListener(() {
      setState(() {
        _Box1 = _controllerBox1.text;
      });
    });
    _controllerBox2.addListener(() {
      setState(() {
        _Box2 = _controllerBox2.text;
      });
    });

    _controllerBox3.addListener(() {
      setState(() {
        _Box3 = _controllerBox3.text;
      });
    });

    _controllerBox4.addListener(() {
      setState(() {
        _Box4 = _controllerBox4.text;
      });
    });
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _controllerBox1.dispose();
    _controllerBox2.dispose();
    _controllerBox3.dispose();
    _controllerBox4.dispose();

    super.dispose();
  }

  Future<Data> verifyOTP(
      String box1, String box2, String box3, String box4) async {
    final otpValue =
        box1.toString() + box2.toString() + box3.toString() + box4.toString();
    final response = await http.post(
      Uri.parse('http://10.0.2.2:80/SosApp/accounts/verifyOTP'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'otp': otpValue,
        'phoneNumber': widget.call().data.phone,
        'verifyCode': widget.call().data.verifyCode['verifyCode'].toString(),
      }),
    );

    final UserInfo userinfo = UserInfo(
      phoneNumber: widget.call().data.phone,
      birthday: '',
      confirmPassword: '',
      email: '',
      firstName: '',
      gender: '',
      imageProfile: '',
      lastName: '',
      password: '',
      pathImage: '',
      textIDCard: '',
      address: '',
      country: '',
      district: '',
      postalCode: '',
      province: '',
      subDistrict: '',
      otp: otpValue,
      verifyCode: widget.call().data.verifyCode['verifyCode'].toString(),
    );

    if (response.statusCode == 200) {
      // ignore: use_build_context_synchronously
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) {
          return Signup(
            userInfo: userinfo,
          );
        }),
      );
      return Data.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to create album.');
    }
  }

  @override
  Widget build(BuildContext context) {
    developer.log('in');
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 248, 0, 0),
      appBar: AppBar(
        titleSpacing: 0,
        backgroundColor: const Color.fromARGB(255, 248, 0, 0),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Form(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                textDirection: TextDirection.ltr,
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.fromLTRB(10, 100, 10, 0),
                    child: const Text(
                      // widget.data.verifyCode['verifyCode'].toString(),
                      "OTP",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 45,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: const Text(
                      "Please enter your number to request OTP",
                      style: TextStyle(
                        color: Color.fromARGB(156, 255, 255, 255),
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                    margin: const EdgeInsets.all(15),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            height: 68,
                            width: 64,
                            child: TextField(
                              controller: _controllerBox1,
                              decoration: const InputDecoration(
                                filled: true,
                                fillColor: Color.fromARGB(255, 255, 255, 255),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 3,
                                      color: Color.fromARGB(
                                          255, 255, 255, 255)), //<-- SEE HERE
                                ),
                              ),
                              onChanged: (value) {
                                if (value.length == 1) {
                                  FocusScope.of(context).nextFocus();
                                }
                              },
                              style: Theme.of(context).textTheme.headline4,
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(1),
                                FilteringTextInputFormatter.digitsOnly
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 68,
                            width: 64,
                            child: TextField(
                              controller: _controllerBox2,
                              decoration: const InputDecoration(
                                filled: true,
                                fillColor: Color.fromARGB(255, 255, 255, 255),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 3,
                                      color: Color.fromARGB(
                                          255, 255, 255, 255)), //<-- SEE HERE
                                ),
                              ),
                              onChanged: (value) {
                                if (value.length == 1) {
                                  FocusScope.of(context).nextFocus();
                                }
                              },
                              style: Theme.of(context).textTheme.headline4,
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(1),
                                FilteringTextInputFormatter.digitsOnly
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 68,
                            width: 64,
                            child: TextField(
                              controller: _controllerBox3,
                              decoration: const InputDecoration(
                                filled: true,
                                fillColor: Color.fromARGB(255, 255, 255, 255),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 3,
                                      color: Color.fromARGB(
                                          255, 255, 255, 255)), //<-- SEE HERE
                                ),
                              ),
                              onChanged: (value) {
                                if (value.length == 1) {
                                  FocusScope.of(context).nextFocus();
                                }
                              },
                              style: Theme.of(context).textTheme.headline4,
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(1),
                                FilteringTextInputFormatter.digitsOnly
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 68,
                            width: 64,
                            child: TextField(
                              controller: _controllerBox4,
                              onChanged: (value) {
                                if (value.length == 1) {
                                  FocusScope.of(context).nextFocus();
                                }
                              },
                              decoration: const InputDecoration(
                                filled: true,
                                fillColor: Color.fromARGB(255, 255, 255, 255),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 3,
                                      color: Color.fromARGB(
                                          255, 255, 255, 255)), //<-- SEE HERE
                                ),
                              ),
                              style: Theme.of(context).textTheme.headline4,
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(1),
                                FilteringTextInputFormatter.digitsOnly
                              ],
                            ),
                          )
                        ]),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
                    child: SizedBox(
                      width: double.infinity,
                      height: 63.4,
                      child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.black),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.29),
                                    side: const BorderSide(
                                        width: 3, color: Colors.black)))),
                        onPressed: () {
                          setState(() {
                            _futureOTP = verifyOTP(
                                _controllerBox1.text,
                                _controllerBox2.text,
                                _controllerBox3.text,
                                _controllerBox4.text);
                          });
                        },
                        child: const Text(
                          "Continue",
                          style: TextStyle(fontSize: 24),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          TextButton(
                            child: const Text(
                              'Send OTP',
                              style: TextStyle(
                                fontSize: 19,
                                color: Colors.white,
                                decoration: TextDecoration.underline,
                                height: 1,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            onPressed: () {},
                          ),
                        ]),
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}

class Data {
  final String data;

  const Data({required this.data});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      data: json['data'],
    );
  }
}
